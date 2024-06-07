package com.smhrd.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.smhrd.db.MemberMapper;
import com.smhrd.db.SurveyMapper;
import com.smhrd.model.MemberVO;
import com.smhrd.model.SurveyVO;
import java.util.Random;

@Controller
public class MainController {

	@Autowired
	private MemberMapper mapper;

	@Autowired
	private SurveyMapper surveyMapper;

	@GetMapping("/AIquestion")
	public String AIquestion() {
		return "AIquestion";
	}

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

		session.getAttribute("member");

		/*
		 * mapper.join(vo); vo.setMemPw(null); vo.setGender(null);
		 * session.setAttribute("member", vo);
		 */

		return "redirect:/mainPage";
	}

	@PostMapping("/login")
	public String login(@RequestParam("loginId") String memId, @RequestParam("loginPw") String memPw,
			HttpSession session, RedirectAttributes redirectAttributes) {
		MemberVO vo = new MemberVO();
		vo.setMemId(memId);
		vo.setMemPw(memPw);
		MemberVO result = mapper.login(vo);
		if (result != null) {
			session.setAttribute("member", result);
			return "redirect:/mainPage";
		} else {
			redirectAttributes.addFlashAttribute("errorMessage", "아이디 또는 비밀번호가 일치하지 않습니다.");
			return "redirect:/";
		}
	}

	@PostMapping("/logout")
	public String logout(MemberVO vo, HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	@GetMapping("/mypage")
	public String mypage() {
		return "mypage";
	}

	@GetMapping("/mainPage")
	public String mainPage() {
		return "mainPage";
	}

	@GetMapping("/AIrecommend")
	public String AIrecommend(Model model) {
		Random ran = new Random();
		List<SurveyVO> Que = surveyMapper.aiQuestion();
		List<SurveyVO> Ans = surveyMapper.aiAnswer();
		Map<String, List<SurveyVO>> questionMap = new HashMap<>();
		Map<String, List<SurveyVO>> answerMap = new HashMap<>();

		// 카테고리 초기화
		String[] categories = { "emotion", "situation", "place", "people", "genre" };
		for (String category : categories) {
			questionMap.put(category, new ArrayList<>());
			answerMap.put(category, new ArrayList<>());
		}

		// 질문을 카테고리별로 분류
		for (SurveyVO que : Que) {
			if (questionMap.containsKey(que.getSurItem())) {
				questionMap.get(que.getSurItem()).add(que);
			}
		}

		// 답변을 카테고리별로 분류
		for (SurveyVO ans : Ans) {
			if (answerMap.containsKey(ans.getSurItem())) {
				answerMap.get(ans.getSurItem()).add(ans);
			}
		}

		// 랜덤 질문을 모델에 추가
		for (String category : categories) {
			List<SurveyVO> ques = questionMap.get(category);
			if (!ques.isEmpty()) {
				model.addAttribute(category + "Que", ques.get(ran.nextInt(ques.size())));
			}
		}

		// 모든 답변을 모델에 추가
		for (String category : categories) {
			model.addAttribute(category + "Ans", answerMap.get(category));
		}

		return "AIrecommend";
	}

	@GetMapping("/userPlaylist")
	public String userPlaylist() {
		return "userPlaylist";
	}

	@GetMapping("/update")
	public String update() {
		return "update";
	}

	@GetMapping("/playlistDetail")
	public String playlistDetail(@RequestParam(name = "response", required = false) List<String> responses,
			Model model) {
		// 전달받은 response 값을 모델에 추가
		model.addAttribute("responses", responses);
		System.out.println(responses);
		return "playlistDetail";
	}

	@PostMapping("/update")
	public String update(@RequestParam("oldPw") String oldPw, @RequestParam("newPw") String memPw, HttpSession session,
			RedirectAttributes redirectAttributes) {
		MemberVO vo = new MemberVO();
		MemberVO member = (MemberVO) session.getAttribute("member");

		// 비밀번호 일치 여부 확인
		vo.setMemId(member.getMemId());
		vo.setMemPw(oldPw);
		int count = mapper.checkPw(vo);

		if (count == 1) { // 비밀번호가 일치하는 경우
			vo.setMemPw(memPw); // 새 비밀번호로 설정
			mapper.update(vo); // 비밀번호 업데이트
			return "redirect:/mainPage";
		} else { // 비밀번호가 일치하지 않는 경우
			redirectAttributes.addFlashAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
			return "redirect:/update";
		}
	}

	@PostMapping("/delete")
	public String delete(MemberVO vo, HttpSession session, RedirectAttributes redirectAttributes) {
		MemberVO member = (MemberVO) session.getAttribute("member");
		String memId = member.getMemId();
		vo.setMemId(memId);

		// 비밀번호 일치 확인
		int count = mapper.checkDelete(vo);
		if (count == 1) {
			mapper.delete(vo);
			session.invalidate();
			return "redirect:/";
		} else {
			redirectAttributes.addFlashAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
			return "redirect:/update";
		}
	}

}
