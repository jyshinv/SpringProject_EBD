package com.acorn.ebd.report.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn.ebd.report.dto.ReportDto;

@Repository
public class ReportDaoImpl implements ReportDao{
	//핵심의존객체 DI
	@Autowired
	private SqlSession session;
	
	//독후감 새글 추가 메소드
	@Override
	public void insert(ReportDto dto) {
		
		session.insert("report.insert", dto);
	}

	//독후감 목록 불러오기
	@Override
	public List<ReportDto> getList(ReportDto dto) {
		
		return session.selectList("report.getList", dto);
	}

	//독후감 하나의 정보 불러오기
	@Override
	public ReportDto getData(ReportDto dto) {

		return session.selectOne("report.getData", dto);
	}

	//독후감 삭제하기
	@Override
	public void delete(int num) {
		
		session.delete("report.delete", num);
	}
	
	//독후감 조회수 올리기
	@Override
	public void addViewCount(ReportDto dto) {
		session.update("report.addViewCount", dto);
		
	}

	@Override
	public void updatepublicck(ReportDto dto) {
		session.update("report.updatepublicck", dto);
		
	}

	@Override
	public List<ReportDto> getPublicList(ReportDto dto) {
		
		return session.selectList("report.getPublicList", dto);
	}

	@Override
	public int getCount(ReportDto dto) {
		int count = session.selectOne("report.getCount", dto);
		return count;
	}

	@Override
	public int getCountTotal() {
		int count = session.selectOne("report.getCountTotal");
		return count;
	}

	@Override
	public void updateData(ReportDto dto) {
		session.update("report.update", dto);
		
	}

}
