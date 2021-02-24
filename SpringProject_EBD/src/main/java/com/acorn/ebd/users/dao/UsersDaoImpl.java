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

	@Override
	public boolean isValid(UsersDto dto) {
		/*
		mapper namespace => users
		sql id => isValid
		parameterType => UsersDto
		resultType => String
		 */
		String id=session.selectOne("users.isValid",dto);
		if(id==null) { //잘못된 아이디와 비밀번호
			return false; 
		}else { //유효한 아이디와 비밀먼호
			return true;
		}
	}

	//닉네임을 가져옴
	@Override
	public String getNick(String id) {
		String nick=session.selectOne("users.getNick",id);
		return nick;
	}
	
	

}
