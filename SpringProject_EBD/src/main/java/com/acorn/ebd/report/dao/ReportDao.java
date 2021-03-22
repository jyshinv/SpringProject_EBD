package com.acorn.ebd.report.dao;

import java.util.List;

import com.acorn.ebd.report.dto.ReportDto;

public interface ReportDao {
	//독후감 새 글 추가 메소드
	public void insert(ReportDto dto);
	
	//독후감 목록 불러오기 
	public List<ReportDto> getList(ReportDto dto);
	
	//비공개 독후감 하나의 정보 얻어오기
	public ReportDto getData(ReportDto dto);
	
	//공개 독후감 하나의 정보 얻어오기
	public ReportDto getPublicData(ReportDto dto);
	
	//독후감 조회수 올리기
	public void addViewCount(ReportDto dto);
	
	//독후감 삭제하기
	public void delete(int num);	
	
	//독후감 공개 비공개 여부 수정하기
	public void updatepublicck(ReportDto dto);
	
	//공개 독후감의 목록 불러오기
	public List<ReportDto> getPublicList(ReportDto dto);
	
	//독후감 검색 키워드 갯수 얻어오기 (공개독후감)
	public int getCount(ReportDto dto);
	
	//독후감 검색 키워드 갯수 얻어오기 (비공개 독후감)
	public int getCountTotal(ReportDto dto);
	
	//독후감을 수정하는 메소드
	public void updateData(ReportDto dto);
	
	//하트를 저장하는 메소드
	public void insertHeart(ReportDto dto);
	
	//디테일에서 하트 갯수를 불러오는 메소드
	public int getHeartCntDetail(int target_num);

	//하트를 삭제하는 메소드
	public void deleteHeart(ReportDto dto);
	
	//리스트에서 하트 정보를 불러오는 메소드
	public List<Integer> getHeartInfo(ReportDto dto);
	
	//리스트에서 하트 갯수 정보를 불러오는 메소드
	public List<Integer> getHeartCnt(ReportDto dto);
	
	//디테일에서 하트 정보를 불러오는 메소드
	public boolean getHeartInfoDetail(ReportDto dto);

	//홈화면에서 BEST3를 불러오는 메소드 
	public List<ReportDto> getBestHeartList();

	//내가 누른 하트 리스트 불러오는 메소드
	public List<ReportDto> getMyHeartPublicList(ReportDto dto);

	//내가 누른 하트 리스트 개수 불러오는 메소드 
	public int getMyHeartCount(ReportDto dto);
	
	
}
