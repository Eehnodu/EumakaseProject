package com.smhrd.restcontroller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

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
		System.out.println("joinprocess들어옴");

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
		session.invalidate();
		if (session != null) {
			List<SurveyVO> SurveyIdx = surveyMapper.selectSurvey(surDescList);
			List<Integer> surIdxList = SurveyIdx.stream().map(SurveyVO::getSurIdx).collect(Collectors.toList());
			MemberVO vo = (MemberVO) session.getAttribute("member");
			String memId = vo.getMemId();
			memberMapper.join(vo);
			preferenceMapeer.insertPref(memId, surIdxList);
		}

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


	@RequestMapping("{cpath}/getMusic")
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

	@RequestMapping("{cpath}/getEmotion")
	@ResponseBody
	public Map<String, Integer> getEmotion(HttpSession session) {
	    MemberVO member = (MemberVO) session.getAttribute("member");
	    List<ContextVO> getEmotion = contextMapper.chartjs(member);
	    List<SurveyVO> surveyList = new ArrayList<>();
	    for (ContextVO context : getEmotion) {
	        SurveyVO survey = surveyMapper.getEmotion(context);
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
	@RequestMapping("{cpath}/getIntro")
	@ResponseBody
	public Map<String, Object> getIntro() {	    
	    // 컨텍스트 매퍼로부터 ContextVO 목록을 가져옵니다.
	    List<ContextVO> getIntro = contextMapper.getIntro();
	    System.out.println("getIntro: " + getIntro);
	    
	    // SurveyVO 목록을 저장할 리스트를 초기화합니다.
	    List<SurveyVO> surveyList = new ArrayList<>();
	    
	    // 각 ContextVO에 대한 SurveyVO를 가져와서 surveyList에 추가합니다.
	    for (ContextVO context : getIntro) {
	        SurveyVO survey = surveyMapper.getIntro(context);
	        if (survey != null) {
	            surveyList.add(survey);
	        }
	    }
	    System.out.println("surveyList : " + surveyList);
	    
	    // 장르와 감정에 대한 빈도를 저장할 맵을 생성합니다.
	    Map<String, Integer> genreFrequencyMap = new HashMap<>();
	    Map<String, Integer> emotionFrequencyMap = new HashMap<>();
	    
	    // 장르와 감정에 대한 빈도수 계산
	    for (SurveyVO survey : surveyList) {
	        if (survey != null && survey.getSurDesc() != null && survey.getSurType().equals("A")) {
	            String surItem = survey.getSurItem();
	            String surDesc = survey.getSurDesc();
	            if (surItem.equals("genre")) {
	                genreFrequencyMap.put(surDesc, genreFrequencyMap.getOrDefault(surDesc, 0) + 1);
	            } else if (surItem.equals("emotion")) {
	                emotionFrequencyMap.put(surDesc, emotionFrequencyMap.getOrDefault(surDesc, 0) + 1);
	            }
	        }
	    }

	    // 상위 3개의 장르와 감정을 추출합니다.
	    List<String> top3Genres = genreFrequencyMap.entrySet().stream()
	        .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
	        .limit(3)
	        .map(Map.Entry::getKey)
	        .collect(Collectors.toList());
	    
	    List<String> top3Emotions = emotionFrequencyMap.entrySet().stream()
	        .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
	        .limit(3)
	        .map(Map.Entry::getKey)
	        .collect(Collectors.toList());
	   
	    System.out.println(top3Genres);
	    System.out.println(top3Emotions);
	    
	    // 노래 빈도수를 저장할 맵을 생성합니다.
	    Map<String, List<String>> topSongsByGenre = new HashMap<>();
	    Map<String, List<String>> topSongsByEmotion = new HashMap<>();

	    // 각 상위 장르에 대해 musicIdx를 추출하고 노래 빈도수를 계산합니다.
	    for (String genre : top3Genres) {
	        Map<String, Integer> songFrequencyMap = new HashMap<>();
	        List<Integer> surveyIds = surveyMapper.getSurveyIdsByDesc(genre);
	        for (Integer surveyId : surveyIds) {
	            List<Integer> contextIds = contextMapper.getContextIdsBySurveyId(surveyId);
	            for (Integer contextId : contextIds) {
	                List<Integer> musicIdxList = musicMapper.getMusicIdxByContextId(contextId);
	                for (Integer musicIdx : musicIdxList) {
	                    MusicVO music = musicMapper.getMusicById(musicIdx);
	                    if (music != null) {
	                        String songKey = music.getArtist() + " - " + music.getTitle();
	                        songFrequencyMap.put(songKey, songFrequencyMap.getOrDefault(songKey, 0) + 1);
	                    }
	                }
	            }
	        }
	        List<String> top5Songs = songFrequencyMap.entrySet().stream()
	            .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
	            .limit(5)
	            .map(Map.Entry::getKey)
	            .collect(Collectors.toList());
	        topSongsByGenre.put(genre, top5Songs);
	    }

	    // 각 상위 감정에 대해 musicIdx를 추출하고 노래 빈도수를 계산합니다.
	    for (String emotion : top3Emotions) {
	        Map<String, Integer> songFrequencyMap = new HashMap<>();
	        List<Integer> surveyIds = surveyMapper.getSurveyIdsByDesc(emotion);
	        for (Integer surveyId : surveyIds) {
	            List<Integer> contextIds = contextMapper.getContextIdsBySurveyId(surveyId);
	            for (Integer contextId : contextIds) {
	                List<Integer> musicIdxList = musicMapper.getMusicIdxByContextId5(contextId);
	                for (Integer musicIdx : musicIdxList) {
	                    MusicVO music = musicMapper.getMusicById(musicIdx);
	                    if (music != null) {
	                        String songKey = music.getArtist() + " - " + music.getTitle();
	                        songFrequencyMap.put(songKey, songFrequencyMap.getOrDefault(songKey, 0) + 1);
	                    }
	                }
	            }
	        }
	        List<String> top5Songs = songFrequencyMap.entrySet().stream()
	            .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
	            .limit(5)
	            .map(Map.Entry::getKey)
	            .collect(Collectors.toList());
	        topSongsByEmotion.put(emotion, top5Songs);
	    }

	    // JSON 형식으로 반환할 데이터 맵을 생성합니다.
	    Map<String, Object> responseData = new HashMap<>();
	    responseData.put("genre_labels", new ArrayList<>(genreFrequencyMap.keySet())); // 장르 라벨 추가
	    responseData.put("genre_counts", new ArrayList<>(genreFrequencyMap.values())); // 장르 개수 추가
	    responseData.put("emotion_labels", new ArrayList<>(emotionFrequencyMap.keySet())); // 감정 라벨 추가
	    responseData.put("emotion_counts", new ArrayList<>(emotionFrequencyMap.values())); // 감정 개수 추가
	    responseData.put("top_songs_by_genre", topSongsByGenre); // 장르별 상위 5개의 노래 추가
	    responseData.put("top_songs_by_emotion", topSongsByEmotion); // 감정별 상위 5개의 노래 추가
	    
	    // Output text
	    System.out.println("Genre Frequency Map: " + genreFrequencyMap);
	    System.out.println("Emotion Frequency Map: " + emotionFrequencyMap);
	    System.out.println("Top Songs by Genre: " + topSongsByGenre);
	    System.out.println("Top Songs by Emotion: " + topSongsByEmotion);
	    
	    return responseData;
	}




	
	
	
	
	/*
	 * @RequestMapping("{cpath}/getIntroMusic")
	 * 
	 * @ResponseBody public Map<String, Integer> getIntroMusic() {
	 * List<MyPlaylistVO> allPlaylists = myplaylistMapper.getIntroMusic();
	 * 
	 * List<AiPlaylistVO> getIntroMusic = new ArrayList<>();
	 * 
	 * for (MyPlaylistVO playlist : allPlaylists) { List<AiPlaylistVO>
	 * musicForPlaylist = aiplaylistMapper.getIntroMusic(playlist.getMyplIdx());
	 * getIntroMusic.addAll(musicForPlaylist); } System.out.println("All Music: " +
	 * getIntroMusic);
	 * 
	 * // 아티스트 및 제목과 그 빈도수를 저장할 맵입니다. Map<String, Integer> artistTitleFrequency =
	 * new HashMap<>();
	 * 
	 * // 각 musicIdx에 해당하는 아티스트 및 제목을 가져와서 빈도수를 계산합니다. for (AiPlaylistVO music :
	 * getIntroMusic) { MusicVO musicInfo = musicMapper.getIntroMusic(music); if
	 * (musicInfo != null) { String artistTitle = musicInfo.getArtist() + " - " +
	 * musicInfo.getTitle(); artistTitleFrequency.put(artistTitle,
	 * artistTitleFrequency.getOrDefault(artistTitle, 0) + 1); } }
	 * 
	 * System.out.println("Artist-Title 빈도수 맵: " + artistTitleFrequency);
	 * 
	 * return artistTitleFrequency; }
	 */

}
