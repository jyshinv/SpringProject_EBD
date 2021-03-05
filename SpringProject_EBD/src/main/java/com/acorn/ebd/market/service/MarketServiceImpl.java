package com.acorn.ebd.market.service;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.market.dao.MarketDao;
import com.acorn.ebd.market.dto.MarketDto;

@Service
public class MarketServiceImpl implements MarketService {
	@Autowired
	private MarketDao marketDao;

	@Override
	public void insert(HttpServletRequest request, MarketDto dto) {
		
		//업로드된 이미지파일의 정보를 가지고 있는 MultipartFile 객체의 참조값 얻어오기 
		MultipartFile myImg=dto.getMyImg(); //사진
		
		//원본 이미지파일명
		String orgfname=myImg.getOriginalFilename();
		
		// webapp/upload 폴더 까지의 실제 경로(서버의 파일시스템 상에서의 경로)
		String realPath=request.getServletContext().getRealPath("/upload");
		
		//저장할 이미지파일의 상세 경로
		String filePath=realPath+File.separator;
		
		//디렉토리를 만들 파일 객체 생성
		File upload=new File(filePath);
		if(!upload.exists()) {//만일 디렉토리가 존재하지 않으면 
			upload.mkdir(); //만들어 준다.
		}
		
		//저장할 이미지파일 명을 구성한다.
		String savefname=System.currentTimeMillis()+orgfname;	
		
		try {
			//upload 폴더에 파일을 저장한다.
			myImg.transferTo(new File(filePath+savefname));
			System.out.println(filePath+savefname);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		//dto 에 업로드된 이미지의 정보를 담는다.
		String nick=(String)request.getSession().getAttribute("nick");
		//세션에서 읽어낸 파일 업로더의 닉네임
		dto.setWriter(nick); 
				
		//이미지 
		dto.setImgpath("/upload/"+savefname);
		
		// MarketDao를 이용해서 DB에 담기
		marketDao.insert(dto);
		
	}

	@Override
	public void getList(HttpServletRequest request) {
		// 검색기능이 지금은 제목/내용 인데
		// 판매상태랑 판매유형을 추가하고싶음 
		
		//한 페이지에 나타낼 row 의 갯수
		final int PAGE_ROW_COUNT=9;
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
		
		//검색 키워드와 startRowNum, endRowNum 을 담을 marketDto 객체 생성
		MarketDto dto=new MarketDto();
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
		List<MarketDto> marketList=marketDao.getList(dto);
		//전체 row의 갯수
		int totalRow=marketDao.getCount(dto);
		
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
		
		//EL 에서 사용할 값을 미리 request 에 담아두기
		request.setAttribute("marketList", marketList);
		request.setAttribute("startPageNum", startPageNum);
		request.setAttribute("endPageNum", endPageNum);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("condition", condition);
		request.setAttribute("keyword", keyword);
		request.setAttribute("encodedK", encodedK);		
		
	}

	@Override
	public void getDetail(ModelAndView mview, int num) {
		// 이전글, 다음글 페이징 
		
		MarketDto dto=new MarketDto();
		dto=marketDao.getData(num);
		mview.addObject("dto", dto);
		marketDao.addViewCnt(num);
		
	}

	@Override
	public void update(MarketDto dto) {
		marketDao.update(dto);
		
	}

	@Override
	public void updateStatus(MarketDto dto) {
		// 디테일페이지에서 판매상태 수정하기
		marketDao.updateStatus(dto);
		
	}

	@Override
	public void delete(int num) {
		marketDao.delete(num);
		
	}
		
	

}
