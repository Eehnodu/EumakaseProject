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
	public void insertMyPlayList(MyPlaylistVO mvo) {
		System.out.println("다른사람꺼 저장들어오냐?");
		System.out.println(mvo);
		myplaylistMapper.insertMypl(mvo);
		aiplaylistMapper.insertCopyPlayList(mvo);
	}
	
	@RequestMapping("/checkmymy")// 내가 누구인지 궁금해
	public String checkmymy(HttpSession session) {
		MemberVO vo = (MemberVO) session.getAttribute("member");
		return vo.getMemId();
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
}
