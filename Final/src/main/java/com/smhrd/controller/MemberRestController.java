package com.smhrd.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.smhrd.db.MemberMapper;
import com.smhrd.model.MemberVO;

@org.springframework.web.bind.annotation.RestController
public class MemberRestController {

	@Autowired
	private MemberMapper mapper;
	
	@RequestMapping("/checkId")
	public String checkId(String memId) {
	    String str = "";
        int checkId = mapper.checkId(memId);
	    if (checkId == 1) { // 이미 존재하는 계정
	        str = "NO";
	    } else { // 사용 가능한 계정
	        str = "YES";
	    }
	    return str;
	}
	
}
