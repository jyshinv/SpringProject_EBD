package com.acorn.ebd.users.service;

import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.users.dao.UsersDao;
import com.acorn.ebd.users.dto.UsersDto;

@Service
public class UsersServiceImpl implements UsersService {
	
	@Autowired
	private UsersDao dao;

	@Override
	public void addUser(UsersDto dto) {
		
		dao.insert(dto);
		
	}

	@Override
	public void loginformLogic(HttpServletRequest request, ModelAndView mView) {
		// GET 방식 파라미터 url 이라는 이름으로 전달되는 값이 있는지 읽어와보기
		String url=request.getParameter("url");
		//만일 넘어오는 값이 없다면 
		if(url==null){
			//로그인 후에 home.do 요청이 되도록 절대 경로를 구한다.
			String cPath=request.getContextPath();
			url=cPath+"/home.do";
		}
		//쿠키에 저장된 아이디와 비밀번호를 담을 변수
		String savedId="";
		String savedPwd="";
		//쿠키에 저장된 값을 위의 변수에 저장하는 코드를 작성해 보세요.
		Cookie[] cooks=request.getCookies();
		if(cooks!=null){
			//반복문 돌면서 쿠키객체를 하나씩 참조해서 
			for(Cookie tmp: cooks){
				//저장된 키값을 읽어온다.
				String key=tmp.getName();
				//만일 키값이 savedId 라면 
				if(key.equals("savedId")){
					//쿠키 value 값을 savedId 라는 지역변수에 저장
					savedId=tmp.getValue();
				}
				if(key.equals("savedPwd")){
					savedPwd=tmp.getValue();
				}
				
			}
		}
		//view page에서 필요한 데이터를 담는다. 
		mView.addObject("url",url);
		mView.addObject("savedId",savedId);
		mView.addObject("savedPwd",savedPwd);
		
	}

	@Override
	public void loginLogic(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		//login_form.jsp에서 url이라는 파라메터 명으로 url값을 얻어온다. 
		//로그인 후 가야하는 목적지 정보
		String url=request.getParameter("url");
		//로그인 실패를 대비해서 목적지 정보를 인코딩한 결과도 준비한다.
		String encodedUrl=URLEncoder.encode(url);
		
		//1.폼 전송되는 아이디와 비밀번호를 읽어온다.
		String id=request.getParameter("id");
		String pwd=request.getParameter("pwd");
		UsersDto dto=new UsersDto();
		dto.setId(id);
		dto.setPwd(pwd);
		//2.DB에 실제로 존재하는 (유효한) 정보인지 확인한다.
		boolean isValid=dao.isValid(dto);
		//3.유효한 정보이면 로그인 처리를 하고 응답 그렇지 않으면 아이디 혹은 비밀번호가 틀렸다고 응답
		if(isValid) {
			//login의 메소드로 HttpSession session을 설정해줘도 좋지만 request객체가 있기 때문에 이런식으로 로그인 처리를 해준다.
			//HttpSession객체를 이용해 로그인처리를 한다.
			request.getSession().setAttribute("id", id); 
			String nick=dao.getNick(dto.getId());
			request.getSession().setAttribute("nick", nick);
			
		}
		
		//쿠키저장하기
		//체크를 하지 않았으면 null이다. 
		String isSave=request.getParameter("isSave");
		
		if(isSave == null){//체크 박스를 체크 안했다면
			//저장된 쿠키 삭제 
			Cookie idCook=new Cookie("savedId", id);
			idCook.setMaxAge(0);//삭제하기 위해 0 으로 설정 
			response.addCookie(idCook);
			
			Cookie pwdCook=new Cookie("savedPwd", pwd);
			pwdCook.setMaxAge(0);
			response.addCookie(pwdCook);
		}else{//체크 박스를 체크 했다면 
			//아이디와 비밀번호를 쿠키에 저장
			Cookie idCook=new Cookie("savedId", id);
			idCook.setMaxAge(60*60*24);//하루동안 유지 (하루는 24시간 한시간은 60분 1분은 60초!)
			response.addCookie(idCook);
			
			Cookie pwdCook=new Cookie("savedPwd", pwd);
			pwdCook.setMaxAge(60*60*24);
			response.addCookie(pwdCook);
		}
		//view page에서 필요한 데이터를 request에 담고 
		request.setAttribute("id", id);
		request.setAttribute("encodedUrl", encodedUrl);
		request.setAttribute("url", url);
		request.setAttribute("isValid", isValid);
		
	}

}
