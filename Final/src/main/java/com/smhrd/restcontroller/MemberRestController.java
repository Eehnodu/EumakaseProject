package com.smhrd.restcontroller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.*;
import javax.naming.Context;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
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

	@Autowired
	private RestTemplate restTemplate;

	@RequestMapping("/updateMyPlayList")
	public void updateMyPlayList(String newPlaylistName, int myplIdx) {
		MyPlaylistVO mvo = new MyPlaylistVO();
		mvo.setMyplIdx(myplIdx);
		mvo.setPlName(newPlaylistName);
		myplaylistMapper.updateMyPlayList(mvo);
	}

	@RequestMapping("/deleteMyPlayList")
	public void deleteMyPlayList(MyPlaylistVO mvo) {
		myplaylistMapper.deleteMyPlayList(mvo);
	}

	@RequestMapping("/insertCopyPlayList")
	public void insertMyPlayList(MyPlaylistVO mvo, HttpSession session) {
		String memId = ((MemberVO) session.getAttribute("member")).getMemId();
		mvo.setMemId(memId);

		List<Integer> surIdxList = (List<Integer>) session.getAttribute("userSurIdxList");
		Collections.reverse(surIdxList);

		ContextVO convo = new ContextVO();
		convo.setMemId(memId);

		// ContextVO 객체 리스트 생성
		for (int surIdx : surIdxList) {
			convo.setSurIdx(surIdx);
			contextMapper.insertCopyContext(convo);
		}

		myplaylistMapper.insertMypl(mvo);
		aiplaylistMapper.insertCopyPlayList(mvo);
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
		if (session != null) {
			session.invalidate();
		}

		List<SurveyVO> SurveyList = surveyMapper.joiningSurvey();

		return SurveyList;
	}

	@PostMapping("/joiningProcess")
	public MemberVO joining(MemberVO vo, HttpSession session) {
		if (session != null) {
			session.invalidate();
		}
		return vo;
	}

	@RequestMapping("/preference")
	public void preferencejoin(@RequestBody List<String> surDescList, HttpSession session) {
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

	

	@PostMapping("/otherPlaylist")
	public ResponseEntity<List<MusicVO>> otherPlaylist(@RequestParam("value") String genre, HttpSession session) {
		String input_keywords = (String) session.getAttribute("input_keywords");
		session.setAttribute("input_genre", genre);

		try {
			// Flask API 호출
			String url = "http://localhost:5000/recommend";

			// 요청 바디 생성
			Map<String, String> requestBody = new HashMap<>();
			requestBody.put("keywords", input_keywords.trim());
			requestBody.put("genre", genre);

			// HttpHeaders 설정
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", "application/json");

			// 요청 엔티티 생성
			HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(requestBody, headers);

			// 요청 보내기 및 응답 받기
			ResponseEntity<String[]> responseEntity = restTemplate.exchange(url, HttpMethod.POST, requestEntity,
					String[].class);

			// 추천 결과를 모델에 추가
			String[] recommendations = responseEntity.getBody();
			List<String> recommendationList = Arrays.asList(recommendations); // 추천 결과를 리스트로 변환
			session.setAttribute("recommendations", recommendationList); // 모델에 리스트로 추가

			List<MusicVO> musicList = new ArrayList<>();
			MusicVO musicvo = new MusicVO();

			// 추천 받은 노래의 음원 정보 가져오기
			for (String list : recommendationList) {
				String[] parts = list.split(" - ", 2);
				if (parts.length == 2) {
					musicvo.setArtist(parts[0]); // 가수
					musicvo.setTitle(parts[1]); // 곡명
				} else {
					// 만약 구분자가 없는 경우 (예외 처리)
					musicvo.setArtist(list);
					musicvo.setTitle("");
				}
				// MusicVO에서 일치하는 정보 가져와야함
				musicList.add(musicMapper.getMusic(musicvo));
			}
			session.setAttribute("musicList", musicList);
			// 가져온 음원의 정보를 'musicList'로 반환
			return ResponseEntity.ok(musicList);

		} catch (HttpServerErrorException e) {
			// 서버 오류 처리
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		} catch (RestClientException e) {
			// 클라이언트 오류 처리
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
		} catch (NumberFormatException e) {
			// 숫자 형식 오류 처리
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
		} catch (Exception e) {
			// 일반적인 예외 처리
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}
	}

	
	
	@PostMapping("/getIntro")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getIntroData() {
	    String flaskApiUrl = "http://localhost:5000";
	    RestTemplate restTemplate = new RestTemplate();

	    try {
	        // Fetch genre data
	        Map<String, Object> genreResponse = restTemplate.postForObject(flaskApiUrl + "/getintrogenre", null, Map.class);
	        List<Map<String, Object>> genreData = (List<Map<String, Object>>) genreResponse.get("genre_data");

	        // Fetch emotion data
	        Map<String, Object> emotionResponse = restTemplate.postForObject(flaskApiUrl + "/getintroemotion", null, Map.class);
	        List<Map<String, Object>> emotionData = (List<Map<String, Object>>) emotionResponse.get("emotion_data");

	        // Fetch top songs by genre
	        Map<String, Object> genreTop5Response = restTemplate.postForObject(flaskApiUrl + "/getintrogenretop5", null, Map.class);
	        Map<String, List<Map<String, Object>>> topSongsByGenre = (Map<String, List<Map<String, Object>>>) genreTop5Response.get("top_songs_by_genre");

	        // Fetch top songs by emotion
	        Map<String, Object> emotionTop5Response = restTemplate.postForObject(flaskApiUrl + "/getintroemotiontop5", null, Map.class);
	        Map<String, List<Map<String, Object>>> topSongsByEmotion = (Map<String, List<Map<String, Object>>>) emotionTop5Response.get("top_songs_by_emotion");

	        // Combine all data into a single map
	        Map<String, Object> responseData = new HashMap<>();
	        responseData.put("genre_data", genreData);
	        responseData.put("emotion_data", emotionData);
	        responseData.put("top_songs_by_genre", topSongsByGenre);
	        responseData.put("top_songs_by_emotion", topSongsByEmotion);

	        return ResponseEntity.ok(responseData);
	    } catch (Exception e) {
	        // 로그 출력
	        e.printStackTrace();
	        // 오류가 발생하면 적절한 HTTP 상태 코드와 메시지 반환
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	    }
	}
	
}