package com.acorn.ebd.report.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn.ebd.report.dto.ReportCmtDto;

@Repository
public class ReportCmtDaoImpl implements ReportCmtDao{
	
	@Autowired
	private SqlSession session;

	@Override
	public List<ReportCmtDto> getList(ReportCmtDto dto) {
		List<ReportCmtDto> list=session.selectList("reportCmt.getList", dto);
		return list;
	}

	@Override
	public void insert(ReportCmtDto dto) {
		session.insert("reportCmt.insert", dto);
		
	}

	@Override
	public void update(ReportCmtDto dto) {
		session.update("reportCmt.update", dto);
		
	}

	@Override
	public void delete(int num) {
		session.update("reportCmt.delete", num);
		
	}

	@Override
	public int getSequence() {
		int seq=session.selectOne("reportCmt.getSequence");
		return seq;
	}

	@Override
	public ReportCmtDto getData(int num) {
		
		return session.selectOne("reportCmt.getData", num);
	}

	@Override
	public int getCount(int ref_group) {
		
		return session.selectOne("reportCmt.getCount", ref_group);
	}

}
