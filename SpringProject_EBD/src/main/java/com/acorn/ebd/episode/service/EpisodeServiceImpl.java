package com.acorn.ebd.episode.service;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.episode.dao.EpisodeCmtDao;
import com.acorn.ebd.episode.dao.EpisodeDao;
import com.acorn.ebd.episode.dto.EpisodeCmtDto;
import com.acorn.ebd.episode.dto.EpisodeDto;
import com.acorn.ebd.wording.dto.WordingDto;

@Service
public class EpisodeServiceImpl implements EpisodeService {

	@Autowired
	private EpisodeDao dao;
	
	@Autowired
	private EpisodeCmtDao episodeCmtDao;

	@Override
	public void saveContent(EpisodeDto dto, HttpServletRequest request) {
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
		
		//닉네임을 세션에서 불러온다. 
		String nick=(String)request.getSession().getAttribute("nick");
		//세션에서 읽어낸 파일 업로더의 닉네임을 담는다. 
		dto.setWriter(nick); 
		//dto 에 업로드된 파일의 정보를 담는다.
		dto.setImgPath("/upload/"+saveFileName);
		
		//EpisodeDao 를 이용해서 DB 에 저장하기;
		dao.insert(dto);		
	}

	@Override
	public void getList(ModelAndView mView, HttpServletRequest request) {
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
		검색 키워드에 관련된 처리 
		 */
		String keyword=request.getParameter("keyword"); //검색 키워드
		String condition=request.getParameter("condition"); //검색 조건
		if(keyword==null){//전달된 키워드가 없다면 
			keyword=""; //빈 문자열을 넣어준다. 
			condition="";
		}
		//인코딩된 키워드를 미리 만들어 둔다. 
		String encodedK=URLEncoder.encode(keyword);

		//startRowNum 과 endRowNum  을 Episode 객체에 담고
		EpisodeDto dto=new EpisodeDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		if(!keyword.equals("")){ //만일 키워드가 넘어온다면 
			if(condition.equals("title_content")){
				//검색 키워드를 FileDto 객체의 필드에 담는다. 
				dto.setTitle(keyword);
				dto.setContent(keyword);	
			}else if(condition.equals("title")){
				dto.setTitle(keyword);
			}else if(condition.equals("writer")){
				dto.setWriter(keyword);
			}
		}

		//GalleryDao 객체를 이용해서 회원 목록을 얻어온다.
		List<EpisodeDto> list=dao.getList(dto);
		
		//원본 파일명을 얻기 위해 원본파일명을 filename에 담아주는 작업을 한다.
		//이때 원본 파일명이 ""와 같으면 요청한 페이지에 emptyImg로 비교해서 기본이미지를 넣도록 한다.
		for(EpisodeDto tmp : list) {
			String filename=tmp.getImgPath().substring(21);
			System.out.println("리스트 filename"+filename);
			//filename이 ""와 같으면 이미지 첨부를 안한 상태이다. imgpath에 emptyImg라고 넣어준다. 
			if(filename.equals("")) {
				tmp.setImgPath("emptyImg");
			}
		}

		//하단 시작 페이지 번호 
		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//하단 끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;

		//전체 row 의 갯수
		int totalRow=dao.getCount(dto);
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
		
		
		//view page 에서 필요한 내용을 ModelAndView 객체에 담아준다
		mView.addObject("list", list);
		mView.addObject("isHeartClickList", isHeartClickList);
		mView.addObject("heartCntList",heartCntList);
		mView.addObject("totalPageCount",totalPageCount);
		mView.addObject("pageNum",pageNum);
		mView.addObject("startPageNum",startPageNum);
		mView.addObject("endPageNum",endPageNum);
		mView.addObject("condition",condition);
		mView.addObject("encodedK",encodedK);
		mView.addObject("totalRow",totalRow);
		mView.addObject("keyword", keyword);
		
		
	}
	
	//하트를 눌렀을 때 하트테이블에 저장해주는 메소드
	@Override
	public int saveHeart(int target_num, HttpSession session) {
		String nick=(String)session.getAttribute("nick");
		EpisodeDto dto=new EpisodeDto();
		dto.setNick(nick);
		dto.setNum(target_num);
		dao.insertHeart(dto);
		
		//하트 개수 정보를 저장할 변수 heartcnt
		int heartcnt=dao.getHeartCntDetail(target_num);
		return heartcnt;
	}

	//하트 해제 시 하트테이블에서 삭제해주는 메소드
	@Override
	public int removeHeart(int target_num, HttpSession session) {
		String nick=(String)session.getAttribute("nick");
		EpisodeDto dto=new EpisodeDto();
		dto.setNick(nick);
		dto.setNum(target_num);
		dao.deleteHeart(dto);
		
		//하트 개수 정보를 저장할 변수 heartcnt
		int heartcnt=dao.getHeartCntDetail(target_num);
		return heartcnt;
		
	}

	//에피소드 디테일을 불러오는 메소드 
	@Override
	public void getData(EpisodeDto dto, ModelAndView mView, HttpSession session) {
		//글 정보를 불러올 getData
		EpisodeDto dataDto=dao.getData(dto);
		//글정보
		mView.addObject("dataDto",dataDto);
		//글 조회수를 증가시킨다.
		dao.addViewCount(dto.getNum());
		
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
		
		//수정폼에서 저장한 이미지의 오리지널 파일명을 불러오기 위해 문자열을 자른다.
		String filename=dataDto.getImgPath().substring(21);
		System.out.println("filename은"+	filename);
		
		
		/*아래는 댓글 펭징 처리 관련 비즈니스 로직 입니다.*/
		final int PAGE_ROW_COUNT=5;

		//보여줄 페이지의 번호
		int pageNum=1;

		//보여줄 페이지 데이터의 시작 ResultSet row 번호
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지 데이터의 끝 ResultSet row 번호
		int endRowNum=pageNum*PAGE_ROW_COUNT;

		//전체 row 의 갯수를 읽어온다.
		//자세히 보여줄 글의 번호가 ref_group  번호 이다. 
		int totalRow=episodeCmtDao.getCount(dto.getNum());
		
		//전체 페이지의 갯수 구하기
		int totalPageCount=
				(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);

		// CafeCommentDto 객체에 위에서 계산된 startRowNum 과 endRowNum 을 담는다.
		EpisodeCmtDto commentDto=new EpisodeCmtDto();
		commentDto.setStartRowNum(startRowNum);
		commentDto.setEndRowNum(endRowNum);
		//ref_group 번호도 담는다.
		commentDto.setRef_group(dto.getNum());

		//DB 에서 댓글 목록을 얻어온다.
		List<EpisodeCmtDto> commentList=episodeCmtDao.getList(commentDto);
		
		//ModelAndView 객체 댓글 목록도 담아온다.
		mView.addObject("commentList", commentList);
		mView.addObject("totalPageCount", totalPageCount);
		
		
		//하트정보 
		mView.addObject("isheartclick",isheartclick);
		//하트개수 정보
		mView.addObject("heartcnt",heartcnt);
		//파일정보
		mView.addObject("filename",filename);
		
		
	}
	
	public void updateData(EpisodeDto dto, HttpServletRequest request) {
		//이미지가 비어있다면 MultipartFile image는 비어있는 상태이다.
		//따라서 이미지 수정은 하지 않은 상태이므로 title과 content만 update한다. 
		if(dto.getImage().isEmpty()) {
			//dto.setImgPath(null);//수정을 하지 않으므로 imagePath를 비워준다. 
			dao.updateData(dto);
		}else {//이미지가 비어있지 않으면 이미지 수정을 한 상태이므로, 기존 파일 파일시스템에서 삭제해주고 title, content, 이미지 모두 update한다. 
			
			// imgPath 는 /upload/~~ 로 저장되어있으므로 앞에 /upload/를 잘라준다. 
			String filename=dto.getImgPath().substring(8);
			System.out.println("filename2는"+filename);
			//기존의 파일은 파일시스템에서 삭제해준다.
			String path=request.getServletContext().getRealPath("/upload")+File.separator+filename;
			System.out.println("path="+path);
			new File(path).delete();
			
			
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
			
			//dto 에 업로드된 파일의 정보를 담는다.
			dto.setImgPath("/upload/"+saveFileName);
			dao.updateData(dto);
		}
	}

	//댓글관련 
	@Override
	public void saveComment(HttpServletRequest request) {
		//댓글 작성자(로그인된 아이디의 닉네임)
		String writer=(String)request.getSession().getAttribute("nick");
		//폼 전송되는 댓글의 정보 얻어내기
		int ref_group=Integer.parseInt(request.getParameter("ref_group"));
		String target_nick=request.getParameter("target_nick");
		String content=request.getParameter("content");
		/*
		 * 원글의 댓글은 comment_group 번호가 전송이 안되고
		 * 댓글의 댓글은 comment_group 번호가 전송이 된다.
		 * 따라서 null 여부를 조사하면 원글의 댓글인지 댓글의 댓글인지 판별할수 있다.
		 */
		String cmt_group=request.getParameter("cmt_group");
		//새 댓글의 글번호는 미리 얻어낸다.
		int seq=episodeCmtDao.getSequence();
		//저장할 새 댓글 정보를 dto 에 담기
		EpisodeCmtDto dto=new EpisodeCmtDto();
		dto.setNum(seq);
		dto.setWriter(writer);
		dto.setTarget_nick(target_nick);
		dto.setContent(content);
		dto.setRef_group(ref_group);
		if(cmt_group == null) {//원글의 댓글인 경우 
			//댓글의 글번호와 comment_group 번호를 같게 한다.
			dto.setCmt_group(seq);
		}else {//댓글의 댓글인 경우 
			//폼 전송된 comment_group 번호를 숫자로 바꿔서 dto 에 넣어준다.
			dto.setCmt_group(Integer.parseInt(cmt_group));
		}
		//댓글 정보를 DB 에 저장한다.
		episodeCmtDao.insert(dto);
		
	}

	@Override
	public void deleteComment(HttpServletRequest request) {
		//GET 방식 파라미터로 전달되는 삭제할 댓글 번호 
		int num=Integer.parseInt(request.getParameter("num"));
		//세션에 저장된 로그인된 아이디
		String nick=(String)request.getSession().getAttribute("nick");
		//댓글의 정보를 얻어와서 댓글의 작성자와 같은지 비교 한다.
		String writer=episodeCmtDao.getData(num).getWriter();
//		if(!writer.equals(id)) {
//			throw new DBFailException("남의 댓글을 삭제할수 없습니다.");
//		}
		episodeCmtDao.delete(num);
		
	}

	@Override
	public void updateComment(EpisodeCmtDto dto) {
		episodeCmtDao.update(dto);
	}

	@Override
	public void moreCommentList(HttpServletRequest request) {
		//파라미터로 전달된 pageNum 과 ref_group 번호를 읽어온다. 
		int pageNum=Integer.parseInt(request.getParameter("pageNum"));
		int ref_group=Integer.parseInt(request.getParameter("ref_group"));

		//num에 ref_group번호를 담아 dao.getData 메소드를 호출해서 원하는 데이터를 불러온다.
		EpisodeDto tmp=new EpisodeDto();
		tmp.setNum(ref_group);
		EpisodeDto dataDto=dao.getData(tmp);
		request.setAttribute("dataDto", dataDto);

		/* 아래는 댓글 페이징 처리 관련 비즈니스 로직 입니다.*/
		final int PAGE_ROW_COUNT=5;

		//보여줄 페이지 데이터의 시작 ResultSet row 번호
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지 데이터의 끝 ResultSet row 번호
		int endRowNum=pageNum*PAGE_ROW_COUNT;

		//전체 row 의 갯수를 읽어온다.
		//자세히 보여줄 글의 번호가 ref_group  번호 이다. 
		int totalRow=episodeCmtDao.getCount(ref_group);
		//전체 페이지의 갯수 구하기
		int totalPageCount=
				(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);

		//CafeCommentDto 객체에 위에서 계산된 startRowNum 과 endRowNum 을 담는다.
		EpisodeCmtDto commentDto=new EpisodeCmtDto();
		commentDto.setStartRowNum(startRowNum);
		commentDto.setEndRowNum(endRowNum);
		//ref_group 번호도 담는다.
		commentDto.setRef_group(ref_group);


		//DB 에서 댓글 목록을 얻어온다.
		List<EpisodeCmtDto> commentList=episodeCmtDao.getList(commentDto);
		
		//request 에 담아준다.
		request.setAttribute("commentList", commentList);
		request.setAttribute("totalPageCount", totalPageCount);			
		
	}

	@Override
	public void deleteDetail(int num) {
		dao.deleteDetail(num);
	}

	//조회수 높은 순대로 Best3를 불러오는 메소드 
	@Override
	public void getBestViewCntList(ModelAndView mView) {
		List<EpisodeDto> list=dao.getBestViewCntList();
		//원본 파일명을 얻기 위해 원본파일명을 filename에 담아주는 작업을 한다.
		//이때 원본 파일명이 ""와 같으면 요청한 페이지에 emptyImg로 비교해서 기본이미지를 넣도록 한다.
		for(EpisodeDto tmp : list) {
			String filename=tmp.getImgPath().substring(21);
			//filename이 ""와 같으면 이미지 첨부를 안한 상태이다. imgpath에 emptyImg라고 넣어준다. 
			if(filename.equals("")) {
				tmp.setImgPath("emptyImg");
			}
		}
		mView.addObject("episodeBestList",list);
		
	}

	@Override
	public void getMyWriteList(ModelAndView mView, HttpServletRequest request) {
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
		

		//startRowNum 과 endRowNum  을 Episode 객체에 담고
		EpisodeDto dto=new EpisodeDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		//로그인된 아이디의 nick 정보 불러오기
		String nick=(String)request.getSession().getAttribute("nick");
		dto.setNick(nick);

		//GalleryDao 객체를 이용해서 회원 목록을 얻어온다.
		List<EpisodeDto> list=dao.getMyList(dto);

		//원본 파일명을 얻기 위해 원본파일명을 filename에 담아주는 작업을 한다.
		//이때 원본 파일명이 ""와 같으면 요청한 페이지에 emptyImg로 비교해서 기본이미지를 넣도록 한다.
		for(EpisodeDto tmp : list) {
			String filename=tmp.getImgPath().substring(21);
			System.out.println("리스트 filename"+filename);
			//filename이 ""와 같으면 이미지 첨부를 안한 상태이다. imgpath에 emptyImg라고 넣어준다. 
			if(filename.equals("")) {
				tmp.setImgPath("emptyImg");
			}
		}
		
		//전체 row 의 갯수
		int totalRow=dao.getMyCount(dto);
		

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
		mView.addObject("list", list);
		mView.addObject("totalPageCount",totalPageCount);
		mView.addObject("pageNum",pageNum);
		mView.addObject("startPageNum",startPageNum);
		mView.addObject("endPageNum",endPageNum);
		mView.addObject("totalRow",totalRow);

		
	}

	@Override
	public void getMyHeartList(ModelAndView mView, HttpServletRequest request) {
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
		

		//startRowNum 과 endRowNum  을 Episode 객체에 담고
		EpisodeDto dto=new EpisodeDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		//로그인된 아이디의 nick 정보 불러오기
		String nick=(String)request.getSession().getAttribute("nick");
		dto.setNick(nick);

		//GalleryDao 객체를 이용해서 회원 목록을 얻어온다.
		List<EpisodeDto> list=dao.getMyHeartList(dto);

		//원본 파일명을 얻기 위해 원본파일명을 filename에 담아주는 작업을 한다.
		//이때 원본 파일명이 ""와 같으면 요청한 페이지에 emptyImg로 비교해서 기본이미지를 넣도록 한다.
		for(EpisodeDto tmp : list) {
			String filename=tmp.getImgPath().substring(21);
			System.out.println("리스트 filename"+filename);
			//filename이 ""와 같으면 이미지 첨부를 안한 상태이다. imgpath에 emptyImg라고 넣어준다. 
			if(filename.equals("")) {
				tmp.setImgPath("emptyImg");
			}
		}
		
		//전체 row 의 갯수
		int totalRow=dao.getMyHeartCount(dto);
		

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
		mView.addObject("list", list);
		mView.addObject("totalPageCount",totalPageCount);
		mView.addObject("pageNum",pageNum);
		mView.addObject("startPageNum",startPageNum);
		mView.addObject("endPageNum",endPageNum);
		mView.addObject("totalRow",totalRow);
		
	}
	
}
