package com.acorn.ebd.file.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.file.dao.FileCmtDao;
import com.acorn.ebd.file.dto.FileCmtDto;
import com.acorn.ebd.file.dto.FileDto;
import com.acorn.ebd.file.service.FileService;

@Controller
public class FileController {
	@Autowired
	private FileService fileService;
	
	//파일 다운로드 요청 처리 
	@RequestMapping("/file/download")
	public ModelAndView download(@RequestParam int num, ModelAndView mview) {
		
		//mview에 다운로드할 파일이 정보를 담고
		fileService.getDetail(num, mview);
		//view페이지로 이동해서 다운로드를 시켜준다.
		mview.setViewName("fileDownView");
		return mview;
	}
	
	//파일 목록 보기 요청 처리
	@RequestMapping("/file/list")
	public ModelAndView list(HttpServletRequest request, ModelAndView mview) {
		fileService.getList(request);
		mview.setViewName("file/list");
		return mview;
	}
	
	//파일 업로드 폼 요청 처리
	@RequestMapping("/file/private/insertform")
	public ModelAndView uploadform(ModelAndView mview) {
		
		return mview;
	}
	
	//파일 업로드 요청 처리
	@RequestMapping(value = "/file/private/insert", method = RequestMethod.POST)
	public ModelAndView upload(FileDto dto, ModelAndView mview, 
			HttpServletRequest request) {
		
		fileService.addFile(dto, request);
		
		mview.setViewName("file/private/insert");
		return mview;
	}
	
	//파일 삭제 요청 처리(뷰의 요청 경로 지정)
	@RequestMapping("/file/private/delete")
	public ModelAndView delete(@RequestParam int num,
			ModelAndView mview, HttpServletRequest request) {
		//로직 수행
		fileService.deleteFile(num, request);
		//데이터 전달 
		mview.setViewName("file/private/delete");
		return mview; 
	}
	
	//파일 수정 폼 요청 처리
	@RequestMapping("/file/private/updateform")
	public ModelAndView updateform(@RequestParam int num, ModelAndView mview) {
		fileService.getDetail(num, mview);
		mview.setViewName("file/private/updateform");
		return mview;
	}
	
	//파일 수정 요청 처리
	@RequestMapping("/file/private/update")
	public String update(@ModelAttribute("dto") FileDto dto) {
		fileService.updateFile(dto);
		return "file/private/update";
	}
	
	//디테일 요청 처리
	@RequestMapping("/file/detail")
	public ModelAndView detail(@RequestParam int num, ModelAndView mview) {
		fileService.getDetail(num, mview);
		mview.setViewName("file/detail");
		return mview;
	}
	
	//새 댓글 저장 요청 처리
	@RequestMapping(value = "file/private/cmt_insert", method = RequestMethod.POST)
	public String cmtInsert(HttpServletRequest request, @RequestParam int ref_group) {
		//새 댓글 저장
		fileService.saveCmt(request);
		//글 자세히 보기로 다시 리다이렉트 이동시킨다
		//ref_group는 자세히 보기 했던 글 번호
		return "redirect:/file/detail.do?num="+ref_group;
	}
	
	//댓글 수정 ajax 요청에 대한 요청 처리 
	@RequestMapping(value = "/file/private/cmt_update", 
			method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> cmtUpdate(FileCmtDto dto){
		//댓글을 수정 반영하고 
		fileService.updateCmt(dto);
		
		//JSON 문자열을 클라이언트에게 응답한다.
		Map<String, Object> map=new HashMap<>();
		map.put("num", dto.getNum());
		map.put("content", dto.getContent());
		return map;
		
	}
		
	// 댓글 삭제 요청 처리
	@RequestMapping("file/private/cmt_delete")
	public ModelAndView cmtDelete(HttpServletRequest request,
			ModelAndView mview, @RequestParam int ref_group) {
		
		fileService.deleteCmt(request);
		mview.setViewName("redirect:/file/detail.do?num="+ref_group);
		return mview;
	}

}
