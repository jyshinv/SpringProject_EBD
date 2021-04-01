package com.acorn.ebd.episode.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.acorn.ebd.episode.dto.EpisodeCmtDto;
import com.acorn.ebd.episode.dto.EpisodeDto;
import com.acorn.ebd.episode.service.EpisodeService;

@Controller
public class EpisodeController {
	
	//EpisodeService 객체 주입하기 
	@Autowired
	private EpisodeService service;
	
	//에피소드 list 요청처리
	@RequestMapping("/episode/list.do")
	public ModelAndView list(ModelAndView mView, HttpServletRequest request) {
		service.getList(mView, request);
		mView.setViewName("episode/list");
		return mView;
	}
	
	//에피소드 작성폼 요청 처리 
	@RequestMapping("/episode/private/uploadform.do")
	public String uploadform() {
		return "episode/private/uploadform";
	}
	
	//에피소드 작성 클릭 요청 처리
	@RequestMapping(value="/episode/private/upload.do", method=RequestMethod.POST)
	public String upload(EpisodeDto dto, HttpServletRequest request) {
		service.saveContent(dto, request);
		return "episode/private/upload";
	}
	
	//하트 클릭 요청처리
    @RequestMapping("/episode/saveheart.do")
    @ResponseBody
    public Map<String, Object> insertheart(@RequestParam String target_num, HttpSession session){
    	int new_target_num = Integer.parseInt(target_num);
    	int heartCnt = service.saveHeart(new_target_num, session);
    	Map<String, Object> map=new HashMap<String, Object>();
    	map.put("heartCnt",heartCnt);
    	return map;
    }
    
    //하트눌림 클릭 요청처리(하트 해제)
    @RequestMapping("/episode/removeheart.do")
    @ResponseBody
    public Map<String, Object> deleteheart(@RequestParam String target_num, HttpSession session) {
    	int new_target_num = Integer.parseInt(target_num);
    	int heartCnt=service.removeHeart(new_target_num, session);
    	Map<String, Object> map=new HashMap<String, Object>();
    	map.put("heartCnt",heartCnt);
    	return map;
    }
    
    //에피소드 디테일 클릭 요청 처리
    @RequestMapping("/episode/detail.do")
    public ModelAndView detail(EpisodeDto dto, ModelAndView mView, HttpSession session) {
    	service.getData(dto, mView, session);
    	mView.setViewName("episode/detail");
    	return mView;
    }
    
    //에피소드 디테일에서 수정폼 요청 처리
    @RequestMapping("/episode/private/updateform.do")
    public ModelAndView updateform(EpisodeDto dto, ModelAndView mView, HttpSession session) {
    	service.getData(dto, mView, session);
    	mView.setViewName("episode/private/updateform");
    	return mView;
    }
    
    //에피소드 수정 폼에서 수정 클릭시 수정 요청 처리
    @RequestMapping(value="/episode/private/update.do", method=RequestMethod.POST)
    public String update(EpisodeDto dto, HttpServletRequest request) {
    	service.updateData(dto, request);
    	request.setAttribute("num", dto.getNum());
    	return "episode/private/update";
    }
    
    /*에피소드 댓글 관련 처리*/
    //새 댓글 저장 요청 처리
    @RequestMapping(value="/episode/private/comment_insert", method=RequestMethod.POST)
  	public String commentInsert(HttpServletRequest request,
  			@RequestParam int ref_group) {
  		//새 댓글을 저장하고
  		service.saveComment(request);
  		//글 자세히 보기로 다시 리다일렉트 이동 시킨다.
  		//ref_group 은 자세히 보기 했던 글번호 
  		return "redirect:/episode/detail.do?num="+ref_group;
  	}
    
    //댓글 삭제 기능
  	@RequestMapping("/episode/private/comment_delete")
  	public ModelAndView commentDelete(HttpServletRequest request,
  			ModelAndView mView, @RequestParam int ref_group) {
  		service.deleteComment(request);
  		mView.setViewName("redirect:/episode/detail.do?num="+ref_group);
  		return mView;
  	}
  	
  	//댓글 수정 ajax 요청에 대한 요청 처리
  	@RequestMapping(value = "/episode/private/comment_update", 
  			method=RequestMethod.POST)
  	@ResponseBody
  	public Map<String, Object> commentUpdate(EpisodeCmtDto dto){
  		
  		
  		//핵심 비즈니스 로직과 상관없는 코드1
  		long startTime=System.currentTimeMillis(); //시작시간
  		
  		//핵심 비즈니스 로직
  		//댓글을 수정 반영하고 
  		service.updateComment(dto);
  		//JSON 문자열을 클라이언트에게 응답한다.
  		Map<String, Object> map=new HashMap<>();
  		map.put("num", dto.getNum());
  		map.put("content", dto.getContent());
  		
  		//핵심 비즈니스 로직과 상관없는 코드2
  		long endTime=System.currentTimeMillis(); //시작시간
  		long time=endTime-startTime; //소요시간(처리하는데 소요된 시간을 의미)
  		System.out.println("소요시간:"+time+" 입니다.");//처리하는데 걸린 시간 출력
  		
  		//핵심 비즈니스 로직 
  		return map;
  	}
  	
  	@RequestMapping("/episode/ajax_comment_list")
  	public ModelAndView ajaxCommentList(HttpServletRequest request,
  			ModelAndView mView) {
  		service.moreCommentList(request);
  		mView.setViewName("episode/ajax_comment_list");
  		return mView;
  	}
  	
  	//episode 글 삭제 요청처리 
  	@RequestMapping("/episode/private/delete.do")
  	public String delete(int num, HttpServletRequest request) {
  		service.deleteDetail(num, request);
  		return "episode/private/delete";
  	}
	

}
