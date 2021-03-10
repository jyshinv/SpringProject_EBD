package com.acorn.ebd.episode.dao;

import java.util.List;

import com.acorn.ebd.episode.dto.EpisodeCmtDto;

public interface EpisodeCmtDao {
	//댓글 목록 얻어오기
	public List<EpisodeCmtDto> getList(EpisodeCmtDto commentDto);
	//댓글 추가
	public void insert(EpisodeCmtDto dto);
	//댓글 수정
	public int getSequence();
	//댓글 삭제
	public void update(EpisodeCmtDto dto);
	//댓글의 시퀀스값(글번호)를 리턴하는 메소드
	public void delete(int num);
	//댓글 하나의 정보를 리턴하는 메소드
	public EpisodeCmtDto getData(int num);
	//댓글의 개수를 리턴하는 메소드 
	public int getCount(int ref_group);



}
