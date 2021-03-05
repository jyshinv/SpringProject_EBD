package com.acorn.ebd.episode.service;

import javax.servlet.http.HttpServletRequest;

import com.acorn.ebd.episode.dto.EpisodeDto;

public interface EpisodeService {
	public void saveContent(EpisodeDto dto, HttpServletRequest request);
}
