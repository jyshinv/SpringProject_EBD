package com.acorn.ebd.file.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn.ebd.file.dto.FileDto;
@Repository
public class FileDaoImpl implements FileDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public List<FileDto> getList(FileDto dto) {
		//파일목록을 리턴하는 메소드
		List<FileDto> list=session.selectList("file.getList", dto);
		return list;
	}

	@Override
	public int getCount(FileDto dto) {
		//파일의 갯수를 리턴하는 메소드 (검색키워드에 맞는 row의 갯수)
		return session.selectOne("file.getCount", dto);
	}

	@Override
	public FileDto getData(int num) {
		//하나의 파일 정보를 리턴하는 메소드 (인자로 전달되는 번호에 해당하는)
		return session.selectOne("file.getData", num);
	}

	@Override
	public void insert(FileDto dto) {
		// 파일 정보를 저장하는 메소드
		session.insert("file.insert", dto);
		
	}

	@Override
	public void delete(int num) {
		// 파일을 삭제하는 메소드
		session.delete("file.delete", num);
	}

	@Override
	public void update(FileDto dto) {
		// 파일을 수정하는 메소드 
		session.update("file.update", dto);
		
	}

	@Override
	public void addViewCount(int num) {
		// 글의 조회수 
		session.update("file.addViewCount", num);
	}

}
