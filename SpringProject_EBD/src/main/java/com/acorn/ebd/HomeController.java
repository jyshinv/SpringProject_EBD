package com.acorn.ebd;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.episode.service.EpisodeService;
import com.acorn.ebd.file.service.FileService;
import com.acorn.ebd.market.service.MarketService;
import com.acorn.ebd.report.service.ReportService;
import com.acorn.ebd.users.dto.UsersDto;
import com.acorn.ebd.users.service.UsersService;
import com.acorn.ebd.wording.service.WordingService;
@Controller
public class HomeController {
	@Autowired
	UsersService users_service;
	
	@Autowired
	EpisodeService episode_service;
	
	@Autowired
	FileService file_service;
	
	@Autowired
	MarketService market_service;
	
	@Autowired
	ReportService report_service;
	
	@Autowired
	WordingService wording_service;
	
	
	//메인화면 요청처리
	@RequestMapping("/home.do")
	public ModelAndView home(ModelAndView mView, HttpServletRequest request) {
		wording_service.getBestHeartList(mView); //좋아요 높은 순 Best3 (wordingBestList[0~3])
		report_service.getBestHeartList(mView); //좋아요 높은 순 Best3 (reportBestList[0~3])
		episode_service.getBestViewCntList(mView); //조회수 높은 순 Best3 (episodeBestList[0~3])
		file_service.getBestViewCntList(mView); //조회수 높은 순 Best3 (fileBestList[0~5])
		market_service.getList(request); //최신매물 Top3 (marketService의 getList를 재사용함)		

		
		mView.setViewName("home");
		return mView;
	}
	
	//mydiarynavbar에 이미지 프로필 불러오는 요청 처리
	@RequestMapping("/include/mydiarynav.do")
    @ResponseBody
    public Map<String, Object> getinfomy(HttpSession session) {
		UsersDto dto=users_service.getInfomy(session);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("profile",dto.getProfile());
		return map;
    }
	
	
}