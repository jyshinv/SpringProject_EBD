package com.acorn.ebd.file.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn.ebd.file.dto.FileCmtDto;

@Repository
public class FileCmtDaoImpl implements FileCmtDao{
	//핵심 의존객체 DI
	@Autowired
	private SqlSession session;

	@Override
	public List<FileCmtDto> getList(FileCmtDto dto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(FileCmtDto dto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(FileCmtDto dto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int getSeq() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public FileCmtDto getData(int num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getCount(int ref_group) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	

}
