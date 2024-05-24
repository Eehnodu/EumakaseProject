package com.smhrd.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public String join(MemberVO vo) {
		mapper.join(vo);
		return "redirect:/";
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

	@GetMapping("/mypage")
	public String mypage() {
		return "mypage";
	}

	@PostMapping("/update")
	public String update(MemberVO vo, HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		String memId = member.getMemId();
		vo.setMemId(memId);
		mapper.update(vo);
		return "redirect:/";
	}

	@PostMapping("/delete")
	public String delete(HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		String memId = member.getMemId();
		mapper.delete(memId);
		session.invalidate();
		return "redirect:/";
	}

}
