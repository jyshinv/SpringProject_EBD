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

import com.acorn.ebd.episode.dao.EpisodeDao;
import com.acorn.ebd.episode.dto.EpisodeDto;
import com.acorn.ebd.wording.dto.WordingDto;

@Service
public class EpisodeServiceImpl implements EpisodeService {

	@Autowired
	private EpisodeDao dao;

	@Override
	public void saveContent(EpisodeDto dto, HttpServletRequest request) {
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
		List<Integer> HeartCntList=null;
		//하트 정보(로그인 중일때만)
		//nick이 null인채로 episodedao.getHeartInfo()를 호출하면 select문에 전달하는 paramater가 null이 되어버려 오류가 생긴다.
		if(nick != null) {
			isHeartClickList=dao.getHeartInfo(dto);			
			//총 하트 개수 정보를 리턴해주는 메소드(로그인 중일때만)
			HeartCntList=dao.getHeartCnt(dto);
		}
		
		
		
		
		//view page 에서 필요한 내용을 ModelAndView 객체에 담아준다
		mView.addObject("list", list);
		mView.addObject("isHeartClickList", isHeartClickList);
		mView.addObject("HeartCntList",HeartCntList);
		mView.addObject("totalPageCount",totalPageCount);
		mView.addObject("pageNum",pageNum);
		mView.addObject("startPageNum",startPageNum);
		mView.addObject("endPageNum",endPageNum);
		mView.addObject("condition",condition);
		mView.addObject("encodedK",encodedK);
		mView.addObject("totalRow",totalRow);
		
		
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
		
		//글정보
		mView.addObject("dataDto",dataDto);
		//하트정보 
		mView.addObject("isheartclick",isheartclick);
		//하트개수 정보
		mView.addObject("heartcnt",heartcnt);
		
	}
	
}
