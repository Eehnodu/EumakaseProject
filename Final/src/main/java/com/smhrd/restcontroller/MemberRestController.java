package com.smhrd.restcontroller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
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
import com.smhrd.db.AiPlaylistMapper;
import com.smhrd.db.ContextMapper;
import com.smhrd.db.MemberMapper;
import com.smhrd.db.MusicMapper;
import com.smhrd.db.MyPlaylistMapper;
import com.smhrd.db.PreferenceMapper;
import com.smhrd.db.SurveyMapper;
import com.smhrd.model.AiPlaylistVO;
import com.smhrd.model.ContextVO;
import com.smhrd.model.MemberVO;
import com.smhrd.model.MusicVO;
import com.smhrd.model.MyPlaylistVO;
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

	@Autowired
	private ContextMapper contextMapper;
	
	@Autowired
	private AiPlaylistMapper aiplaylistMapper;
	
	@Autowired
	private MusicMapper musicMapper;
	
	@Autowired
	private MyPlaylistMapper myplaylistMapper;
	
	@RequestMapping("/updateMyPlayList")
	public void updateMyPlayList(@RequestParam("plName") String plName, MyPlaylistVO mvo) {
		System.out.println("업데이트@@@@@마플리@@@@@변경할이름가져오냐@@@@");
		System.out.println(plName);
		//MyPlaylistVO myplymvo = new MyPlaylistVO();
		//myplymvo.setPlName(plName);
		//myplymvo.setMyplIdx(mvo.getMyplIdx());
		//myplaylistMapper.updateMyPlayList(myplymvo);
	}
	
	@RequestMapping("/deleteMyPlayList")
	public void deleteMyPlayList(MyPlaylistVO mvo) {
		System.out.println(mvo.getMyplIdx());
		//myplaylistMapper.deleteMyPlayList(mvo);
	}

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
	
	
	@RequestMapping("{cpath}/chartjs")
	@ResponseBody
	public Map<String, Integer> getChartData(HttpSession session) {
	    MemberVO member = (MemberVO) session.getAttribute("member");
	    List<ContextVO> chartjs = contextMapper.chartjs(member);
	    List<SurveyVO> surveyList = new ArrayList<>();
	    for (ContextVO context : chartjs) {
	        SurveyVO survey = surveyMapper.surbayIdx(context);
	        if (survey != null) {
	            surveyList.add(survey);
	        }
	    }
	    // 빈도를 세기 위한 맵 생성
	    Map<String, Integer> frequencyMap = new HashMap<>();
	    for (SurveyVO survey : surveyList) {
	        if (survey != null && survey.getSurDesc() != null) { // Add null check
	            String surDesc = survey.getSurDesc();
	            // 맵에 이미 해당 값이 있다면 기존 값에 1을 더하고, 없으면 새로운 키로 추가
	            frequencyMap.put(surDesc, frequencyMap.getOrDefault(surDesc, 0) + 1);
	        }
	    }
	    
	    // 상위 3개의 값과 각 값의 개수를 구하기 위해 맵을 내림차순으로 정렬
	    List<Map.Entry<String, Integer>> sortedList = new ArrayList<>(frequencyMap.entrySet());
	    sortedList.sort((a, b) -> b.getValue().compareTo(a.getValue()));

	    // 결과를 담을 맵 생성
	    Map<String, Integer> top3Values = new LinkedHashMap<>();
	    for (int i = 0; i < Math.min(3, sortedList.size()); i++) {
	        Map.Entry<String, Integer> entry = sortedList.get(i);
	        top3Values.put(entry.getKey(), entry.getValue());
	    }
	    return top3Values;
	}


	@RequestMapping("{capth}/getMusic")
	@ResponseBody
	public Map<String, Object> getMusic(HttpSession session) {
	    MemberVO member = (MemberVO) session.getAttribute("member");
	    
	    List<ContextVO> getContextIdx = contextMapper.getContextIdx(member);
	    
	    List<AiPlaylistVO> musicidxList = new ArrayList<>();
	    for (ContextVO context : getContextIdx) {
	        List<AiPlaylistVO> musicList = aiplaylistMapper.getMusicIdx(context); 
	        musicidxList.addAll(musicList); // Add all musicIdx values for the current context
	    }
	    
	    
	    List<MusicVO> musicDetailsList = new ArrayList<>();
	    for (AiPlaylistVO aiPlaylist : musicidxList) {
	        List<MusicVO> musicDetails = musicMapper.getChartMusic(aiPlaylist);
	        musicDetailsList.addAll(musicDetails); // Correctly adding the list of MusicVO objects
	    }

	    // Count frequencies
	    Map<String, Integer> frequencyMap = new HashMap<>();
	    for (MusicVO music : musicDetailsList) {
	        String titleArtist = music.getTitle() + ", " + music.getArtist();
	        frequencyMap.put(titleArtist, frequencyMap.getOrDefault(titleArtist, 0) + 1);
	    }

	    // 상위 5개 음악 추출
	    List<Map.Entry<String, Integer>> top5Entries = frequencyMap.entrySet().stream()
	                                                                    .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
	                                                                    .limit(5)
	                                                                    .collect(Collectors.toList());

	    // Prepare data to send to the client
	    List<String> labels = new ArrayList<>();
	    List<Integer> counts = new ArrayList<>();
	    for (Map.Entry<String, Integer> entry : top5Entries) {
	        labels.add(entry.getKey());
	        counts.add(entry.getValue());
	    }

	    // Construct the response map
	    Map<String, Object> responseMap = new HashMap<>();
	    responseMap.put("labels", labels);
	    responseMap.put("counts", counts);
	    return responseMap;
	}
}
