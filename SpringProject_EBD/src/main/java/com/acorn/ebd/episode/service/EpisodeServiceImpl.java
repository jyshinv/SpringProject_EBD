package com.acorn.ebd.episode.service;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.acorn.ebd.episode.dao.EpisodeDao;
import com.acorn.ebd.episode.dto.EpisodeDto;

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
	
}
