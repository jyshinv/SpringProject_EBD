package com.acorn.ebd;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

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

import com.acorn.ebd.users.dto.UsersDto;
import com.acorn.ebd.users.service.UsersService;
@Controller
public class HomeController {
	@Autowired
	UsersService service;
	
	@RequestMapping("/home.do")
	public String home() {
		return "home";
	}
	
	@RequestMapping("/include/mydiarynav.do")
    @ResponseBody
    public Map<String, Object> getinfomy(HttpSession session) {
		UsersDto dto=service.getInfomy(session);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("profile",dto.getProfile());
		return map;
    }
}