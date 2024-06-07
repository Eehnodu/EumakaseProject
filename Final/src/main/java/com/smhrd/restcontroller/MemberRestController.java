package com.smhrd.restcontroller;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.smhrd.db.MemberMapper;
import com.smhrd.db.PreferenceMapper;
import com.smhrd.db.SurveyMapper;
import com.smhrd.model.MemberVO;
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
		session.invalidate();
		System.out.println("joinprocess들어옴");
		
		session.setAttribute("member", vo);
	}

	@RequestMapping("/joiningSurvey")
	public List<SurveyVO> joiningSurvey() {
		//System.out.println("장르를보여주세요");
		List<SurveyVO> SurveyList = surveyMapper.joiningSurvey();

		return SurveyList;
	}

	@PostMapping("/joiningProcess")
	public MemberVO joining(MemberVO vo) {
		return vo;
	}

	@RequestMapping("/preference")
	public void preferencejoin(@RequestBody List<String> surDescList, HttpSession session) {
		//System.out.println("preference 들어옴");
		//System.out.println("genre :" + surDescList);
		List<SurveyVO> SurveyIdx = surveyMapper.selectSurvey(surDescList);

		List<Integer> surIdxList = SurveyIdx.stream().map(SurveyVO::getSurIdx).collect(Collectors.toList());


		//System.out.println(surIdxList);
		MemberVO vo = (MemberVO) session.getAttribute("member");
		session.invalidate();
		//System.out.println(vo.getMemId());
		String memId = vo.getMemId();
		memberMapper.join(vo);
		preferenceMapeer.insertPref(memId,surIdxList);
		
		
	}
}
