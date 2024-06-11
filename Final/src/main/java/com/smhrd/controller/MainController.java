package com.smhrd.controller;

import java.nio.file.spi.FileSystemProvider;
import java.time.LocalDate;
import java.time.Month;
import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.smhrd.db.AiPlaylistMapper;
import com.smhrd.db.ContextMapper;
import com.smhrd.db.MemberMapper;
import com.smhrd.db.MusicMapper;
import com.smhrd.db.MyPlaylistMapper;
import com.smhrd.db.SurveyMapper;
import com.smhrd.model.AiPlaylistVO;
import com.smhrd.model.ContextVO;
import com.smhrd.model.MemberVO;
import com.smhrd.model.MusicVO;
import com.smhrd.model.MyPlaylistVO;
import com.smhrd.model.SurveyVO;
import com.smhrd.restcontroller.MemberRestController;

@Controller
public class MainController {

	@Autowired
	private MemberMapper mapper;

	@Autowired
	private SurveyMapper surveyMapper;

	@Autowired
	private ContextMapper contextMapper;

	@Autowired
	private MusicMapper musicMapper;

	@Autowired
	private AiPlaylistMapper aiplaylistMapper;

	@Autowired
	private MyPlaylistMapper myplaylistMapper;

	@Autowired
	private RestTemplate restTemplate;

	@GetMapping("/AIquestion")
	public String AIquestion() {
		return "AIquestion";
	}

	@GetMapping("/")
	public String intro(Model model, HttpSession session) {
		try {
			// 현재 날짜에서 월을 가져오기
			LocalDate currentDate = LocalDate.now();
			Month currentMonth = currentDate.getMonth();

			// 월에 따라 계절 결정
			String season = "";
			switch (currentMonth) {
			case DECEMBER:
			case JANUARY:
			case FEBRUARY:
				season = "겨울";
				break;
			case MARCH:
			case APRIL:
			case MAY:
				season = "봄";
				break;
			case JUNE:
			case JULY:
			case AUGUST:
				season = "여름";
				break;
			case SEPTEMBER:
			case OCTOBER:
			case NOVEMBER:
				season = "가을";
				break;
			}

			// 장르 리스트
			List<SurveyVO> genres = surveyMapper.getSeasonGenre();

			// 랜덤으로 장르 선택
			Random random = new Random();
			String genre = genres.get(random.nextInt(genres.size())).getSurDesc();

			// Flask API 호출
			String url = "http://localhost:5000/recommend";

			// 요청 바디 생성
			Map<String, String> requestBody = new HashMap<>();
			requestBody.put("keywords", season);
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
			List<String> recommendationList = Arrays.stream(recommendations).limit(6).collect(Collectors.toList()); // 추천
																													// 결과를
																													// 리스트로
																													// 변환
			session.setAttribute("seasonRec", recommendationList); // 모델에 리스트로 추가

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
				MusicVO musicFromDB = musicMapper.getMusic(musicvo);
				if (musicFromDB != null) {
					musicList.add(musicFromDB);
				}
			}
			// 가져온 음원의 정보를 'musicList'라는 모델에 추가
			session.setAttribute("seasonList", musicList);
			session.setAttribute("seasonName", season + "에 어울리는 " + genre + "🎧");

		} catch (HttpServerErrorException e) {
			// 서버 오류 처리
			model.addAttribute("error", "서버 오류가 발생했습니다: " + e.getMessage());
		} catch (RestClientException e) {
			// 클라이언트 오류 처리
			model.addAttribute("error", "요청 중 오류가 발생했습니다: " + e.getMessage());
		} catch (Exception e) {
			// 일반적인 예외 처리
			model.addAttribute("error", "예기치 않은 오류가 발생했습니다: " + e.getMessage());
		}
		return "intro";
	}

	@GetMapping("/join")
	public String join() {
		return "join";
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
	public String mypage(Model model, HttpSession session) {
		MemberVO memvo = (MemberVO) session.getAttribute("member");
		if (memvo == null) {
			return "redirect:/";
		}
		String memId = memvo.getMemId();

		List<MyPlaylistVO> myplayListIdx = myplaylistMapper.getMyplayList(memId);//
		model.addAttribute("myplayList", myplayListIdx);

		List<MusicVO> mymusic = musicMapper.getMyMusic(memId);
		model.addAttribute("myplayListalbumCov", mymusic);

		return "mypage";
	}

	@GetMapping("/mainPage")
	public String mainPage(HttpSession session) {

		// 중간에 장르 자동 추천
		// 장르와 선택지 리스트 가져오기
		List<SurveyVO> surveyList = surveyMapper.getRecSurvey();
		List<SurveyVO> genreList = surveyMapper.getSeasonGenre();

		// Map을 사용하여 설문 항목을 저장
		Map<String, List<String>> surveyMap = new HashMap<>();
		surveyMap.put("emotion", new ArrayList<>());
		surveyMap.put("situation", new ArrayList<>());
		surveyMap.put("place", new ArrayList<>());
		surveyMap.put("people", new ArrayList<>());

		for (SurveyVO survey : surveyList) {
			List<String> list = surveyMap.get(survey.getSurItem());
			if (list != null) {
				list.add(survey.getSurDesc());
			}
		}

		Random random = new Random();

		// 각 장르에 대한 추천 리스트를 담을 리스트
		List<List<String>> allRecList = new ArrayList<>();
		List<String> allSurveyList = new ArrayList<>();

		// 장르 인덱스를 포함하여 리스트 생성
		List<Map.Entry<Integer, SurveyVO>> indexedGenreList = new ArrayList<>();
		for (int i = 0; i < genreList.size(); i++) {
			indexedGenreList.add(new AbstractMap.SimpleEntry<>(i, genreList.get(i)));
		}

		for (Map.Entry<Integer, SurveyVO> entry : indexedGenreList) {
			int genreIndex = entry.getKey();
			String recGen = entry.getValue().getSurDesc();

			// 각 항목별로 랜덤 선택
			String recEmotion = surveyMap.get("emotion").get(random.nextInt(surveyMap.get("emotion").size()));
			String recSituation = surveyMap.get("situation").get(random.nextInt(surveyMap.get("situation").size()));
			String recPlace = surveyMap.get("place").get(random.nextInt(surveyMap.get("place").size()));
			String recPeople = surveyMap.get("people").get(random.nextInt(surveyMap.get("people").size()));

			String recStr = recEmotion + " " + recSituation + " " + recPlace + " " + recPeople;

			// 각 단어 앞에 '#' 추가
			String recSurvey = ("#" + recStr.replaceAll(" ", " #") + " #" + recGen).trim();

			// Flask API 호출
			String url = "http://localhost:5000/recommend";

			// 요청 바디 생성
			Map<String, String> requestBody = new HashMap<>();
			requestBody.put("keywords", recStr);
			requestBody.put("genre", recGen);

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
			List<String> recList = Arrays.asList(recommendations);
			allRecList.add(recList);
			allSurveyList.add(recSurvey);
		}

		// 각 장르별 추천 리스트를 세션에 저장, 장르를 세션에 저장(페이지 이동에 사용할 예정)
		session.setAttribute("recommendationMusic", allRecList);
		session.setAttribute("recSurvey", allSurveyList);
		session.setAttribute("indexedGenreList", indexedGenreList);

		// 추천 받은 노래의 음원 정보 가져오기
		List<List<MusicVO>> allRecMusicList = new ArrayList<>();
		for (List<String> recList : allRecList) {
			List<MusicVO> recMusicList = new ArrayList<>();
			for (String list : recList) {
				MusicVO musicvo = new MusicVO();
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
				MusicVO musicFromDB = musicMapper.getRecMusic(musicvo);
				if (musicFromDB != null) {
					recMusicList.add(musicFromDB);
				}
			}
			allRecMusicList.add(recMusicList);
		}

		// 각 장르별로 가져온 음원의 정보를 'recMusic'라는 세션에 추가
		session.setAttribute("recMusic", allRecMusicList);

		// 다른 사람은 뭐듣지? 값 가져오기
		MemberVO memvo = (MemberVO) session.getAttribute("member");

		if (memvo == null) {
			return "redirect:/";
		}

		String memId = memvo.getMemId();

		try {
			// 다른 사람의 mypl 정보 가져오기
			List<MyPlaylistVO> otherIdxList = myplaylistMapper.getOtherPl(memId);
			session.setAttribute("otherIdxList", otherIdxList);

			// 가져온 idx를 이용해서 개인의 playlist 가져오기
			List<List<AiPlaylistVO>> otherPlList = new ArrayList<>();
			// 가져온 playlist 정보에서 선택했던 tag 가져오기
			List<List<Integer>> otherSurIdxList = new ArrayList<>();
			// 가져은 playlist 정보에서 musicIdx 가져오기
			List<List<Integer>> otherMusicIdxList = new ArrayList<>();

			for (MyPlaylistVO other : otherIdxList) {
				// 가져온 playlist 정보
				List<AiPlaylistVO> tempPlList = aiplaylistMapper.getOtherPl(other);
				otherPlList.add(tempPlList);

				if (!tempPlList.isEmpty()) {
					AiPlaylistVO tempPl = tempPlList.get(0);

					// 각 contextIdx에 대한 surIdx 값을 가져오기
					int[] contextIdxArray = { tempPl.getContextIdx(), tempPl.getContextIdx2(), tempPl.getContextIdx3(),
							tempPl.getContextIdx4(), tempPl.getContextIdx5() };

					List<Integer> surIdxList = new ArrayList<>();
					for (int contextIdx : contextIdxArray) {
						surIdxList.add(contextMapper.getOtherSurIdx(contextIdx).getSurIdx());
					}

					otherSurIdxList.add(surIdxList);

					// playlist에서 musicIDx 가져오기
					List<Integer> musicIdxList = new ArrayList<>();
					for (AiPlaylistVO albumCov : tempPlList) {
						musicIdxList.add(albumCov.getMusicIdx());
					}
					otherMusicIdxList.add(musicIdxList);
				}
			}

			// 가져온 surIdx를 통해서 surDesc정보 가져오기
			List<String> otherSurDescList = new ArrayList<>();
			for (List<Integer> surIdxList : otherSurIdxList) {
				String otherSurDesc = "";
				for (int surIdx : surIdxList) {
					// surIdx에 해당하는 Desc값 가져오기
					otherSurDesc += "#" + surveyMapper.getOtherSurDesc(surIdx).getSurDesc() + " ";
				}
				otherSurDescList.add(otherSurDesc.trim());
			}
			// 가져온 musicIdx를 이용해서 albumCov 가져오기
			List<List<String>> otherAlbumCovList = new ArrayList<>();
			for (List<Integer> musicIdxList : otherMusicIdxList) {
				List<String> albumCovList = new ArrayList<>();
				for (int i = 0; i < 4; i++) {
					albumCovList.add(musicMapper.getOtherAlbumCov(musicIdxList.get(i)).getAlbumCov());
				}
				otherAlbumCovList.add(albumCovList);
			}

			// 가져온 otherPlaylist 정보를 session에 저장
			session.setAttribute("otherPlList", otherPlList);
			session.setAttribute("otherSurIdxList", otherSurIdxList);
			session.setAttribute("otherSurDescList", otherSurDescList);
			session.setAttribute("otherAlbumCovList", otherAlbumCovList);
			return "mainPage";

		} catch (Exception e) {
			return "redirect:/";
		}
	}

	@GetMapping("/recPlayList")
	public String recPlaylist(@RequestParam("genreIndex") int genreIndex, HttpSession session, Model model) {
		// 세션에서 추천 음악 리스트를 가져옴
		List<List<MusicVO>> allRecMusicList = (List<List<MusicVO>>) session.getAttribute("recMusic");

		if (allRecMusicList != null && genreIndex < allRecMusicList.size()) {
			// 해당 인덱스의 추천 음악 리스트를 가져옴
			List<MusicVO> recMusicList = allRecMusicList.get(genreIndex);
			// 추천 음악 리스트를 모델에 추가
			model.addAttribute("recMusicList", recMusicList);
		}

		return "recPlaylist"; // recPlaylist.jsp로 포워딩
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
	public String userPlaylist(@RequestParam("myplIdx") int myplIdx, Model model, HttpSession session) {

		// myplIdx는 pl의 고유값 myplIdx
		MyPlaylistVO userPl = myplaylistMapper.getUserPlaylist(myplIdx);
		
		String memId = userPl.getMemId();
		MemberVO memvo = mapper.getUserInfo(memId);
		String name = memvo.getName();

		MemberVO crudcheck = (MemberVO) session.getAttribute("member");
		
		MyPlaylistVO mvo = new MyPlaylistVO();
		
		if (userPl.getMemId().equals(crudcheck.getMemId())) {
			model.addAttribute("crud", true);
			mvo.setMyplIdx(userPl.getMyplIdx());
			mvo.setPlName("변경할 plName");
			model.addAttribute("mvo", mvo);
			//myplaylistMapper.updateMyPlayList(mvo);
			
			//MemberRestController memberRestController = new MemberRestController();
			//memberRestController.updateMyPlayList("plName", mvo);
			
			
		}else {
			model.addAttribute("crud", false);
		}

		// pl에 해당되는 mypl 정보 가져오기
		MyPlaylistVO otherIdx = myplaylistMapper.getUserPlaylist(myplIdx);
		// 가져온 idx를 이용해서 개인의 playlist 가져오기
		List<AiPlaylistVO> userPlList = aiplaylistMapper.getOtherPl(otherIdx);
		// 가져온 playlist 정보에서 선택했던 tag 가져오기
		List<Integer> userSurIdxList = new ArrayList<>();
		// 가져온 playlist 정보에서 musicIdx 가져오기
		List<Integer> userMusicIdxList = new ArrayList<>();

		if (!userPlList.isEmpty()) {
			AiPlaylistVO tempPl = userPlList.get(0);

			// 각 contextIdx에 대한 surIdx 값을 가져오기
			int[] contextIdxArray = { tempPl.getContextIdx(), tempPl.getContextIdx2(), tempPl.getContextIdx3(),
					tempPl.getContextIdx4(), tempPl.getContextIdx5() };

			for (int contextIdx : contextIdxArray) {
				userSurIdxList.add(contextMapper.getOtherSurIdx(contextIdx).getSurIdx());
			}

			// playlist에서 musicIDx 가져오기
			for (AiPlaylistVO userPlay : userPlList) {
				userMusicIdxList.add(userPlay.getMusicIdx());
			}
		}

		// 가져온 surIdx를 통해서 surDesc정보 가져오기
		StringBuilder userSurDesc = new StringBuilder();
		for (int surIdx : userSurIdxList) {
			// surIdx에 해당하는 Desc값 가져오기
			userSurDesc.append("#").append(surveyMapper.getOtherSurDesc(surIdx).getSurDesc()).append(" ");
		}

		// 가져온 musicIdx를 이용해서 playlist 가져오기
		List<MusicVO> userPlaylistList = new ArrayList<>();
		// albumCov 값을 저장할 리스트
		List<String> userAlbumCovList = new ArrayList<>();
		for (int musicIdx : userMusicIdxList) {
			userPlaylistList.add(musicMapper.getUserPlaylist(musicIdx));
			userAlbumCovList.add(musicMapper.getUserPlaylist(musicIdx).getAlbumCov());
		}

		// 가져온 userPlaylist 정보를 model에 저장
		model.addAttribute("userPlList", userPlList);
		model.addAttribute("userSurIdxList", userSurIdxList);
		model.addAttribute("userSurDescList", userSurDesc.toString().trim());
		model.addAttribute("userPlaylistList", userPlaylistList);
		model.addAttribute("userAlbumCovList", userAlbumCovList);

		model.addAttribute("userPl", userPl);
		model.addAttribute("name", name);

		return "userPlaylist";
	}

	@GetMapping("/update")
	public String update() {
		return "update";
	}

	@GetMapping("/playlistDetail")
	public String playlistDetail(@RequestParam(name = "response", required = false) List<String> responses, Model model,
			HttpSession session) {
		List<Integer> result = new ArrayList<>();
		if (responses != null) {
			try {
				for (String response : responses) {
					result.add(Integer.parseInt(response));
				}

				String input_keywords = "";
				String input_tag = "";
				String input_genre = "";
				String description = "";

				SurveyVO vo = new SurveyVO();
				for (int i = 0; i < result.size(); i++) {
					vo.setSurIdx(result.get(i));
					description = surveyMapper.aiSurveyAnser(vo).getSurDesc();
					input_keywords += " " + description;
					input_tag += "#" + description + " ";
					if (i == 4) {
						input_genre = description;
					}
				}

				// Model 객체에 선택했던 키워드와 장르 추가
				session.setAttribute("input_keywords", input_keywords.toString().trim());
				session.setAttribute("input_tag", input_tag.toString().trim());
				session.setAttribute("input_genre", input_genre);

				// 회원인지 아닌지 구분하여 context에 저장
				MemberVO member = (MemberVO) session.getAttribute("member");
				String memId = (member != null) ? member.getMemId() : "guest"; // 회원이 아니면 "guest"로 설정

				try {
					for (String response : responses) {
						Map<String, Object> params = new HashMap<>();
						params.put("memId", memId);
						params.put("surIdx", Integer.parseInt(response));
						contextMapper.insertContext(params);
					}
				} catch (Exception e) {
				}

				// Flask API 호출
				String url = "http://localhost:5000/recommend";

				// 요청 바디 생성
				Map<String, String> requestBody = new HashMap<>();
				requestBody.put("keywords", input_keywords.trim());
				requestBody.put("genre", input_genre);

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

				// 가져온 음원의 정보를 'musicList'라는 모델에 추가
				session.setAttribute("musicList", musicList);

			} catch (HttpServerErrorException e) {
				// 서버 오류 처리
				model.addAttribute("error", "서버 오류가 발생했습니다: " + e.getMessage());
			} catch (RestClientException e) {
				// 클라이언트 오류 처리
				model.addAttribute("error", "요청 중 오류가 발생했습니다: " + e.getMessage());
			} catch (NumberFormatException e) {
				// 숫자 형식 오류 처리
				model.addAttribute("error", "잘못된 응답 형식입니다: " + e.getMessage());
			} catch (Exception e) {
				// 일반적인 예외 처리
				model.addAttribute("error", "예기치 않은 오류가 발생했습니다: " + e.getMessage());
			}

			return "playlistDetail";
		} else {
			return "redirect:/"; // responses가 null인 경우 리디렉션
		}
	}

	// 플레이리스트 저장
	@GetMapping("/savePlaylist")
	public String savePlaylist(HttpSession session) {
		MemberVO member = (MemberVO) session.getAttribute("member");

		if (member == null) {
			return "redirect:/";
		}

		String memId = member.getMemId();
		MyPlaylistVO myplvo = new MyPlaylistVO();

		// memId로 contextIdx 리스트를 가져옴
		List<ContextVO> contextList = contextMapper.getContext(memId);
		List<MusicVO> musicList = (List<MusicVO>) session.getAttribute("musicList");
		myplvo.setMemId(memId);

		// 나중에 플리명 입력하는 로직 구현해야함!!!!!!!!!!!!!!!!!!!!!!!!!!
		myplvo.setPlName("-");
		myplaylistMapper.insertMypl(myplvo);

		// 공통 contextIdx 설정
		AiPlaylistVO playlistvo = new AiPlaylistVO();
		playlistvo.setContextIdx(contextList.get(0).getContextIdx());
		playlistvo.setContextIdx2(contextList.get(1).getContextIdx());
		playlistvo.setContextIdx3(contextList.get(2).getContextIdx());
		playlistvo.setContextIdx4(contextList.get(3).getContextIdx());
		playlistvo.setContextIdx5(contextList.get(4).getContextIdx());
		playlistvo.setMyplIdx(myplaylistMapper.getMyplIdx(memId).getMyplIdx());

		for (MusicVO music : musicList) {
			// musicIdx 설정
			playlistvo.setMusicIdx(music.getMusicIdx());

			// mapper를 통해 playlistvo를 저장
			aiplaylistMapper.savePlaylist(playlistvo);
		}
		return "redirect:/mainPage";
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
