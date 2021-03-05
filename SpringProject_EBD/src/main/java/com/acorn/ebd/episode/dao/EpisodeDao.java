package com.acorn.ebd.episode.dao;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.acorn.ebd.episode.dto.EpisodeDto;

public interface EpisodeDao {
	public void insert(EpisodeDto dto);
	public List<EpisodeDto> getList(EpisodeDto dto);
	public int getCount();
}
