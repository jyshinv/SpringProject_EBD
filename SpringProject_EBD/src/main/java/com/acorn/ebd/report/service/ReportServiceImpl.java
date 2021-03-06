package com.acorn.ebd.report.service;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.exception.DBFailException;
import com.acorn.ebd.report.dao.ReportCmtDao;
import com.acorn.ebd.report.dao.ReportDao;
import com.acorn.ebd.report.dto.ReportCmtDto;
import com.acorn.ebd.report.dto.ReportDto;

@Service
public class ReportServiceImpl implements ReportService{
	
	@Autowired
	private ReportDao dao;
	
	@Autowired
	private ReportCmtDao cmtdao;
	
   //html요소를 없애주는 메소드 
   public String replaceInfo(String info) {
      String binfo=null;
      if(info !=null) {
         binfo=info.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
      }
      return binfo;
   }
   
   //★횡단관심사로 구현해보기★
   @Override
   public void replaceInfo(String booktitle, String author, String link, ModelAndView mView) {
      String btitle=replaceInfo(booktitle);
      String bauthor=replaceInfo(author);
      String blink=replaceInfo(link);
      mView.addObject("booktitle",btitle);
      mView.addObject("author",bauthor);  
      mView.addObject("link", blink);
      mView.setViewName("my_report/private/insertform");
   }


	@Override
	public void saveContent(ReportDto dto, HttpServletRequest request) {
		//업로드된 파일의 정보를 가지고 있는 MultipartFile 객체의 참조값 얻어오기 
		MultipartFile myFile=dto.getImage();
		//원본 파일명
		String orgFileName=myFile.getOriginalFilename();
		
		// webapp/upload 폴더 까지의 실제 경로(서버의 파일시스템 상에서의 경로)
		String realPath=request.getServletContext().getRealPath("/upload");
		//저장할 파일의 상세 경로
		String filePath=realPath+File.separator;
		//디렉토리를 만들 파일 객체 생성
		File upload=new File(filePath);
		if(!upload.exists()) {//만일 디렉토리가 존재하지 않으면 
			upload.mkdir(); //만들어 준다.
		}
		//저장할 파일 명을 구성한다. (겹치는 파일명이 없도록 한다)
		String saveFileName=
				System.currentTimeMillis()+orgFileName;
		try {
			//upload 폴더에 파일을 저장한다.
			myFile.transferTo(new File(filePath+saveFileName));
			System.out.println(filePath+saveFileName);
		}catch(Exception e) {
			e.printStackTrace();
		}
		//dto에 업로드 된 파일의 정보 담기
		String writer=(String)request.getSession().getAttribute("nick");//나중에 nick 으로 받기?
		dto.setWriter(writer);
		dto.setImgpath("/upload/"+saveFileName);
		//ReportDao 를 이용해서 DB에 저장하기
		dao.insert(dto);
		
	}

	@Override
	public void getList(ModelAndView mView, HttpServletRequest request) {
		//한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT=8;
		//하단 페이지를 몇개씩 표시할 것인지
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
		[ 검색 키워드에 관련된 처리 ]
		-검색 키워드가 파라미터로 넘어올수도 있고 안넘어 올수도 있다.		
		*/
		String keyword=request.getParameter("keyword");
		String condition=request.getParameter("condition");
		//만일 키워드가 넘어오지 않는다면 
		if(keyword==null){
			//키워드와 검색 조건에 빈 문자열을 넣어준다. 
			//클라이언트 웹브라우저에 출력할때 "null" 을 출력되지 않게 하기 위해서  
			keyword="";
			condition=""; 
		}
		
		//특수기호를 인코딩한 키워드를 미리 준비한다. 
		String encodedK=URLEncoder.encode(keyword);
		
		ReportDto dto=new ReportDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		//ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
		List<ReportDto> list=null;
		//전체 row 의 갯수를 담을 지역변수를 미리 만든다.
		int totalRow=0;
		//만일 검색 키워드가 넘어온다면 
		if(!keyword.equals("")){
			//검색 조건이 무엇이냐에 따라 분기 하기
			if(condition.equals("booktitle_author")){//제목 + 내용 검색인 경우
				//검색 키워드를 CafeDto 에 담아서 전달한다.
				dto.setBooktitle(keyword);
				dto.setAuthor(keyword);
				
			}else if(condition.equals("booktitle")){ //제목 검색인 경우
				dto.setBooktitle(keyword);
				
			}else if(condition.equals("author")){ //작성자 검색인 경우
				dto.setAuthor(keyword);
				
			} // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
		}
		
		//로그인된 아이디의 nick 정보 불러오기
		String nick=(String)request.getSession().getAttribute("nick");
		dto.setNick(nick);

		list=dao.getList(dto);
		
		//원본 파일명을 얻기 위해 원본파일명을 filename에 담아주는 작업을 한다.
		//이때 원본 파일명이 ""와 같으면 요청한 페이지에 emptyImg로 비교해서 기본이미지를 넣도록 한다.
		for(ReportDto tmp : list) {
			String filename=tmp.getImgpath().substring(21);
			//System.out.println("리스트 filename"+filename);
			//filename이 ""와 같으면 이미지 첨부를 안한 상태이다. imgpath에 emptyImg라고 넣어준다. 
			if(filename.equals("")) {
				tmp.setImgpath("emptyImg");
			}
		}
		
	    
		//글의 갯수
		totalRow=dao.getCountTotal(dto);
		
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
		
		mView.addObject("list", list);
		mView.addObject("pageNum", pageNum);
		mView.addObject("startPageNum", startPageNum);
		mView.addObject("endPageNum", endPageNum);
		mView.addObject("totalPageCount", totalPageCount);
		mView.addObject("condition", condition);
		mView.addObject("keyword", keyword);
		mView.addObject("encodedK", encodedK);
		mView.addObject("totalRow", totalRow);		
	}
	//비공개 독후감 디테일
	@Override
	public void getDetail(ReportDto dto, ModelAndView mView, HttpSession session) {
		//현재 로그인 되어있는 유저의 닉네임 저장
	    String nick=(String)session.getAttribute("nick");
	    dto.setNick(nick);
	    
		ReportDto dto1=dao.getData(dto);
		mView.addObject("dto", dto1);
		dao.addViewCount(dto);
		/* 아래는 댓글 페이징 처리 관련 비즈니스 로직 입니다.*/
		final int PAGE_ROW_COUNT=5;

		//보여줄 페이지의 번호
		int pageNum=1;

		//보여줄 페이지 데이터의 시작 ResultSet row 번호
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지 데이터의 끝 ResultSet row 번호
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		
		String filename=dto1.getImgpath().substring(21);
		
		mView.addObject("filename",filename);
	}

	@Override
	public void deleteContent(int num) {
		dao.delete(num);
		
	}

	@Override
	public void updatepublicck(ReportDto dto) {
		dao.updatepublicck(dto);
		
	}

	@Override
	public void getPublicList(ModelAndView mView, HttpServletRequest request) {
		//한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT=9;
		//하단 페이지를 몇개씩 표시할 것인지
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
		[ 검색 키워드에 관련된 처리 ]
		-검색 키워드가 파라미터로 넘어올수도 있고 안넘어 올수도 있다.		
		*/
		String keyword=request.getParameter("keyword");
		String condition=request.getParameter("condition");
		//만일 키워드가 넘어오지 않는다면 
		if(keyword==null){
			//키워드와 검색 조건에 빈 문자열을 넣어준다. 
			//클라이언트 웹브라우저에 출력할때 "null" 을 출력되지 않게 하기 위해서  
			keyword="";
			condition=""; 
		}
		
		//특수기호를 인코딩한 키워드를 미리 준비한다. 
		String encodedK=URLEncoder.encode(keyword);
		
		ReportDto dto=new ReportDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		//ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
		List<ReportDto> list=null;
		//전체 row 의 갯수를 담을 지역변수를 미리 만든다.
		int totalRow=0;
		//만일 검색 키워드가 넘어온다면 
		if(!keyword.equals("")){
			//검색 조건이 무엇이냐에 따라 분기 하기
			if(condition.equals("booktitle_author")){//제목 + 내용 검색인 경우
				//검색 키워드를 CafeDto 에 담아서 전달한다.
				dto.setBooktitle(keyword);
				dto.setAuthor(keyword);
				
			}else if(condition.equals("booktitle")){ //제목 검색인 경우
				dto.setBooktitle(keyword);
				
			}else if(condition.equals("author")){ //작성자 검색인 경우
				dto.setAuthor(keyword);
				
			} // 다른 검색 조건을 추가 하고 싶다면 아래에 else if() 를 계속 추가 하면 된다.
		}
		
		dto.setPublicck("public");
		
		list=dao.getPublicList(dto);
		//글의 갯수
		totalRow=dao.getCount(dto);
		
		//원본 파일명을 얻기 위해 원본파일명을 filename에 담아주는 작업을 한다.
		//이때 원본 파일명이 ""와 같으면 요청한 페이지에 emptyImg로 비교해서 기본이미지를 넣도록 한다.
		for(ReportDto tmp : list) {
			String filename=tmp.getImgpath().substring(21);
			//System.out.println("리스트 filename"+filename);
			//filename이 ""와 같으면 이미지 첨부를 안한 상태이다. imgpath에 emptyImg라고 넣어준다. 
			if(filename.equals("")) {
				tmp.setImgpath("emptyImg");
			}
		}
		
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
	    List<Integer> isHeartClickList=null;
	    List<Integer> heartCntList=null;
	    //하트 정보(로그인 중일때만)
	    //nick이 null인채로 episodedao.getHeartInfo()를 호출하면 select문에 전달하는 paramater가 null이 되어버려 오류가 생긴다.
	    if(nick != null) {
	       isHeartClickList=dao.getHeartInfo(dto);         
	    }
	    //총 하트 개수 정보를 리턴해주는 메소드
	    heartCntList=dao.getHeartCnt(dto);
		
		mView.addObject("list", list);
		mView.addObject("pageNum", pageNum);
		mView.addObject("startPageNum", startPageNum);
		mView.addObject("endPageNum", endPageNum);
		mView.addObject("totalPageCount", totalPageCount);
		mView.addObject("condition", condition);
		mView.addObject("keyword", keyword);
		mView.addObject("encodedK", encodedK);
		mView.addObject("totalRow", totalRow);		
		mView.addObject("isHeartClickList", isHeartClickList);
	    mView.addObject("heartCntList",heartCntList);
	}

	@Override
	public void saveComment(HttpServletRequest request) {
		//댓글 작성자
		String writer=(String)request.getSession().getAttribute("nick");
		//폼 전송되는 댓글의 정보 얻어내기
		int ref_group=Integer.parseInt(request.getParameter("ref_group"));
		String target_nick=request.getParameter("target_nick");
		String content=request.getParameter("content");
		/*
		 * 원글의 댓글은 comment_group 번호가 전송 안되고
		 * 댓글의 댓글은 comment_group 번호가 전송이 된다. ***
		 * 따라서 null 여부를 조사하면 원글의 댓글인지 댓글의 댓글인지 판별할 수 있다.
		 */
		String cmt_group=request.getParameter("cmt_group");
		//새 댓글의 글번호는 미리 얻어낸다.
		int seq=cmtdao.getSequence();
		//저장할 새 댓글 정보를 dto 에 담기
		ReportCmtDto dto=new ReportCmtDto();
		dto.setNum(seq);
		dto.setWriter(writer);
		dto.setTarget_nick(target_nick);
		dto.setContent(content);
		dto.setRef_group(ref_group);
		if(cmt_group==null) {//원글의 댓글인 경우
			//댓글의 글번호 와 comment_group 번호를 같게 한다.
			dto.setCmt_group(seq);
		}else {//댓글의 댓글인 경우
			//폼 전송된 comment_group 번호를 숫자로 바꿔서 dto 에 넣어준다.
			dto.setCmt_group(Integer.parseInt(cmt_group));
		}
		//댓글 정보를 DB 에 저장한다.
		cmtdao.insert(dto);
		
	}

	@Override
	public void deleteComment(HttpServletRequest request) {
		//GET 방식 파라미터로 전달되는 삭제할 댓글 번호 
		int num=Integer.parseInt(request.getParameter("num"));
		//세션에 저장된 로그인된 아이디
		String nick=(String)request.getSession().getAttribute("nick");
		//댓글의 정보를 얻어와서 댓글의 작성자와 같은지 비교 한다.
		String writer=cmtdao.getData(num).getWriter();
		if(!writer.equals(nick)) {
			throw new DBFailException("남의 댓글을 삭제할수 없습니다.");
		}
		cmtdao.delete(num);			
		
	}

	@Override
	public void updateComment(ReportCmtDto dto) {
		cmtdao.update(dto);
		
	}

	@Override
	public void moreCommentList(HttpServletRequest request) {
		//파라미터로 전달된 pageNum 과 ref_group 번호를 읽어온다. 
		int pageNum=Integer.parseInt(request.getParameter("pageNum"));
		int ref_group=Integer.parseInt(request.getParameter("ref_group"));
		
		ReportDto dto2=new ReportDto();
		dto2.setNum(ref_group);
		/*getData 로 하면 cmt 를 받아주는 곳이 없기 때문에 댓글 로딩바 오류가 난다.*/
		ReportDto dto=dao.getPublicData(dto2);
		request.setAttribute("dto", dto);

		/* 아래는 댓글 페이징 처리 관련 비즈니스 로직 입니다.*/
		final int PAGE_ROW_COUNT=5;

		//보여줄 페이지 데이터의 시작 ResultSet row 번호
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지 데이터의 끝 ResultSet row 번호
		int endRowNum=pageNum*PAGE_ROW_COUNT;

		//전체 row 의 갯수를 읽어온다.
		//자세히 보여줄 글의 번호가 ref_group  번호 이다. 
		int totalRow=cmtdao.getCount(ref_group);
		//전체 페이지의 갯수 구하기
		int totalPageCount=
				(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);

		// CafeCommentDto 객체에 위에서 계산된 startRowNum 과 endRowNum 을 담는다.
		ReportCmtDto commentDto=new ReportCmtDto();
		commentDto.setStartRowNum(startRowNum);
		commentDto.setEndRowNum(endRowNum);
		//ref_group 번호도 담는다.
		commentDto.setRef_group(ref_group);

		//DB 에서 댓글 목록을 얻어온다.
		List<ReportCmtDto> commentList=cmtdao.getList(commentDto);
		//request 에 담아준다.
		request.setAttribute("commentList", commentList);
		request.setAttribute("totalPageCount", totalPageCount);		
		
	}

	@Override
	public void updateData(ReportDto dto, HttpServletRequest request) {
		
		//선택안함을 선택한 경우 빈문자열을 넣어준다.
		if(dto.getStars().equals("선택안함")) {
			dto.setStars("");
		}
		
		//선택안함을 선택한 경우 빈문자열을 넣어준다.
		if(dto.getGenre().equals("선택안함")) {
			dto.setGenre("");
		}
		//이미지가 비어있다면 MultipartFile image는 비어있는 상태이다.
		//따라서 이미지 수정은 하지 않은 상태이므로 title과 content만 update한다. 
		if(dto.getImage().isEmpty()) {
			//이름이 중복되게 하지 않기 위해 null 사용
		     dao.updateData(dto);
		}else {//이미지가 비어있지 않으면 이미지 수정을 한 상태이므로, 기존 파일 파일시스템에서 삭제해주고 title, content, 이미지 모두 update한다. 
		 
		//실제 파일 시스템에서 파일을 삭제하는 부분
		 // imgPath 는 /upload/~~ 로 저장되어있으므로 앞에 /upload/를 잘라준다. 
		 String filename=dto.getImgpath().substring(8);
		 System.out.println(filename);
		 //기존의 파일은 파일시스템에서 삭제해준다.
		 String path=request.getServletContext().getRealPath("/upload")+File.separator+filename;
		 System.out.println("path="+path);
		 new File(path).delete();
		 
		 //실제 파일 시스템에 파일을 집어넣는 부분
		 //업로드된 파일의 정보를 가지고 있는 MultipartFile 객체의 참조값 얻어오기 
		 MultipartFile myFile=dto.getImage();
		 //원본 파일명
		 String orgFileName=myFile.getOriginalFilename();
		 // webapp/upload 폴더 까지의 실제 경로(서버의 파일시스템 상에서의 경로)
		 String realPath=request.getServletContext().getRealPath("/upload");
		 System.out.println(realPath);
		 //저장할 파일의 상세 경로
		 String filePath=realPath+File.separator;
		 //디렉토리를 만들 파일 객체 생성
		 File upload=new File(filePath);
		 if(!upload.exists()) {//만일 디렉토리가 존재하지 않으면 
		upload.mkdir(); //만들어 준다.
		 }
		 //저장할 파일 명을 구성한다.(원본파일명에 타임밀리를 찍어서 더해줌으로써 겹치는 파일명이 없도록 한다.)
		 String saveFileName=
		       System.currentTimeMillis()+orgFileName;
		 try {
		    //upload 폴더에 파일을 저장한다.
		    myFile.transferTo(new File(filePath+saveFileName));
		    System.out.println(filePath+saveFileName);
		 }catch(Exception e) {
		    e.printStackTrace();
		 }
		 
		 //dto 에 업로드된 파일의 정보를 담는다. DB 에만 값을 집어넣는 부분
		 dto.setImgpath("/upload/"+saveFileName);//새로 만들어줌.
		 dao.updateData(dto);
      }
		
	}

	@Override
	public int removeHeart(int target_num, HttpSession session) {
		  String nick=(String)session.getAttribute("nick");
	      ReportDto dto=new ReportDto();
	      dto.setNick(nick);
	      dto.setNum(target_num);
	      dao.deleteHeart(dto);
	      
	      //하트 개수 정보를 저장할 변수 heartcnt
	      int heartcnt=dao.getHeartCntDetail(target_num);
	      return heartcnt;
	}

	@Override
	public int saveHeart(int target_num, HttpSession session) {
	      String nick=(String)session.getAttribute("nick");
	      ReportDto dto=new ReportDto();
	      dto.setNick(nick);
	      dto.setNum(target_num);
	      dao.insertHeart(dto);
	      
	      //하트 개수 정보를 저장할 변수 heartcnt
	      int heartcnt=dao.getHeartCntDetail(target_num);
	      return heartcnt;
	}

	//홈화면에 좋아요 수 Best3를 불러올 메소드
	@Override
	public void getBestHeartList(ModelAndView mView) {
		List<ReportDto> list=dao.getBestHeartList();
		//원본 파일명을 얻기 위해 원본파일명을 filename에 담아주는 작업을 한다.
		//이때 원본 파일명이 ""와 같으면 요청한 페이지에 emptyImg로 비교해서 기본이미지를 넣도록 한다.
		for(ReportDto tmp : list) {
			String filename=tmp.getImgpath().substring(21);
			//System.out.println("리스트 filename"+filename);
			//filename이 ""와 같으면 이미지 첨부를 안한 상태이다. imgpath에 emptyImg라고 넣어준다. 
			if(filename.equals("")) {
				tmp.setImgpath("emptyImg");
			}
		}
		mView.addObject("reportBestList",list);
	}

	@Override
	public void getPublicDetail(ReportDto dto, ModelAndView mView, HttpSession session) {
		ReportDto dto1=dao.getPublicData(dto);
		mView.addObject("dto", dto1);
		dao.addViewCount(dto);
		/* 아래는 댓글 페이징 처리 관련 비즈니스 로직 입니다.*/
		final int PAGE_ROW_COUNT=5;

		//보여줄 페이지의 번호
		int pageNum=1;

		//보여줄 페이지 데이터의 시작 ResultSet row 번호
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지 데이터의 끝 ResultSet row 번호
		int endRowNum=pageNum*PAGE_ROW_COUNT;

		//전체 row 의 갯수를 읽어온다.
		//자세히 보여줄 글의 번호가 ref_group  번호 이다. 
		int totalRow=cmtdao.getCount(dto.getNum());
		//전체 페이지의 갯수 구하기
		int totalPageCount=
				(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);

		// CafeCommentDto 객체에 위에서 계산된 startRowNum 과 endRowNum 을 담는다.
		ReportCmtDto commentDto=new ReportCmtDto();
		commentDto.setStartRowNum(startRowNum);
		commentDto.setEndRowNum(endRowNum);
		//ref_group 번호도 담는다.
		commentDto.setRef_group(dto.getNum());
		
		//DB 에서 댓글 목록을 얻어온다.
		List<ReportCmtDto> commentList=cmtdao.getList(commentDto);
		
		String filename=dto1.getImgpath().substring(21);
		//현재 로그인 되어있는 유저의 닉네임 저장
	    String nick=(String)session.getAttribute("nick");
	    dto.setNick(nick);
	    //하트 정보를 저장할 변수 heart
	    boolean isheartclick=false;
	    if(nick != null) { //닉네임이 null이 아닐때만 getHeartInfoDatail을 호출 null일 경우 전달하는 파라메터가 null이라는 오류를 낸다.
	       isheartclick = dao.getHeartInfoDetail(dto); //해당 닉네임이 하트를 클릭했으면 target_num이 return되고, 그게 아니면 아무것도 리턴하지 않는다.
	    }
	      
	    //하트 개수 정보를 저장할 변수 heartcnt
	    int heartcnt=dao.getHeartCntDetail(dto.getNum());
		
		//ModelAndView 객체에 댓글 목록도 담아준다.
		mView.addObject("commentList", commentList);
		mView.addObject("totalPageCount", totalPageCount);	
		mView.addObject("filename",filename);
		//하트정보 
		mView.addObject("isheartclick",isheartclick);
		//하트개수 정보
		mView.addObject("heartcnt",heartcnt);
		
	}

	@Override
	public void getMyHeartList(ModelAndView mView, HttpServletRequest request) {
		//한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT=11;
		//하단 페이지를 몇개씩 표시할 것인지
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
		
		
		ReportDto dto=new ReportDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		//ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다.
		List<ReportDto> list=null;
		//전체 row 의 갯수를 담을 지역변수를 미리 만든다.
		int totalRow=0;
		
		//public 독후감이므로 public담아주기
		dto.setPublicck("public");
		//로그인된 아이디의 nick 정보 불러오기
	    String nick=(String)request.getSession().getAttribute("nick");
	    //닉네임 담아주기 
	    dto.setNick(nick);
	   
		//글목록 요청
		list=dao.getMyHeartPublicList(dto);
		//글의 갯수
		totalRow=dao.getMyHeartCount(dto);
		
		//원본 파일명을 얻기 위해 원본파일명을 filename에 담아주는 작업을 한다.
		//이때 원본 파일명이 ""와 같으면 요청한 페이지에 emptyImg로 비교해서 기본이미지를 넣도록 한다.
		for(ReportDto tmp : list) {
			String filename=tmp.getImgpath().substring(21);
			//System.out.println("리스트 filename"+filename);
			//filename이 ""와 같으면 이미지 첨부를 안한 상태이다. imgpath에 emptyImg라고 넣어준다. 
			if(filename.equals("")) {
				tmp.setImgpath("emptyImg");
			}
		}
		
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
	
		
		mView.addObject("list", list);
		mView.addObject("pageNum", pageNum);
		mView.addObject("startPageNum", startPageNum);
		mView.addObject("endPageNum", endPageNum);
		mView.addObject("totalPageCount", totalPageCount);
		mView.addObject("totalRow", totalRow);		

		
	}

}
