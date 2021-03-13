package com.acorn.ebd.users.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn.ebd.users.dto.UsersDto;

@Repository
public class UsersDaoImpl implements UsersDao {
	
	//핵심 의존객체 주입(DI)
	@Autowired
	private SqlSession session;

	@Override
	public void insert(UsersDto dto) {
		// TODO Auto-generated method stub
		/*
		mapper namespace => users
		sql id => insert
		parameterType => UsersDto
		 */
		session.insert("users.insert",dto);
		
	}

//	@Override
//	public boolean isValid(UsersDto dto) {
//		/*
//		mapper namespace => users
//		sql id => isValid
//		parameterType => UsersDto
//		resultType => String
//		 */
//		String id=session.selectOne("users.isValid",dto);
//		if(id==null) { //잘못된 아이디와 비밀번호
//			return false; 
//		}else { //유효한 아이디와 비밀먼호
//			return true;
//		}
//	}
	
	//해당 id에 해당하는 비밀번호를 리턴
	@Override
	public String getPwd(String id) {
		//아이디를 이용해서 저장된 비밀번호를 SELECT해서
		String pwd=session.selectOne("users.getPwd", id);
		//리턴해준다.
		return pwd;
	}
	

	//닉네임을 가져옴
	@Override
	public String getNick(String id) {
		String nick=session.selectOne("users.getNick",id);
		return nick;
	}

	@Override
	public boolean isExistId(String id) {
		UsersDto dto=session.selectOne("users.isExistId",id);
		if(dto==null) { //아이디가 존재하지 않으므로
			return false;  //존재하지 않는다는 의미의 false
		}else {
			return true; //존재한다는 의미로 true
		}
	}

	@Override
	public boolean isExistNick(String nick) {
		UsersDto dto=session.selectOne("users.isExistNick",nick);
		if(dto==null) { //아이디가 존재하지 않으므로
			return false;  //존재하지 않는다는 의미의 false
		}else {
			return true; //존재한다는 의미로 true
		}
	}

	@Override
	public UsersDto getData(String id) {
		UsersDto dto=session.selectOne("users.getData",id);
		return dto;
	}

	@Override
	public void update(UsersDto dto) {
		session.update("users.update",dto);
	}

	@Override
	public void updateProfile(UsersDto dto) {
		session.update("users.updateProfile",dto);
	}

	

}
