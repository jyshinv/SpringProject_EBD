package com.acorn.ebd.file.service;

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
import com.acorn.ebd.file.dao.FileCmtDao;
import com.acorn.ebd.file.dao.FileDao;
import com.acorn.ebd.file.dto.FileCmtDto;
import com.acorn.ebd.file.dto.FileDto;

@Service
public class FileServiceImpl implements FileService{
	@Autowired
	private FileDao fdao;
	@Autowired
	private FileCmtDao cmtDao;
	
	// 전체 글 목록
	@Override
	public void getList(HttpServletRequest request) {
		//한 페이지에 나타낼 row 의 갯수
		final int PAGE_ROW_COUNT=5;
		//하단 디스플레이 페이지 갯수
		final int PAGE_DISPLAY_COUNT=5;
		//보여줄 페이지의 번호
		int pageNum=1;
		
		//보여줄 페이지의 번호가 파라미터로 전달되는지 읽어와 본다.	
		//pageNum을 request객체를 이용하여 getParameter메소드를 이용하여 받아오고
		String strPageNum=request.getParameter("pageNum");
		
		if(strPageNum != null){//페이지 번호가 파라미터로 넘어온다면
			//페이지 번호를 설정한다.
			pageNum=Integer.parseInt(strPageNum);
		}
		
		//보여줄 페이지 데이터의 시작 ResultSet row 번호
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		
		//보여줄 페이지 데이터의 끝 ResultSet row 번호
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		
		//검색 키워드에 관련된 처리 
		String keyword=request.getParameter("keyword"); //검색 키워드
		String condition=request.getParameter("condition"); //검색 조건
		if(keyword==null){//전달된 키워드가 없다면 
			keyword=""; //빈 문자열을 넣어준다. 
			condition="";
		}
		//인코딩된 키워드를 미리 만들어 둔다. 
		String encodedK=URLEncoder.encode(keyword);
		
		//검색 키워드와 startRowNum, endRowNum 을 담을 FileDto 객체 생성
		FileDto dto=new FileDto();
		//dto에서 가져오고
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		if(!keyword.equals("")){ //만일 키워드가 넘어온다면 
			if(condition.equals("title")){
				dto.setTitle(keyword);
			}else if(condition.equals("writer")){
				dto.setWriter(keyword);
			}
		}
		
		//파일 목록 얻어오기
		List<FileDto> list=fdao.getList(dto);
		//전체 row 의 갯수 
		int totalRow=fdao.getCount(dto);
		
		//전체 페이지의 갯수 구하기
		int totalPageCount=
				(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		//시작 페이지 번호
		int startPageNum=
			1+((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		//끝 페이지 번호가 잘못된 값이라면 
		if(totalPageCount < endPageNum){
			endPageNum=totalPageCount; //보정해준다. 
		}
		
		//로그인된 아이디의 nick 정보 불러오기
		String nick=(String)request.getSession().getAttribute("nick");
		dto.setNick(nick);
		
		List<Integer> isHeartClickList=null;
		List<Integer> heartCntList=null;
		
		//하트 정보(로그인 중일때만)
		//nick이 null인채로 episodedao.getHeartInfo()를 호출하면 select문에 전달하는 paramater가 null이 되어버려 오류가 생긴다.
		if(nick != null) {
			isHeartClickList=fdao.getHeartInfo(dto);         
		}
		
		//총 하트 개수 정보를 리턴해주는 메소드
		heartCntList=fdao.getHeartCnt(dto);
		
		//EL 에서 사용할 값을 미리 request 에 담아두기
		request.setAttribute("list", list);
		request.setAttribute("startPageNum", startPageNum);
		request.setAttribute("endPageNum", endPageNum);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("condition", condition);
		request.setAttribute("keyword", keyword);
		request.setAttribute("encodedK", encodedK);
		request.setAttribute("totalRow", totalRow);
		
		request.setAttribute("isHeartClickList", isHeartClickList);
		request.setAttribute("heartCntList", heartCntList);
		
	}
	
	@Override
	public void getDetail(int num, ModelAndView mview, HttpSession session) {
		// 글 번호(num)를 이용해서 정보를 얻어오고
		FileDto dto=fdao.getData(num);
		// 정보를 modelandview 객체에 담고
		mview.addObject("dto",dto);
		// 글 조회수를 증가 시킨다.
		fdao.addViewCount(num);
	
		//수정폼에서 저장한 이미지의 오리지널 파일명을 불러오기 위해 문자열을 자른다.
		String filename=dto.getImgpath().substring(21);
		
		/* 디테일 페이지의 댓글 페이징 처리 관련 비즈니스 로직 */
		final int PAGE_ROW_COUNT=5;
		
		//보여줄 페이지의 번호
		int pageNum=1;
		 
		//보여줄 페이지 데이터의 시작 ResultSet row번호
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지 데이터 끝 ResultSte row번호
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		
		//전체 row의 갯수를 읽어온다.
		//자세히 보여줄 글의 번호가 ref_group 번호이다.
		int totalRow=cmtDao.getCount(num);
		//전체 페이지의 갯수 구하기
		int totalPageCount=
				(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		
		// FileCmtDto객체 위에서 계산된 startRowNum과 endRowNum을 담는다.
		FileCmtDto cmtDto=new FileCmtDto();
		cmtDto.setStartRowNum(startRowNum);
		cmtDto.setEndRowNum(endRowNum);
		//ref_grouo 번호도 담는다.
		//자세히 보여줄 글의 번호가 ref_group 번호이다 = num
		cmtDto.setRef_group(num);
		
		//DB에서 댓글 목록을 얻어온다.
		List<FileCmtDto> cmtList=cmtDao.getList(cmtDto);
		
		//현재 로그인 되어있는 유저의 닉네임 저장
	    String nick=(String)session.getAttribute("nick");
	    dto.setNick(nick);
	    
	    //하트 정보를 저장할 변수 heart
	    boolean isheartclick=false;
	      if(nick != null) { //닉네임이 null이 아닐때만 getHeartInfoDatail을 호출 null일 경우 전달하는 파라메터가 null이라는 오류를 낸다.
	         isheartclick = fdao.getHeartInfoDetail(dto); //해당 닉네임이 하트를 클릭했으면 target_num이 return되고, 그게 아니면 아무것도 리턴하지 않는다.
	      }
	      
	    //하트 개수 정보를 저장할 변수 heartcnt
	    int heartcnt=fdao.getHeartCntDetail(dto.getNum());
		
		//ModelandView객체에 댓글 목록을 담아준다.
		mview.addObject("cmtList", cmtList);
		mview.addObject("totalPageCount", totalPageCount);
		mview.addObject("filename", filename); //이미지
		
		mview.addObject("heartcnt", heartcnt);
		mview.addObject("isheartclick", isheartclick);
	}
	
	@Override
	public void addFile(FileDto dto, HttpServletRequest request) {
		
		//업로드된 파일의 정보를 가지고 있는 MultipartFile 객체의 참조값 얻어오기 
		MultipartFile myFile=dto.getMyFile(); //파일
		MultipartFile myImg=dto.getMyImg(); //사진
		
		//원본 파일명
		String orgfname=myFile.getOriginalFilename();
		String orgfname2=myImg.getOriginalFilename();
		
		//파일의 크기
		long fileSize=myFile.getSize();
		
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
		
		//저장할 파일 명을 구성한다.
		String savefname=System.currentTimeMillis()+orgfname;
		String savefname2=System.currentTimeMillis()+orgfname2;
		
		try {
			//upload 폴더에 파일을 저장한다.
			myFile.transferTo(new File(filePath+savefname));
			myImg.transferTo(new File(filePath+savefname2));
			System.out.println(filePath+savefname);
			System.out.println(filePath+savefname2);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		//dto 에 업로드된 파일의 정보를 담는다.
		//일단 id로 하고 nick으로 수정 할 거임 
		String nick=(String)request.getSession().getAttribute("nick");
		dto.setWriter(nick); //세션에서 읽어낸 파일 업로더의 아이디 
		
		//파일 
		dto.setOrgfname(orgfname);
		dto.setSavefname(savefname);
		dto.setFileSize(fileSize);
		
		//이미지 
		dto.setImgpath("/upload/"+savefname2);
		
		//fileDao 를 이용해서 DB 에 저장하기
		fdao.insert(dto);
		
		
	}
	
	@Override
	public void deleteFile(int num, HttpServletRequest request) {
		// num번의 파일을 삭제할 파일의 정보 얻어오기 
		FileDto dto=fdao.getData(num);
		
		//파일 시스템에서 파일 삭제
		String savefname=dto.getSavefname();
		String path=request.getServletContext().getRealPath("/upload")+
				File.pathSeparator+savefname;
		new File(path).delete();
		
		//DB 에서 파일 정보 삭제 
		fdao.delete(num);
		
	}
	
	@Override
	public void updateFile(FileDto dto, HttpServletRequest request) {
		
		//이미지가 비어있다면 MultipartFile image는 비어있는 상태이다.
		//따라서 이미지 수정은 하지 않은 상태이므로 title과 content만 update한다. 
		  if(dto.getMyImg().isEmpty()) {
		     //dto.setImgPath(null);//수정을 하지 않으므로 imagePath를 비워준다. 
		     fdao.update(dto);
		  }else {//이미지가 비어있지 않으면 이미지 수정을 한 상태이므로, 기존 파일 파일시스템에서 삭제해주고 title, content, 이미지 모두 update한다. 
			  
			 // imgPath 는 /upload/~~ 로 저장되어있으므로 앞에 /upload/를 잘라준다. 
			 String filename=dto.getImgpath().substring(8);
			 System.out.println(filename);
			 
			 //기존의 파일은 파일시스템에서 삭제해준다.
			 String path=request.getServletContext().getRealPath("/upload")+File.separator+filename;
			 System.out.println("path="+path);
			         new File(path).delete();
			  
			 //업로드된 파일의 정보를 가지고 있는 MultipartFile 객체의 참조값 얻어오기 
			 MultipartFile myFile=dto.getMyImg();
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
			dto.setImgpath("/upload/"+saveFileName);
			 
			//dao를 이용해서 DB 수정하기
			fdao.update(dto);
			
		  }
		  
		  if(dto.getMyFile().isEmpty()) {
		     //dto.setImgPath(null);//수정을 하지 않으므로 imagePath를 비워준다. 
		     fdao.update(dto);
		  }else {//파일이 비어있지 않으면 이미지 수정을 한 상태이므로, 기존 파일 파일시스템에서 삭제해주고 title, content, 이미지 모두 update한다. 
			  
			 // imgPath 는 /upload/~~ 로 저장되어있으므로 앞에 /upload/를 잘라준다. 
			 //String filename2=dto.getImgpath().substring(8);
			// System.out.println(filename2);
			 
			 String savefname2=dto.getSavefname();
			 //기존의 파일은 파일시스템에서 삭제해준다.
			 String path2=request.getServletContext().getRealPath("/upload")+File.separator+savefname2;
			 System.out.println("path="+path2);
			         new File(path2).delete();
			  
			 //업로드된 파일의 정보를 가지고 있는 MultipartFile 객체의 참조값 얻어오기 
			 MultipartFile myFile=dto.getMyFile();
			 
			 //원본 파일명
			 String orgfname=myFile.getOriginalFilename();
			 
			//파일의 크기
			long fileSize=myFile.getSize();
				
			 // webapp/upload 폴더 까지의 실제 경로(서버의 파일시스템 상에서의 경로)
			 String realPath2=request.getServletContext().getRealPath("/upload");
			 System.out.println(realPath2);
			 
			 //저장할 파일의 상세 경로
			 String filePath2=realPath2+File.separator;
			 
			 //디렉토리를 만들 파일 객체 생성
			 File upload=new File(filePath2);
			 if(!upload.exists()) {//만일 디렉토리가 존재하지 않으면 
				 upload.mkdir(); //만들어 준다.
			 }
			 
			 //저장할 파일 명을 구성한다.(원본파일명에 타임밀리를 찍어서 더해줌으로써 겹치는 파일명이 없도록 한다.)
			 String savefname=
			       System.currentTimeMillis()+orgfname;
			 
			 try {
			    //upload 폴더에 파일을 저장한다.
			    myFile.transferTo(new File(filePath2+savefname));
			    System.out.println(filePath2+savefname);
			 }catch(Exception e) {
			    e.printStackTrace();
			 }
			 
			//dto 에 업로드된 파일의 정보를 담는다.
			dto.setOrgfname(orgfname);
			dto.setSavefname(savefname);
			dto.setFileSize(fileSize);
			
			//dao를 이용해서 DB 수정하기
			fdao.update(dto);
			     
		  }
	}

	/*
	 * 	여기서부터는 댓글 관련 서비스
	 */
	@Override
	public void saveCmt(HttpServletRequest request) {
		//댓글 작성자(로그인된 아이디)
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
		
		//새 댓글의 글번호는 미리 얻어내서 seq에 담기
		int seq2=cmtDao.getSeq();
		
		//저장할 새 댓글 정보들을 dto 에 담기
		FileCmtDto dto=new FileCmtDto();
		dto.setNum(seq2);
		dto.setWriter(writer);
		dto.setTarget_nick(target_nick);
		dto.setContent(content);
		dto.setRef_group(ref_group);
		
		if(cmt_group == null) {//원글의 댓글인 경우 
			//댓글의 글번호와 cmt_group 번호를 같게 한다.
			dto.setCmt_group(seq2);
		}else {//댓글의 댓글인 경우 
			//폼 전송된 comment_group 번호를 숫자로 바꿔서 dto 에 넣어준다.
			dto.setCmt_group(Integer.parseInt(cmt_group));
		}
		//댓글 정보를 DB 에 저장한다.
		cmtDao.insert(dto);
		
	}

	@Override
	public void updateCmt(FileCmtDto dto) {
		cmtDao.update(dto);
		
	}

	@Override
	public void deleteCmt(HttpServletRequest request) {
		// GET방식 파라미터로 전달되는 삭제할 댓글의 '번호' 가져오기
		// 캐스팅
		int num=Integer.parseInt(request.getParameter("num"));
		
		// 세션에 저장된 '닉네임' 가져오기
		String nick=(String)request.getSession().getAttribute("nick");
		
		// 댓글의 정보(닉네임)를 얻어와서 댓글의 작성자와 같은지 비교
		// 작성자의 정보를 가져오고
		String writer=cmtDao.getData(num).getWriter();
		if(!writer.equals(nick)) {
			// 예외처리
			throw new DBFailException("남의 댓글을 삭제 할 수 없습니다.");
		}
		cmtDao.delete(num);
				
	}

	@Override //댓글 추가 목록 응답
	public void moreCmtList(HttpServletRequest request) {
		
		// 파라미터로 전달된 pageNum과 
		int pageNum=Integer.parseInt(request.getParameter("pageNum"));
		// ref_group 번호를 읽어온다.
		int ref_group=Integer.parseInt(request.getParameter("ref_group"));
		
		FileDto dto=fdao.getData(ref_group);
		request.setAttribute("dto", dto);
		
		/* 아래는 댓글 페이징 처리 관련 비즈니스 로직 입니다.*/
		final int PAGE_ROW_COUNT=5;

		//보여줄 페이지 데이터의 시작 ResultSet row 번호
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지 데이터의 끝 ResultSet row 번호
		int endRowNum=pageNum*PAGE_ROW_COUNT;

		//전체 row 의 갯수를 읽어온다.
		//자세히 보여줄 글의 번호가 ref_group  번호 이다. 
		int totalRow=cmtDao.getCount(ref_group);
		
		//전체 페이지의 갯수 구하기
		int totalPageCount=
				(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);

		// 객체에 위에서 계산된 startRowNum 과 endRowNum 을 담는다.
		FileCmtDto cmtDto=new FileCmtDto();
		cmtDto.setStartRowNum(startRowNum);
		cmtDto.setEndRowNum(endRowNum);
		
		//ref_group 번호도 담는다.
		cmtDto.setRef_group(ref_group);
		
		// DB에서 댓글 목록을 얻어온다.
		List<FileCmtDto> cmtList = cmtDao.getList(cmtDto);
		
		// request에 담아준다.
		request.setAttribute("cmtList", cmtList);
		request.setAttribute("totalPageCount", totalPageCount);
		
	}

	//하트 저장 - 하트를 눌렀을때 하트테이블에 저장해주는 메소드
	@Override
	public int saveHeart(int target_num, HttpSession session) {
		String nick=(String)session.getAttribute("nick");
		FileDto dto=new FileDto();
	    dto.setNick(nick);
	    dto.setNum(target_num);
	    fdao.insertHeart(dto);
	      
	    //하트 개수 정보를 저장할 변수 heartcnt
	    int heartcnt=fdao.getHeartCntDetail(target_num);
	    
	    return heartcnt;
	}
	
	//하트 해제(삭제) - 하트테이블에서 삭제해주는 메소드
	@Override
	public int removeHeart(int target_num, HttpSession session) {
		
		String nick=(String)session.getAttribute("nick");
		FileDto dto=new FileDto();
		dto.setNick(nick);
		dto.setNum(target_num);
	      
	    fdao.deleteHeart(dto);
	      
	    //하트 개수 정보를 저장할 변수 heartcnt
	    int heartcnt=fdao.getHeartCntDetail(target_num);

	    return heartcnt;
	}

	//조회수 top3를 불러오는 메소드 
	@Override
	public void getBestViewCntList(ModelAndView mView) {
		List<FileDto> list=fdao.getBestViewCntList();
		mView.addObject("fileBestList",list);
	}
	
}
