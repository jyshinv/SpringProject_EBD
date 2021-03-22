package com.acorn.ebd.file.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn.ebd.file.dto.FileDto;
import com.acorn.ebd.market.dto.MarketDto;
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

	/* 하트 관련 */
	
	@Override
	public void insertHeart(FileDto dto) {
		// 하트 저장 
		session.insert("file.insertHeart",dto);
		
	}

	@Override
	public void deleteHeart(FileDto dto) {
		// 하트 삭제
		session.delete("file.deleteHeart",dto);
		
	}

	@Override
	public List<Integer> getHeartInfo(FileDto dto) {
		List<Integer> list=session.selectList("file.selectHeartInfo",dto);
	    return list;
	}

	@Override
	public List<Integer> getHeartCnt(FileDto dto) {
		return session.selectList("file.getHeartCnt",dto);
	}

	@Override
	public boolean getHeartInfoDetail(FileDto dto) {
		//해당 닉네임이 해당 글에 좋아요를 누르지 않으면 null, 눌렀으면 target_num 이 리턴된다. 
	    String isClicked=session.selectOne("file.getHeartInfoDetail",dto);
	      
	    if(isClicked==null) {
	       return false; //해당 글에 하트를 안누름
	    }else {
	       return true;
	    }
	}
	
	@Override
	public int getHeartCntDetail(int num) {
		 return session.selectOne("file.getHeartCntDetail",num);
	}

	//조회수 높은 순 5개를 리턴해줌 
	@Override
	public List<FileDto> getBestViewCntList() {
		List<FileDto> list=session.selectList("file.getBestViewCntList");
		return list;
	}

	@Override
	public List<FileDto> getMyList(FileDto dto) {
		//나의 서재에서 파일목록을 리턴
		List<FileDto> list=session.selectList("file.getMyList", dto);
		return list;
	}

	@Override
	public int getMyCount(FileDto dto) {
		//나의 서재에서 파일목록의 count를 리턴
		return session.selectOne("file.getMyCount", dto);
	}

}
