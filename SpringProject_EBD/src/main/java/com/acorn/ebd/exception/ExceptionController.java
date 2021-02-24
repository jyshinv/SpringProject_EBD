package com.acorn.ebd.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

/*
Spring Framework가 동작하는 중에 특정 예외가 발생하면 여기에서 직접 응답하고자 할때 사용한다.
Spring Framework가 동작한다는 것은 *.do 요청을 처리하는 Dispatcher Servlet이 동작할 때 라고 말할 수 있다.
*/
@ControllerAdvice
public class ExceptionController {
	//DBFailException type의 예외가 발생하면 호출되는 메소드 
	@ExceptionHandler(DBFailException.class)
	public ModelAndView dbFail(DBFailException e) { //발생한 예외 객체가 전달된다.
		ModelAndView mView=new ModelAndView();
		//"exception" 이라는 키값으로 예외 객체의 참조값을 담고
		//담은 예외객체는 view page 에서 ${exception.message } 형태로 사용한다
		mView.addObject("exception",e);
		mView.setViewName("error/db_fail");
		return mView;
		
	}
	
}
