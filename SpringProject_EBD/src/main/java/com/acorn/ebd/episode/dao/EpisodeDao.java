package com.acorn.ebd.episode.dao;

import javax.servlet.http.HttpServletRequest;

import com.acorn.ebd.episode.dto.EpisodeDto;

public interface EpisodeDao {
	public void insert(EpisodeDto dto);
}
