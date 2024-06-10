package com.smhrd.restcontroller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.smhrd.db.ContextMapper;
import com.smhrd.db.MemberMapper;
import com.smhrd.db.MusicMapper;
import com.smhrd.db.PreferenceMapper;
import com.smhrd.db.SurveyMapper;
import com.smhrd.model.MemberVO;
import com.smhrd.model.MusicVO;
import com.smhrd.model.PreferenceVO;
import com.smhrd.model.SurveyVO;

@RestController
public class MemberRestController {

	@Autowired
	private MemberMapper memberMapper;

	@Autowired
	private SurveyMapper surveyMapper;

	@Autowired
	private PreferenceMapper preferenceMapeer;

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

	@RequestMapping("/joinProcess")
	public void join(@RequestBody MemberVO vo, HttpSession session) {
		System.out.println(vo);

		// 세션이 존재하는지 확인
		if (session.getAttribute("member") != null) {
			// 세션이 존재하면 세션을 무효화
			session.invalidate();
			// 새로운 세션을 생성
		}

		// 새로운 세션 또는 기존 세션에 새로운 값을 부여
		session.setAttribute("member", vo);
	}

	@RequestMapping("/joiningSurvey")
	public List<SurveyVO> joiningSurvey(HttpSession session) {
		// System.out.println("장르를보여주세요");
		if (session != null) {
			System.out.println("세션이 존재합니다 삭제하겠습니다");
			session.invalidate();
		}

		List<SurveyVO> SurveyList = surveyMapper.joiningSurvey();

		return SurveyList;
	}

	@PostMapping("/joiningProcess")
	public MemberVO joining(MemberVO vo, HttpSession session) {
		if (session != null) {
			System.out.println("세션이 존재합니다 삭제하겠습니다");
			session.invalidate();
		}
		return vo;
	}

	@RequestMapping("/preference")
	public void preferencejoin(@RequestBody List<String> surDescList, HttpSession session) {
		System.out.println("preference 들어옴");
		// System.out.println("genre :" + surDescList);
		
		if (session != null) {
			List<SurveyVO> SurveyIdx = surveyMapper.selectSurvey(surDescList);
			List<Integer> surIdxList = SurveyIdx.stream().map(SurveyVO::getSurIdx).collect(Collectors.toList());
			MemberVO vo = (MemberVO) session.getAttribute("member");
			String memId = vo.getMemId();
			memberMapper.join(vo);
			preferenceMapeer.insertPref(memId, surIdxList);
		}
		session.invalidate();
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
