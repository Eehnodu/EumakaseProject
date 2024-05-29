package com.smhrd.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.smhrd.db.MemberMapper;

@RestController
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
