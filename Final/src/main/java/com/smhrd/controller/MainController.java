package com.smhrd.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.smhrd.db.MemberMapper;
import com.smhrd.model.MemberVO;

@Controller
public class MainController {

	@Autowired
	private MemberMapper mapper;

	@GetMapping("/")
	public String intro() {
		return "intro";
	}

	@GetMapping("/join")
	public String join() {
		return "join";
	}

	@PostMapping("/joinProcess")
	public String join(MemberVO vo, HttpSession session) {
		mapper.join(vo);
		vo.setMemPw(null);
		vo.setGender(null);
		session.setAttribute("member", vo);
		return "redirect:/main";
	}

	@PostMapping("/login")
	public String login(MemberVO vo, HttpSession session) {
		MemberVO result = mapper.login(vo);
		if (result != null) {
			session.setAttribute("member", result);
			return "redirect:/main";
		} else {
			return "redirect:/";
		}
	}

	@PostMapping("/logout")
	public String logout(MemberVO vo, HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	@GetMapping("/main")
	public String main() {
		return "main";
	}
	
	@GetMapping("/maincontent")
	public String maincontent() {
		return "maincontent";
	}

	@GetMapping("/mypage")
	public String mypage() {
		return "mypage";
	}

	@GetMapping("/update")
	public String update() {
		return "update";
	}
	
	@GetMapping("/playlistDetail")
	public String playlistDetail() {
		return "playlistDetail";
	}

	@PostMapping("/update")
	public String update(MemberVO vo, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		vo.setMemId(member.getMemId());
		mapper.update(vo);
		return "redirect:/main";
	}
	
	@PostMapping("/delete")
	public String delete(MemberVO vo, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		String memId = member.getMemId();
		vo.setMemId(memId);

		// 비밀번호 일치 확인
	    int count = mapper.checkDelete(vo);
	    if (count == 1) {
        	mapper.delete(vo);
        	session.invalidate();
        	return "redirect:/";
        }else {
        	return "redirect:/mypage";
        }
	}

}
