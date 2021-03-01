package com.acorn.ebd.report.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.booksearch.service.BookSearchService;

@Controller
public class ReportController {

	@Autowired
	private BookSearchService bservice;
	
    //키워드가 있을때도 있고 없을때도있음 
    //있을때는 가져가고 없을때는 안가져가고 
    @RequestMapping("/my_report/private/bookList.do")
    public ModelAndView bookList(@RequestParam(required=false)String keyword){
        ModelAndView mav = new ModelAndView();
        
        if(keyword !=null)
        {
            mav.addObject("bookList",bservice.searchBook(keyword,10,1));
        }
        mav.setViewName("my_report/private/bookList");
        return mav;
    }
}
