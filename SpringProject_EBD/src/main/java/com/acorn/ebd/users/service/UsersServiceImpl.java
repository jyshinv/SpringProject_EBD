package com.acorn.ebd.users.service;

import java.io.File;
import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.users.dao.UsersDao;
import com.acorn.ebd.users.dto.UsersDto;

@Service
public class UsersServiceImpl implements UsersService {
	
	@Autowired
	private UsersDao dao;

	@Override
	public void addUser(UsersDto dto) {
		//비밀번호를 암호화할 객체 생성
		BCryptPasswordEncoder encoder=new BCryptPasswordEncoder();
		//입력한 비밀번호를 암호화 한다.
		String encodedPwd=encoder.encode(dto.getPwd());
		//UsersDto에 다시 넣어준다.
		dto.setPwd(encodedPwd);
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
		
		//2.유효한 정보인지 여부를 담을 지역 변수를 만들고 초기값 false를 지정한다.
		boolean isValid=false;
				
		//3.아이디를 이용해서 암호화 된 비밀번호를 SELECT 한다.
		String savedPwd=dao.getPwd(id);
		
		//4.비밀번호가 만일 null 이 아니면(존재하는 아이디)
		if(savedPwd != null) {
			//5. 폼 전송되는 비밀번호와 일치하는지 확인한다.
			isValid=BCrypt.checkpw(pwd, savedPwd);
		}

		//2.DB에 실제로 존재하는 (유효한) 정보인지 확인한다.
		//boolean isValid=dao.isValid(dto);
		
		String nick=null;
		//3.유효한 정보이면 로그인 처리를 하고 응답 그렇지 않으면 아이디 혹은 비밀번호가 틀렸다고 응답
		if(isValid) {
			//login의 메소드로 HttpSession session을 설정해줘도 좋지만 request객체가 있기 때문에 이런식으로 로그인 처리를 해준다.
			//HttpSession객체를 이용해 로그인처리를 한다.
			request.getSession().setAttribute("id", id); 
			nick=dao.getNick(id); //해당 id의 닉네임을 불러온다. 			
			request.getSession().setAttribute("nick", nick);//session영역에 저장한다. 
			
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
		request.setAttribute("nick", nick);
		request.setAttribute("encodedUrl", encodedUrl);
		request.setAttribute("url", url);
		request.setAttribute("isValid", isValid);
		
	}

	@Override
	public boolean isExistId(String id) {
		//id존재 여부를 리터해준다.
		return dao.isExistId(id);
	}

	@Override
	public boolean isExistNick(String nick) {
		//nick존재 여부를 리턴해준다.
		return dao.isExistNick(nick);
	}

	@Override
	public void getInfo(HttpSession session, ModelAndView mView) {
		//로그인 된 아이디를 읽어와서
		String id=(String)session.getAttribute("id");
		//개인정보를 읽어온다.
		UsersDto dto=dao.getData(id);
		//읽어온 정보를 ModelAndView 객체에 담아준다.
		mView.addObject("dto",dto);
		
	}
	
	@Override
	public UsersDto getInfomy(HttpSession session) {
		//로그인 된 아이디를 읽어와서
		String id=(String)session.getAttribute("id");
		//개인정보를 읽어온다.
		UsersDto dto=dao.getData(id);	
		
		return dto;
	}

	@Override
	public void updateUser(UsersDto dto, HttpSession session) {
		//로그인된 아이디를 읽어온다.
		String id=(String)session.getAttribute("id");
		//dto에 담는다.
		dto.setId(id);
		//dao를 이용해서 DB에 수정 반영한다.
		dao.update(dto);
		
		//변경된 닉네임을 불러온 후 세션영역에 다시 담아준다.
		String nick=dao.getNick(id); //해당 id의 닉네임을 불러온다. 
		session.setAttribute("nick", nick);//session영역에 저장한다. 
		
	}

	@Override
	public void saveProfile(MultipartFile image, HttpServletRequest request) {
		//원본 파일명
		String orgFileName=image.getOriginalFilename();
		
		//파일의 크기는 여기에서 필요없다.
		//long fileSize=image.getSize();
		
		//파일을 저장할 실제 경로 "webapp/upload"
		String realPath=request.getServletContext().getRealPath("/upload");
		File upload=new File(realPath);
		if(!upload.exists()) { //만일 존재하지 않으면
			upload.mkdir();//폴더를 만든다.
		}
		//저장할 파일명을 구성한다. 1977.1.1 0시를 기준으로 경과시간이 1000분의1초 단위로 나온다.
		//똑같은 이름의 파일을 저장하더라도 파일이름에 중복이 생기지 않도록 currentTimeMillis를 쓴다. 
		String saveFileName=System.currentTimeMillis()+orgFileName;
		//저장할 파일의 전체 경로를 구성한다.
		//윈도우 :\, linux:/이기 때문에 separator을 이용해주어야한다.
		String path=realPath+File.separator+saveFileName;
		try {
			//임시폴더에 업로드 된 파일을 원하는 위치에 원하는 파일명으로 이동시킨다.
			image.transferTo(new File(path));
		}catch(Exception e) {
			e.printStackTrace();
		}
		//DB에 저장할 이미지의 경로
		String profile="/upload/"+saveFileName;
		//로그인된 아이디
		String id=(String)request.getSession().getAttribute("id");
		//수정할 정보를 dto에 담기
		UsersDto dto=new UsersDto();
		dto.setId(id);
		dto.setProfile(profile);
		//dao를 이용해서 수정 반영하기
		dao.updateProfile(dto);
		
	}

	@Override
	public void updateUserPwd(ModelAndView mView, UsersDto dto, HttpSession session) {
		//로그인 된 아이디를 읽어와서
		String id=(String)session.getAttribute("id");
		
		//1. 예전 비밀번호가 맞는지 확인한다.
		//아이디를 이용해서 암호화 된 비밀번호를 SELECT 한다.
		String savedPwd=dao.getPwd(id);
	
		//2.폼 전송되는 예전 비밀번호와 일치하는지 확인한다.
		boolean isValid=BCrypt.checkpw(dto.getPwd(), savedPwd);
			
		//3. 만일 맞다면
		if(isValid) {
			//4. 새 비밀번호를 암호화해서
			String newPwd=new BCryptPasswordEncoder().encode(dto.getNewpwd());
			
			//5. dto에 아이디와 새 비밀번호를 담아서 
			dto.setId(id);
			dto.setNewpwd(newPwd);
			//6.수정 반영한다. 
			dao.updatePwd(dto);
			//7.로그아웃 처리를 한다.
			session.removeAttribute("id");
			session.removeAttribute("nick");
		}
		
		//성공여부를 ModelAndView객체에 담는다.
		mView.addObject("isSuccess",isValid);
		
	}

	@Override
	public void deleteUser(HttpSession session) {
		//로그인된 아이디를 읽어와서
		String id=(String)session.getAttribute("id");
		//탈퇴시킨다.
		dao.delete(id);
		//로그아웃 처리 
		session.removeAttribute("id");
		
	}

}
