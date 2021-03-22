package com.acorn.ebd.wording.service;

import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.wording.dao.WordingDao;
import com.acorn.ebd.wording.dto.WordingDto;

@Service
public class WordingServiceImpl implements WordingService {
	
	@Autowired
	private WordingDao wordingdao;

	//html요소를 없애주는 replaceInfo 메소드 
	public String replaceInfo(String info) {
		//info가 null이면 NullPointerException이 발생한다. 
		String binfo=null;
		if(info !=null) {
			binfo=info.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
		}
		return binfo;
	}
	
	//★횡단관심사로 구현해보기★
	//도서 api에서 가져온 정보의 html요소를 제거하는 메소드
	@Override
	public void replaceInfo(String title, String author, ModelAndView mView) {
		//html요소 없애주기 
		String btitle=replaceInfo(title);
		String bauthor=replaceInfo(author);
		mView.addObject("title",btitle);
		mView.addObject("author",bauthor);			
	}

	//새 글을 저장하는 메소드 
	@Override
	public void saveContent(WordingDto dto, HttpSession session) {
		//sessionScope에 저장된 닉네임을 nick에 저장하고
		String nick=(String)session.getAttribute("nick");
		//닉네임을 dto의 writer에 저장한다.
		dto.setWriter(nick);
		wordingdao.insert(dto);
	}

	//글 목록과 로그인된 아이디의 하트 클릭 정보(하트테이블)을 얻어오고 페이징 처리에 필요한 값을을 ModelAndView 객체에 담아주는 메소드
	@Override
	public void getList(ModelAndView mView, HttpServletRequest request) {
		//한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT=5;
		//하단 페이지를 몇개씩 표시할 것인지 (스크롤 페이징이라 필요없음)
		final int PAGE_DISPLAY_COUNT=5;

		//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pageNum=1;
		//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
		String strPageNum=request.getParameter("pageNum");
		//만일 페이지 번호가 파라미터로 넘어 온다면
		if(strPageNum != null){
			//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
			pageNum=Integer.parseInt(strPageNum);
		}

		//보여줄 페이지의 시작 ROWNUM
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지의 끝 ROWNUM
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		
		/*
		 * 검색 키워드 관련된 처리
		 * -검색 키워드가 파라미터로 넘어올 수도 있고 안넘어올 수도 있다.
		 */
		String keyword=request.getParameter("keyword");
		String condition=request.getParameter("condition");
		//만일 키워드가 넘어오지 않는다면
		if(keyword==null){
			//키워드와 검색 조건에 빈 문자열을 넣어준다.
			keyword="";
			condition="";
		}
		//특수기호를 인코딩한 키워드를 미리 준비한다.
		String encodedK=URLEncoder.encode(keyword);

		//startRowNum 과 endRowNum  을 Wording Dto 객체에 담고
		WordingDto dto=new WordingDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);

		//WordingDao 객체를 이용해서 회원 목록을 얻어온다.
		//List<WordingDto> list=wordingdao.getList(dto);
		
		//ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
		List<WordingDto> list=null;
		//전체 row의 개수를 담을 지역변수를 미리 만든다.
		int totalRow=0;
		
		//만일 검색 키워드가 넘어온다면
		if(!keyword.equals("")) {
			//검색 조건이 무엇이냐에 따라 분기하기
			if(condition.equals("title_content")) { //제목 + 내용 검색인 경우
				//검색 키워드를 WordingDto에 담아서 전달한다.
				dto.setTitle(keyword);
				dto.setContent(keyword);
			}else if(condition.equals("title")) { //제목 검색인 경우
				dto.setTitle(keyword);
			}else if(condition.equals("writer")) { //작성자 검색인 경우
				dto.setWriter(keyword);
			}//다른 검색 조건을 추가하고 싶다면 아래 else if()를 계속 추가하면 된다. 
		}
		
		
		//위의 분기에 따라 dto에 담기는 내용이 다르고
		//그 내용을 기준으로 조건이 다를때마다 다른 내용이 select 되도록 dynamic query를 구성한다.
		//글 목록 얻어오기
		list=wordingdao.getList(dto);
		
		//글의 개수 
		totalRow=wordingdao.getCount(dto);
		
		//하단 시작 페이지 번호 
		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//하단 끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;

		
		//전체 페이지의 갯수 구하기
		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
		if(endPageNum > totalPageCount){
			endPageNum=totalPageCount; //보정해 준다. 
		}
		
		
		//로그인된 아이디의 nick 정보 불러오기
		String nick=(String)request.getSession().getAttribute("nick");
		dto.setNick(nick);
		List<Integer> heartInfoList=null;
		List<Integer> heartCntList=null;
		//하트 정보(로그인 중일때만)
		//nick이 null인채로 wordingdao.getHeartInfo()를 호출하면 select문에 전달하는 paramater가 null이 되어버려 오류가 생긴다.
		if(nick != null) {
			heartInfoList=wordingdao.getHeartInfo(dto);	
		}
		//총 하트 개수 정보를 리턴해주는 메소드(로그인 중일때만)
		heartCntList=wordingdao.getHeartCnt(dto);
		
		//view page 에서 필요한 내용을 ModelAndView 객체에 담아준다
		mView.addObject("list", list);//글 목록
		mView.addObject("heartInfoList",heartInfoList);//로그인된 아이디의 하트 테이블 정보 
		mView.addObject("totalPageCount", totalPageCount);
		mView.addObject("condition",condition);
		mView.addObject("keyword",keyword);
		mView.addObject("totalRow",totalRow);
		//pageNum 도 추가로 담아주기
		mView.addObject("pageNum", pageNum);
		mView.addObject("heartCntList",heartCntList);
		
	}
	
	//하트를 눌렀을 때 하트테이블에 저장해주는 메소드
	@Override
	public int saveHeart(int target_num, HttpSession session) {
		String nick=(String)session.getAttribute("nick");
		WordingDto dto=new WordingDto();
		dto.setNick(nick);
		dto.setNum(target_num);
		wordingdao.insertHeart(dto);
		
		//하트 개수 정보를 저장할 변수 heartcnt
		int heartcnt=wordingdao.getHeartCntDetail(target_num);
		
		return heartcnt;
	}

	//하트 해제 시 하트테이블에서 삭제해주는 메소드
	@Override
	public int removeHeart(int target_num, HttpSession session) {
		String nick=(String)session.getAttribute("nick");
		WordingDto dto=new WordingDto();
		dto.setNick(nick);
		dto.setNum(target_num);
		wordingdao.deleteHeart(dto);
		
		//하트 개수 정보를 저장할 변수 heartcnt
		int heartcnt=wordingdao.getHeartCntDetail(target_num);
		
		return heartcnt;
		
	}

	@Override
	public void getDetail(int num, ModelAndView mView) {
		WordingDto dto=wordingdao.getData(num);
		mView.addObject("dto",dto);
	}

	@Override
	public void update(WordingDto dto) {
		wordingdao.update(dto);
		
	}

	@Override
	public void delete(int num, HttpServletRequest request) {
		//AOP로 작성자가 아닌 다른 사람이 삭제하는 예외처리 막기  --> aop에서 필요한 정보 num과 request
		wordingdao.delete(num);
	}


	@Override
	public void getBestHeartList(ModelAndView mView) {
		List<WordingDto> list=wordingdao.getBestHeartList();
		mView.addObject("wordingBestList",list);
	}

	@Override
	public void getMyWriteList(ModelAndView mView, HttpServletRequest request) {
		//한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT=5;
		//하단 페이지를 몇개씩 표시할 것인지 (스크롤 페이징이라 필요없음)
		final int PAGE_DISPLAY_COUNT=5;

		//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pageNum=1;
		//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
		String strPageNum=request.getParameter("pageNum");
		//만일 페이지 번호가 파라미터로 넘어 온다면
		if(strPageNum != null){
			//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
			pageNum=Integer.parseInt(strPageNum);
		}

		//보여줄 페이지의 시작 ROWNUM
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지의 끝 ROWNUM
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		

		//startRowNum 과 endRowNum  을 Wording Dto 객체에 담고
		WordingDto dto=new WordingDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);

		//WordingDao 객체를 이용해서 회원 목록을 얻어온다.
		//List<WordingDto> list=wordingdao.getList(dto);
		
		//ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
		List<WordingDto> list=null;
		//전체 row의 개수를 담을 지역변수를 미리 만든다.
		int totalRow=0;
		
		
		//로그인된 아이디의 nick 정보 불러오기
		String nick=(String)request.getSession().getAttribute("nick");
		dto.setNick(nick);
		
		
		//위의 분기에 따라 dto에 담기는 내용이 다르고
		//그 내용을 기준으로 조건이 다를때마다 다른 내용이 select 되도록 dynamic query를 구성한다.
		//글 목록 얻어오기
		list=wordingdao.getMyList(dto);
		
		//글의 개수 
		totalRow=wordingdao.getMyCount(dto);
		
		//하단 시작 페이지 번호 
		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//하단 끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;

		
		//전체 페이지의 갯수 구하기
		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
		if(endPageNum > totalPageCount){
			endPageNum=totalPageCount; //보정해 준다. 
		}
		
		
		//view page 에서 필요한 내용을 ModelAndView 객체에 담아준다
		mView.addObject("list", list);//글 목록
		mView.addObject("totalPageCount", totalPageCount);
		mView.addObject("totalRow",totalRow);
		//pageNum 도 추가로 담아주기
		mView.addObject("pageNum", pageNum);
		
	}

	@Override
	public void getMyHeartList(ModelAndView mView, HttpServletRequest request) {
		//한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT=5;
		//하단 페이지를 몇개씩 표시할 것인지 (스크롤 페이징이라 필요없음)
		final int PAGE_DISPLAY_COUNT=5;

		//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pageNum=1;
		//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
		String strPageNum=request.getParameter("pageNum");
		//만일 페이지 번호가 파라미터로 넘어 온다면
		if(strPageNum != null){
			//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
			pageNum=Integer.parseInt(strPageNum);
		}

		//보여줄 페이지의 시작 ROWNUM
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지의 끝 ROWNUM
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		

		//startRowNum 과 endRowNum  을 Wording Dto 객체에 담고
		WordingDto dto=new WordingDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		//ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
		List<WordingDto> list=null;
		//전체 row의 개수를 담을 지역변수를 미리 만든다.
		int totalRow=0;
		
		//로그인된 아이디의 nick 정보 불러오기
		String nick=(String)request.getSession().getAttribute("nick");
		dto.setNick(nick);
		
		//위의 분기에 따라 dto에 담기는 내용이 다르고
		//그 내용을 기준으로 조건이 다를때마다 다른 내용이 select 되도록 dynamic query를 구성한다.
		//글 목록 얻어오기
		list=wordingdao.getMyHeartList(dto);
		
		//글의 개수 
		totalRow=wordingdao.getMyHeartCount(dto);
		
		//하단 시작 페이지 번호 
		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//하단 끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;

		
		//전체 페이지의 갯수 구하기
		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
		if(endPageNum > totalPageCount){
			endPageNum=totalPageCount; //보정해 준다. 
		}
		
		
		List<Integer> heartInfoList=null;
		//하트 정보(로그인 중일때만)
		//nick이 null인채로 wordingdao.getHeartInfo()를 호출하면 select문에 전달하는 paramater가 null이 되어버려 오류가 생긴다.
		if(nick != null) {
			heartInfoList=wordingdao.getMyHeartInfo(dto);	
		}
		System.out.println(list.size());
		System.out.println(heartInfoList);
		System.out.println(totalPageCount);
		System.out.println(totalRow);
		System.out.println(pageNum);

		
		//view page 에서 필요한 내용을 ModelAndView 객체에 담아준다
		mView.addObject("list", list);//글 목록
		mView.addObject("heartInfoList",heartInfoList);//로그인된 아이디의 하트 테이블 정보 
		mView.addObject("totalPageCount", totalPageCount);
		mView.addObject("totalRow",totalRow);
		//pageNum 도 추가로 담아주기
		mView.addObject("pageNum", pageNum);
		
	}
	
	

	

}
