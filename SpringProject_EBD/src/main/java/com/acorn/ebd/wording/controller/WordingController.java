package com.acorn.ebd.wording.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.booksearch.service.BookSearchService;
import com.acorn.ebd.wording.dto.WordingDto;
import com.acorn.ebd.wording.service.WordingService;

@Controller
public class WordingController {

	@Autowired
	private WordingService service;
	@Autowired
	private BookSearchService bservice;
	
	//wording list 요청처리
	@RequestMapping("/wording/list.do")
	public ModelAndView list(ModelAndView mView, HttpServletRequest request, HttpSession session) {
		//글 목록 요청
		service.getList(mView, request, session);
		mView.setViewName("wording/list");
		return mView;
	}
	
	//wording ajax요청처리
	@RequestMapping("/wording/ajax_page.do")
	public ModelAndView ajaxPage(ModelAndView mView, HttpServletRequest request, HttpSession session) {
		service.getList(mView, request, session);
		mView.setViewName("wording/ajax_page");
		return mView;
	}
	
//	//wording insertform 요청처리(최초 요청)
//	@RequestMapping("/wording/private/insertform.do")
//	public String insertform() {
//		return "wording/private/insertform";
//	}
//	
//	//wording insertform 요청처리(북 검색 후 요청)
//	@RequestMapping("/wording/private/insertform2.do")
//	public String insertform2(@ModelAttribute("dto") WordingDto dto) {
//		//insertform메소드의 매개변수로 WordingDto dto를 적어주어 폼전송 된 모든 값을 dto에 저장가능
//		//@ModelAttribute("dto")를 앞에 적어줌으로써 forward이동된 페이지에서 dto.변수명으로 사용가능하다.
//		
//		
//		//title의 html요소 모두 없애준다. 
//		String title=dto.getTitle().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
//		dto.setTitle(title);
//		System.out.println(title);
//		
//		return "wording/private/insertform";
//	}
	
	//wording insertform 요청처리 위의 두 코드를 합침 
	//required=false는 폼에서 넘어오는 값이 없을때에도 오류를 일으키지 않는다. 
	@RequestMapping("/wording/private/insertform.do")
	public ModelAndView insertform(@RequestParam(required = false)String title, String author, ModelAndView mView) {
		mView.setViewName("wording/private/insertform");
		service.replaceInfo(title, author, mView);
		return mView;
	}
	
	//wording insert 요청처리
	@RequestMapping(value="/wording/private/insert.do",method=RequestMethod.POST)
	public String insert(WordingDto dto, HttpSession session) {
		service.saveContent(dto, session);
		return "wording/private/insert";
	}
	
	
	//required=false는 폼에서 넘어오는 값이 없을때에도 오류를 일으키지 않는다.
	//네이버 도서검색 api의 검색 결과 요청을 처리한다. 
    @RequestMapping("/wording/private/bookList.do")
    public ModelAndView bookList(@RequestParam(required = false) String keyword){
        ModelAndView mav = new ModelAndView();
        
        if(keyword !=null)
        {
            mav.addObject("bookList",bservice.searchBook(keyword,10,1));
        }
        mav.setViewName("wording/private/bookList");
        return mav;
    }
    
    //하트 클릭 요청처리
    @RequestMapping("/wording/saveheart.do")
    @ResponseBody
    public void insertheart(@RequestParam String target_num, HttpSession session){
    	int new_target_num = Integer.parseInt(target_num);
    	service.saveHeart(new_target_num, session);
    }
    
    //하트눌림 클릭 요청처리(하트 해제)
    @RequestMapping("/wording/removeheart.do")
    @ResponseBody
    public void deleteheart(@RequestParam String target_num, HttpSession session) {
    	int new_target_num = Integer.parseInt(target_num);
    	service.removeHeart(new_target_num, session);
    }
    
    //수정 클릭 시 수정 폼 요청처리 
    @RequestMapping("/wording/private/updateform.do")
    public ModelAndView updateform(@RequestParam int num, ModelAndView mView) {
    	service.getDetail(num, mView);
    	mView.setViewName("wording/private/updateform");
    	return mView;
    }
    
    //수정 요청처리
    @RequestMapping(value="/wording/private/update.do",method=RequestMethod.POST)
    public String update(WordingDto dto) {
    	service.update(dto);
    	return "wording/private/update";
    }
    
 
    //삭제 클릭 요청처리
    @RequestMapping("/wording/private/delete.do")
    public String delete(@RequestParam int num, HttpServletRequest request) {
    	service.delete(num,request);
    	return "wording/private/delete";
    }
    
    
}
