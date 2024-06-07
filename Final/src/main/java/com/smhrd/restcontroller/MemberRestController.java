package com.smhrd.restcontroller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.smhrd.db.MemberMapper;
import com.smhrd.db.SurveyMapper;
import com.smhrd.model.MemberVO;
import com.smhrd.model.SurveyVO;

@RestController
public class MemberRestController {

	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private SurveyMapper surveyMapper;
	
	@RequestMapping("/checkId")
	public String checkId(String memId) {
		String str = "";
		int checkId = memberMapper.checkId(memId);
		if (checkId == 1) { // 이미 존재하는 계정
			str = "NO";
		} else { // 사용 가능한 계정
			str = "YES";
		}
		return str;
	}

	@RequestMapping("/joiningSurvey")
	public List<SurveyVO> joiningSurvey() {
		System.out.println("장르를보여주세요");
		
		System.out.println();
		List<SurveyVO> SurveyList = surveyMapper.joiningSurvey();
		
		return SurveyList;
	}
	
	@PostMapping("/joiningProcess")
	public void joining(MemberVO vo, HttpSession session) {
		session.setAttribute("member", vo); // 첫번째 입력의 정보를 저장
		System.out.println("vo정보 ->>> "+vo.getName());
		System.out.println("vo정보 ->>> "+vo.getMemId());
		System.out.println("vo정보 ->>> "+vo.getMemPw());
		System.out.println("vo정보 ->>> "+vo.getBirth());
		System.out.println("vo정보 ->>> "+vo.getGender());
		
		
		
		/*
		mapper.join(vo);
		vo.setMemPw(null);
		vo.setGender(null);
		session.setAttribute("member", vo);
		*/
		
	}
	
//	// 선택 결과를 ai 추천 모델에 넘기는 함수
//	@RequestMapping("/playlistDetail")
//	public String playlistDetail(@RequestParam(name = "response", required = false) List<String> responses,
//			Model model) {
//		List<Integer> result = new ArrayList<>();
//		if (responses != null) {
//			try {
//				for (int i = 0; i < responses.size(); i++) {
//					result.add(Integer.parseInt(responses.get(i)));
//					
//				}
//			} catch(Exception e) {
//				return "/";
//			}
//			System.out.println(result);
//			return "playlistDetail";
//		}else {
//			return "/";
//		}
//	}
	
}
