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
		List<FileCmtDto> list=session.selectList("fileCmt.getList", dto);
		return list;
	}

	@Override
	public void insert(FileCmtDto dto) {
		session.insert("fileCmt.insert", dto);
		
	}

	@Override
	public void update(FileCmtDto dto) {
		session.update("fileCmt.update", dto);
		
	}

	@Override
	public void delete(int num) {
		// 댓글 삭제는 deleted 칼럼의 내용을 'yes'로 수정하는 작업을 한다.
		session.update("fileCmt.delete",num);
		
	}

	/*
	 *  새로운 댓글을 저장한 직후에 바로 해당 댓글의 번호가 필요 하기 때문에
	 *  댓글의 글번호는 미리 얻어내서 작업을 해야한다. 
	 *  따라서 새 댓글의 글번호를 리턴해주는 메소드가 필요하다. 
	 */
	@Override
	public int getSeq() {
		int seq = session.selectOne("fileCmt.getSeq");
		return seq;
	}

	@Override
	public FileCmtDto getData(int num) {
		return session.selectOne("fileCmt.getData", num);
	}

	@Override
	public int getCount(int ref_group) {
		return session.selectOne("fileCmt.getCount", ref_group);
	}
	
	

}
