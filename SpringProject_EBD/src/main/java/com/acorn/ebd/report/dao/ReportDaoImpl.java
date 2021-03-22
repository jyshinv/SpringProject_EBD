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
	public int getCountTotal(ReportDto dto) {
		int count = session.selectOne("report.getCountTotal", dto);
		return count;
	}

	@Override
	public void updateData(ReportDto dto) {
		session.update("report.update", dto);
		
	}

	@Override
	public void insertHeart(ReportDto dto) {
		session.insert("report.insertHeart",dto);
	}

	@Override
	public int getHeartCntDetail(int target_num) {
		return session.selectOne("report.getHeartCntDatail",target_num);
	}

	@Override
	public void deleteHeart(ReportDto dto) {
		session.delete("report.deleteHeart",dto);
		
	}

	@Override
	public List<Integer> getHeartInfo(ReportDto dto) {
		List<Integer> list=session.selectList("report.selectHeartInfo",dto);
	    return list;
	}

	@Override
	public List<Integer> getHeartCnt(ReportDto dto) {
		return session.selectList("report.getHeartCnt",dto);
	}

	@Override
	public boolean getHeartInfoDetail(ReportDto dto) {
		//해당 닉네임이 해당 글에 좋아요를 누르지 않으면 null, 눌렀으면 target_num 이 리턴된다. 
        String isClicked=session.selectOne("report.getHeartInfoDetail",dto);
        if(isClicked==null) {
           return false; //해당 글에 하트를 안누름
        }else {
           return true;
        }
	}

	//좋아요 수 BEST3를 불러오는 메소드
	@Override
	public List<ReportDto> getBestHeartList() {
		List<ReportDto> list=session.selectList("report.getBestHeartList");
		return list;
	}

	@Override
	public ReportDto getPublicData(ReportDto dto) {
		return session.selectOne("report.getPublicData", dto);
	}

	//내가 누른 하트 목록을 리턴
	@Override
	public List<ReportDto> getMyHeartPublicList(ReportDto dto) {
		return session.selectList("report.getMyHeartPublicList", dto);
	}

	//내가 누른 하트 목록 개수를 리턴
	@Override
	public int getMyHeartCount(ReportDto dto) {
		int count = session.selectOne("report.getMyHeartCount", dto);
		return count;
	}

}
