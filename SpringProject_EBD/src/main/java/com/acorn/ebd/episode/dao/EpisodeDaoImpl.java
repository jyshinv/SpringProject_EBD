package com.acorn.ebd.episode.dao;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn.ebd.episode.dto.EpisodeDto;
import com.acorn.ebd.wording.dto.WordingDto;

@Repository
public class EpisodeDaoImpl implements EpisodeDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public void insert(EpisodeDto dto) {
		session.insert("episode.insert",dto);
	}

	@Override
	public List<EpisodeDto> getList(EpisodeDto dto) {
		return session.selectList("episode.getList",dto);
	}

	@Override
	public int getCount(EpisodeDto dto) {
		return session.selectOne("episode.getCount",dto);
	}
	
	@Override
	public void insertHeart(EpisodeDto dto) {
		session.insert("episode.insertHeart",dto);
	}


	@Override
	public void deleteHeart(EpisodeDto dto) {
		session.delete("episode.deleteHeart",dto);
	}
	
	@Override
	public List<Integer> getHeartInfo(EpisodeDto dto) {
		List<Integer> list=session.selectList("episode.selectHeartInfo",dto);
		return list;
	}

	@Override
	public EpisodeDto getData(EpisodeDto dto) {
		return session.selectOne("episode.getData",dto);
	}

	@Override
	public boolean getHeartInfoDetail(EpisodeDto dto) {
		//해당 닉네임이 해당 글에 좋아요를 누르지 않으면 null, 눌렀으면 target_num 이 리턴된다. 
		String isClicked=session.selectOne("episode.getHeartInfoDetail",dto);
		if(isClicked==null) {
			return false; //해당 글에 하트를 안누름
		}else {
			return true;
		}
		
	}

	@Override
	public List<Integer> getHeartCnt(EpisodeDto dto) {
		return session.selectList("episode.getHeartCnt",dto);
	}

	@Override
	public int getHeartCntDetail(int num) {
		return session.selectOne("episode.getHeartCntDatail",num);

	}

	@Override
	public void updateData(EpisodeDto dto) {
		session.update("episode.updateData",dto);
	}

	@Override
	public void deleteDetail(int num) {
		session.delete("episode.deleteDetail",num);
		
	}

	@Override
	public void addViewCount(int num) {
		session.update("episode.addViewCount",num);
	}

	//조회수 순으로 Best3를 불러오는 메소드 
	@Override
	public List<EpisodeDto> getBestViewCntList() {
		List<EpisodeDto> list=session.selectList("episode.getBestViewCntList");
		return list;
	}

	//내가 쓴글 리스트를 리턴
	@Override
	public List<EpisodeDto> getMyList(EpisodeDto dto) {
		return session.selectList("episode.getMyList",dto);
	}

	//내가 쓴글 리스트의 개수를 리턴
	@Override
	public int getMyCount(EpisodeDto dto) {
		return session.selectOne("episode.getMyCount",dto);
	}

	@Override
	public List<EpisodeDto> getMyHeartList(EpisodeDto dto) {
		// TODO Auto-generated method stub
		return session.selectList("episode.getMyHeartList",dto);
	}

	@Override
	public int getMyHeartCount(EpisodeDto dto) {
		// TODO Auto-generated method stub
		return session.selectOne("episode.getMyHeartCount",dto);
	}
	

}
