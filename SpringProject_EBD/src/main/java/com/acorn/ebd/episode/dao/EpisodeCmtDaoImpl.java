package com.acorn.ebd.episode.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn.ebd.episode.dto.EpisodeCmtDto;

@Repository
public class EpisodeCmtDaoImpl implements EpisodeCmtDao {
	
	@Autowired
	private SqlSession session;

	@Override
	public List<EpisodeCmtDto> getList(EpisodeCmtDto commentDto) {
		List<EpisodeCmtDto> list= session.selectList("episodeCmt.getList", commentDto);
		return list;
	}

	@Override
	public void insert(EpisodeCmtDto dto) {
		session.insert("episodeCmt.insert", dto);	
	}

	@Override
	public int getSequence() {
		int seq=session.selectOne("episodeCmt.getSequence");
		return seq;
	}

	@Override
	public void update(EpisodeCmtDto dto) {
		session.update("episodeCmt.update", dto);
		
	}

	@Override
	public void delete(int num) {
		//댓글 삭제는 deleted 칼럼의 내용을 'yes' 로 수정하는 작업을 한다. 
		session.update("episodeCmt.delete", num);
		
	}

	@Override
	public EpisodeCmtDto getData(int num) {
		return session.selectOne("episodeCmt.getData", num);
	}

	@Override
	public int getCount(int ref_group) {
		return session.selectOne("episodeCmt.getCount", ref_group);
	}

	

}
