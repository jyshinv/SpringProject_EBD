package com.acorn.ebd.report.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.booksearch.service.BookSearchService;
import com.acorn.ebd.report.dto.ReportCmtDto;
import com.acorn.ebd.report.dto.ReportDto;
import com.acorn.ebd.report.service.ReportService;

@Controller
public class ReportController {
	@Autowired
	private ReportService service;

	@Autowired
	private BookSearchService bservice;
	
	@RequestMapping(value = "/my_report/private/update", method = RequestMethod.POST)
	public String update(ReportDto dto, HttpServletRequest request) {
		service.updateData(dto, request);
		return "my_report/private/update";
	}
	
	@RequestMapping("/my_report/private/updateform")
	public ModelAndView updateform(ReportDto dto, ModelAndView mView, HttpSession session) {
		service.getDetail(dto, mView, session);
		mView.setViewName("my_report/private/updateform");
		return mView;
	}
	
	@RequestMapping("/public_report/ajax_comment_list")
	public ModelAndView ajaxCommentList(HttpServletRequest request, ModelAndView mView) {
		service.moreCommentList(request);
		mView.setViewName("public_report/ajax_comment_list");
		return mView;
	}
	
	@RequestMapping(value = "/public_report/private/comment_update", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> commentUpdate(ReportCmtDto dto){
		service.updateComment(dto);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("num", dto.getNum());
		map.put("content", dto.getContent());
		return map;
	}
	
	@RequestMapping("/public_report/private/comment_delete")
	public ModelAndView commentDelete(HttpServletRequest request, ModelAndView mView, @RequestParam int ref_group) {
		service.deleteComment(request);
		mView.setViewName("redirect:/public_report/detail.do?num="+ref_group);
		return mView;
	}
	
	@RequestMapping(value = "/public_report/private/comment_insert", method = RequestMethod.POST)
	public String commentInsert(HttpServletRequest request, @RequestParam int ref_group) {
		service.saveComment(request);
		return "redirect:/public_report/detail.do?num="+ref_group;
	}
	
    //키워드가 있을때도 있고 없을때도있음 
    //있을때는 가져가고 없을때는 안가져가고 
    @RequestMapping("/my_report/private/bookList.do")
    public ModelAndView bookList(@RequestParam(required=false)String keyword){
        ModelAndView mav = new ModelAndView();
        
        if(keyword !=null)
        {
            mav.addObject("bookList",bservice.searchBook(keyword,20,1));
        }
        mav.setViewName("my_report/private/bookList");
        return mav;
    }
    
  //독후감 새글 저장 요청 처리 
  	@RequestMapping(value = "/my_report/private/insert", method=RequestMethod.POST)
  	public String insert(ReportDto dto, HttpServletRequest request) {
  		
  		service.saveContent(dto, request);
  		return "my_report/private/insert";
  	}
  	
  	/*독후감 새글 작성 폼 요청 처리
  	@RequestMapping("/my_report/private/insertform")
  	public String insertform() {
  		
  		return "my_report/private/insertform";
  	}
  	*/
  	
    //독후감 새글 작성 폼 요청 처리
    @RequestMapping("/my_report/private/insertform.do")
    public ModelAndView insertform(@RequestParam(required = false)String booktitle, String author, String link, ModelAndView mView) {
       //title이나 author이 null이면 NullPointerException이 발생한다. 
       service.replaceInfo(booktitle, author, link, mView);
       return mView;
    }

  	//마이 독후감 글 목록 요청 처리
  	@RequestMapping("/my_report/private/list")
  	public ModelAndView list(ModelAndView mView, HttpServletRequest request) {
  		service.getList(mView, request);
  		mView.setViewName("my_report/private/list");
  		return mView;
  	}
  	
  	//마이 독후감 글 하나 정보 요청 처리
  	@RequestMapping("/my_report/private/detail")
  	public ModelAndView detail(ReportDto dto, ModelAndView mView, HttpSession session) {
  		service.getDetail(dto, mView, session);
  		mView.setViewName("my_report/private/detail");
  		return mView;
  	}
  	
  	//공개 독후감 글 하나 정보 요청 처리
  	@RequestMapping("/public_report/detail")
  	public ModelAndView detail_pub(ReportDto dto, ModelAndView mView, HttpSession session) {
  		service.getDetail(dto, mView, session);
  		mView.setViewName("public_report/detail");
  		return mView;
  	}
  	
  	//공개 독후감 글 목록 요청 처리
  	@RequestMapping("/public_report/list")
  	public ModelAndView list2(ModelAndView mView, HttpServletRequest request) {
  		service.getPublicList(mView, request);
  		mView.setViewName("public_report/list");
  		return mView;
  	}
  	
  	//독후감 삭제 요청 처리
  	@RequestMapping("/my_report/private/delete")
  	public String delete(@RequestParam int num) {
  		service.deleteContent(num);
  		return "my_report/private/delete";
  	}
  	
  	//독후감 공개 / 비공개 요청처리
  	@RequestMapping("/my_report/private/updatepublicck")
  	public String updatepublicck(ReportDto dto) {
  		service.updatepublicck(dto);
  		return "redirect:/my_report/private/detail.do?num="+dto.getNum();
  	}
  	
  	//독후감 공개 / 비공개 요청처리
  	@RequestMapping(value="/public_report/updatepublicck2", method=RequestMethod.POST)
  	public String updatepublicck2(ReportDto dto) {
  		service.updatepublicck(dto);
  		return "redirect:/my_report/private/detail.do?num="+dto.getNum();
  	}
  	//.do 요청을 하고 싶을 때는 redirect 사용
  	
  	//하트 클릭 요청처리 responseBody 를 적으면 return map 이 자동으로 list.jsp saveheart function(data)로 가진다.
    @RequestMapping("/public_report/saveheart.do")
    @ResponseBody
    public Map<String, Object> insertheart(@RequestParam String target_num, HttpSession session){
       int new_target_num = Integer.parseInt(target_num);
       int heartCnt = service.saveHeart(new_target_num, session);
       Map<String, Object> map=new HashMap<String, Object>();
       map.put("heartCnt",heartCnt);
       return map;
    }
    
    //하트눌림 클릭 요청처리(하트 해제)
    @RequestMapping("/public_report/removeheart.do")
    @ResponseBody
    public Map<String, Object> deleteheart(@RequestParam String target_num, HttpSession session) {
       int new_target_num = Integer.parseInt(target_num);
       int heartCnt=service.removeHeart(new_target_num, session);
       Map<String, Object> map=new HashMap<String, Object>();
       map.put("heartCnt",heartCnt);
       return map;
    }
  	
}
