package com.acorn.ebd.aspect;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.acorn.ebd.exception.NotAllowException;
import com.acorn.ebd.episode.dao.EpisodeCmtDao;
import com.acorn.ebd.episode.dao.EpisodeDao;
import com.acorn.ebd.episode.dto.EpisodeDto;

@Aspect
@Component
public class EpisodeAspect {
	
		@Autowired
		private EpisodeDao episodedao;
		
		@Autowired
		private EpisodeCmtDao episodeCmtDao;
		
		/*
		com.gura.acorn.ebd.episode.service 패키지에  있는
		모든 클래스 중에 delete로 시작하는 모든 메소드에 적용할 aspect
		*/
		@Around("execution(void com.acorn.ebd.episode.service.*.delete*(..))")
		public void checkDelete(ProceedingJoinPoint joinPoint) throws Throwable {
			//필요한 값을 담을 지역 변수 미리 만들기 (메소드에 전달된 인자로부터 찾아야한다.)
			int num=0;
			int ref_group=0;
			HttpServletRequest request=null;
			
			//메소드의 인자로 전달된 값을 배열로 얻어내기
			Object[] args=joinPoint.getArgs();
			
			//반복문 돌면서 
			for(Object tmp:args) {
				//필요한 type을 찾아서 casting한다. 
				if(tmp instanceof Integer) {
					//글 번호
					num=(Integer)tmp;
				}else if(tmp instanceof HttpServletRequest) {
					//HttpSession 을 얻어낼 HttpServletRequest 객체 
					request=(HttpServletRequest)tmp;
				}
			}
			//메소드로부터 전달된 인자에 num이 없는 경우이다.(댓글 삭제)
			if(num == 0) {
				num=Integer.parseInt(request.getParameter("num")); //삭제할 댓글 번호를 얻어온다.
				String writer=episodeCmtDao.getData(num).getWriter(); //댓글을 작성한 작성자를 불러온다. 
				//로그인 된 닉네임 얻어오기 (작성자 = 닉네임)
				String nick=(String)request.getSession().getAttribute("nick");
				if(!nick.equals(writer)) {
					throw new NotAllowException("작성자 '"+writer+"' 님만이 지울 수 있습니다.");
				}
			}else {//글삭제의 경우는 전달된 인자에 num이 있음 
				EpisodeDto dtoNum=new EpisodeDto();
				dtoNum.setNum(num);
				//글 번호를 글 정보를 얻어온다.
				EpisodeDto dto=episodedao.getData(dtoNum);
				//로그인 된 닉네임 얻어오기 (작성자 = 닉네임)
				String nick=(String)request.getSession().getAttribute("nick");
				if(!nick.equals(dto.getWriter())) {
					throw new NotAllowException("작성자 '"+dto.getWriter()+"' 님만이 지울 수 있습니다.");
				}
			}
			
			//위에서 예외가 발생해 exception을 던지면 아래 코드는 호출되지 않을 것이다. (--> 아래 코드는 service패키지 안에 모든 delete로 시작하는 메소드!!를 호출하는 것임)
			//위에서 예외가 발생하지 않아 exception를 던지지 않으면 아래 코드는 호출된다. (--> service패키지 안에 모든 delete로 시작하는 메소드를 호출하는 것이다!)
			joinPoint.proceed();
		}

	
}
