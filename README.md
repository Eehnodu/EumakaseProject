# 🎧 음악하세(팀명: 도개발윷모)
![logo](https://github.com/Eehnodu/FinalProject/assets/155136516/07cf47d0-5747-48c2-aeda-164d28d4f8be)


## 👀 서비스 소개
* 서비스명: AI를 활용한 음악 추천 서비스 반응형 웹
* 서비스설명: 사용자가 입력한 현재 상태 정보를 기반으로 AI를 이용하여 플레이리스트를 추천 및 다양한 플레이리스트 제공, 차트를 활용한 사용자 개인 데이터 시각화
<br>


## 📅 프로젝트 기간
2024.05.01 ~ 2024.06.20 (6주)
<br>

## ⭐ 주요 기능
* 기능1 : 선호도 및 사용자 상태 파악 질문
* 기능2 : 선호도 평가 질문 제시(회원가입 시)
* 기능3 : 질문을 통한 사용자 분석 및 AI를 활용한 플레이리스트 추천
* 기능4 : 계절 및 장르별 자동 추천
* 기능5 : Chart.js를 활용한 개인 및 사용자 데이터 시각화
* 기능6 : 음원 및 큐레이션 데이터 크롤링
* 기능7 : 검색 기능
* 기능8 : 머신러닝(XgBoost)를 활용한 AI 개발
<br>

<details>
<summary><b>주요 기능 설명 펼치기</b></summary>
<div markdown="1">

* 기능1,2 : 선호도 및 사용자 상태 파악 질문 및 제시시<br>
  <br>선호도 질문
  ```
  # DB에 저장된 정보 가져오기
  @RequestMapping("/joiningSurvey")
	public List<SurveyVO> joiningSurvey(HttpSession session) {
		if (session != null) {
			session.invalidate();
		}

		List<SurveyVO> SurveyList = surveyMapper.joiningSurvey();

		return SurveyList;
	}
  
  # ajax를 통해 반환
  $.ajax({
            url: `${cpath}/joiningProcess`,
            type: "post",
            data: $("form").serialize(),
            success: function(response) {
               // console.log(response);
               $.ajax({
                  url: `${cpath}/joiningSurvey`,
                  type: "post",
                  success: function(result) { // 결과 성공 콜백함수
                     window.history.pushState({}, '', `${cpath}/`);
                     console.log(response);
                     console.log(result);
                     
                     // console.log(response); response 가져
                     // 선언된 변수에 초기 HTML 구조를 설정합니다.
                     
                     // 선호도 조사 꾸미기
                     let htmlContent = `
  
    <form id="toggleForm" onsubmit="handleSubmit(event)">
      <fieldset class="checkbox-group">
      <h4 class="h4survey">선호도 조사</h4>
        <legend class="checkbox-group-legend">Choose your favorites</legend>
        <legend class="three">최대 3개까지 선택해주세요</legend>`;
  ```
  <br>상태파악 질문
  ```
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

  ```
* 기능3 : 질문을 통한 사용자 분석 및 AI를 활용한 플레이리스트 추천
```
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

				// 회원의 선호도 장르를 담을 리스트 생성
				List<SurveyVO> preGenre = new ArrayList<>();
				if (member != null) {
					for (PreferenceVO preCon : preferenceMapper.getMemPreCon(memId)) {
						preGenre.add(surveyMapper.getMemPreGenre(preCon));
					}
				}
				// 개인 선호도 장르를 모델에 담기
				model.addAttribute("preGenre", preGenre);

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
					if (musicMapper.getMusic(musicvo) != null) {
						musicList.add(musicMapper.getMusic(musicvo));
					}
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
```
* 기능4 : 계절 및 장르별 자동 추천<br>
  <br>계절별 추천
  ```
  @GetMapping("/")
	public String intro(Model model, HttpSession session) {

		MemberVO memvo = (MemberVO) session.getAttribute("member");
		if (memvo != null) {
			return "redirect:/mainPage";
		}

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
  ```
  <br>장르별 추천
  ```
  @GetMapping("/mainPage")
	public String mainPage(HttpSession session, HttpServletRequest request, HttpServletResponse response) {

		// 사랑받는 노래 가져오기
		List<AiPlaylistVO> popularMusicList = aiplaylistMapper.getPopularMusic();
		List<MusicVO> popularMusic = new ArrayList<>();
		for (AiPlaylistVO music : popularMusicList) {
			popularMusic.add(musicMapper.getUserPlaylist(music.getMusicIdx()));
		}
		session.setAttribute("popularMusic", popularMusic);

		// 중간에 장르 자동 추천
		// 쿠키가 이미 있는지 확인
		Cookie recCookie = WebUtils.getCookie(request, "recCookie");

		// 세션에서 값을 읽음
		List<List<String>> allRecList = (List<List<String>>) session.getAttribute("recomendMusic");
		List<String> allSurveyList = (List<String>) session.getAttribute("recSurvey");
		List<Map.Entry<Integer, SurveyVO>> indexList = (List<Map.Entry<Integer, SurveyVO>>) session
				.getAttribute("indexList");
		List<List<MusicVO>> allRecMusicList = (List<List<MusicVO>>) session.getAttribute("recMusic");

		// null 초기화 방지
		boolean needNewData = recCookie == null || allRecList == null || allSurveyList == null || indexList == null
				|| allRecList.isEmpty() || allSurveyList.isEmpty() || indexList.isEmpty();

		if (needNewData) {
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

			// 각 장르에 대한 추천 리스트를 담을 리스트 초기화
			allRecList = new ArrayList<>();
			allSurveyList = new ArrayList<>();
			indexList = new ArrayList<>();

			for (int i = 0; i < genreList.size(); i++) {
				indexList.add(new AbstractMap.SimpleEntry<>(i, genreList.get(i)));
			}

			for (Map.Entry<Integer, SurveyVO> entry : indexList) {
				String recGen = entry.getValue().getSurDesc();

				// 각 항목별로 랜덤 선택
				String recEmotion = surveyMap.get("emotion").get(random.nextInt(surveyMap.get("emotion").size()));
				String recSituation = surveyMap.get("situation").get(random.nextInt(surveyMap.get("situation").size()));
				String recPlace = surveyMap.get("place").get(random.nextInt(surveyMap.get("place").size()));
				String recPeople = surveyMap.get("people").get(random.nextInt(surveyMap.get("people").size()));

				String recStr = recEmotion + " " + recSituation + " " + recPlace + " " + recPeople;

				// 각 단어 앞에 '#' 추가
				String recSurvey = ("#" + recGen + " " + "#" + recStr.replaceAll(" ", " #")).trim();

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

				try {
					// 요청 보내기 및 응답 받기
					ResponseEntity<String[]> responseEntity = restTemplate.exchange(url, HttpMethod.POST, requestEntity,
							String[].class);

					// 추천 결과를 모델에 추가
					String[] recommendations = responseEntity.getBody();
					if (recommendations != null) {
						List<String> recList = Arrays.asList(recommendations);
						allRecList.add(recList);
						allSurveyList.add(recSurvey);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			// 세션에 추천 데이터를 저장
			session.setAttribute("recomendMusic", allRecList);
			session.setAttribute("recSurvey", allSurveyList);
			session.setAttribute("indexList", indexList);

			// 세션 식별자를 쿠키에 저장
			Cookie recCookieNew = new Cookie("recCookie", session.getId());
			recCookieNew.setMaxAge(24 * 60 * 60); // 1 day
			recCookieNew.setPath("/");
			response.addCookie(recCookieNew);
		}

		// 추천 받은 노래의 음원 정보 가져오기
		if (allRecMusicList == null || allRecMusicList.isEmpty()) {
			allRecMusicList = new ArrayList<>();
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
		}

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
  ```
* 기능5 : Chart.js를 활용한 개인 및 사용자 데이터 시각화
```
# 차트에 필요한 값 가져오기
@RequestMapping("/getMypage")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getMypage(HttpSession session) {
	    String flaskApiUrl = "http://localhost:5000";
	    RestTemplate restTemplate = new RestTemplate();

	    // Initialize data variables
	    List<Map<String, Object>> genreData = null;
	    List<Map<String, Object>> emotionData = null;
	    List<Map<String, Object>> topSongsData = null;

	    try {
	        // Retrieve memid from session
	        MemberVO mvo = (MemberVO) session.getAttribute("member");
	        if (mvo == null || mvo.getMemId() == null) {
	            System.out.println("Member or MemId is null");
	            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
	        }
	        String input_memid = mvo.getMemId();
	        System.out.println("input_memid mypage : " + input_memid);

	        // Prepare the request body (input_memid)
	        Map<String, String> requestBody = new HashMap<>();
	        requestBody.put("memid", input_memid);

	        HttpHeaders headers = new HttpHeaders();
	        headers.setContentType(MediaType.APPLICATION_JSON);
	        HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(requestBody, headers);

	        // Fetch genre data
	        try {
	            ResponseEntity<List<Map<String, Object>>> genreResponseEntity = restTemplate.exchange(
	                    flaskApiUrl + "/getmygenre", HttpMethod.POST, requestEntity, new ParameterizedTypeReference<List<Map<String, Object>>>() {});
	            genreData = genreResponseEntity.getBody();
	            System.out.println("genre_data : " + genreData);
	        } catch (Exception e) {
	            System.out.println("Error fetching genre data: " + e.getMessage());
	            e.printStackTrace();
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	        }

	        // Fetch emotion data
	        try {
	            ResponseEntity<List<Map<String, Object>>> emotionResponseEntity = restTemplate.exchange(
	                    flaskApiUrl + "/getmyemotion", HttpMethod.POST, requestEntity, new ParameterizedTypeReference<List<Map<String, Object>>>() {});
	            emotionData = emotionResponseEntity.getBody();
	            System.out.println("emotion_data : " + emotionData);
	        } catch (Exception e) {
	            System.out.println("Error fetching emotion data: " + e.getMessage());
	            e.printStackTrace();
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	        }

	        // Fetch top songs by genre
	        try {
	            ResponseEntity<List<Map<String, Object>>> topsongsResponseEntity = restTemplate.exchange(
	                    flaskApiUrl + "/getmytopsongs", HttpMethod.POST, requestEntity, new ParameterizedTypeReference<List<Map<String, Object>>>() {});
	            topSongsData = topsongsResponseEntity.getBody();
	            System.out.println("top_songs_by_genre : " + topSongsData);
	        } catch (Exception e) {
	            System.out.println("Error fetching top songs data: " + e.getMessage());
	            e.printStackTrace();
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	        }

	        // Combine all data into a single map
	        Map<String, Object> responseData = new HashMap<>();
	        responseData.put("genre_data", genreData);
	        responseData.put("emotion_data", emotionData);
	        responseData.put("top_songs_by_genre", topSongsData);

	        return ResponseEntity.ok(responseData);
	    } catch (Exception e) {
	        // Log the exception properly
	        System.out.println("General error: " + e.getMessage());
	        e.printStackTrace();
	        // Return appropriate HTTP status code and message in case of error
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	    }
	}
```
* 기능6 : 음원 및 큐레이션 데이터 크롤링<br>
  <br> 음원 크롤링
  ![image](https://github.com/Eehnodu/Eumakase/assets/155121578/f0123431-28b1-4aa8-a546-5ac811ae8a00)
  <br> 큐레이션 크롤링
  ![image](https://github.com/Eehnodu/Eumakase/assets/155121578/37219bab-352d-4060-b5f4-3438748eff71)
* 기능7 : 검색 기능
  ```
  @GetMapping("/search")
	public String search(@RequestParam("searchKeyword") String searchKeyword ,Model model) {
		System.out.println(searchKeyword);
		List<MusicVO> musiclist = musicMapper.searchMusicByTitle(searchKeyword);
		List<MyPlaylistVO> myplaylist = myplaylistMapper.searchPlaylist(searchKeyword);
		
		List<Map<String, String>> contextList = new ArrayList<>();
		List<String> albumCovList = new ArrayList<>();

		for (MyPlaylistVO mvo : myplaylist) {
		    Map<String, String> context = surveyMapper.context_in_surDesc(mvo.getMyplIdx());
		    contextList.add(context);

		    List<MusicVO> albumcov = musicMapper.myplIdxgetmusic(mvo.getMyplIdx());
		    for (MusicVO i : albumcov) {
		        albumCovList.add(i.getAlbumCov());
		    }
		}
		
		model.addAttribute("contextList",contextList);
		model.addAttribute("albumCovList",albumCovList);
		model.addAttribute("myplaylist", myplaylist);
		model.addAttribute("keyword", searchKeyword);
		model.addAttribute("searching_music", musiclist);
		
		return "search";
	}
  ```
* 기능8 : 머신러닝(XgBoost)를 활용한 AI 개발
```
# 필요한 열 제외
data = data.drop(columns=['curArtist', 'curTitle'])

# curExplain, curHead, curObject를 결합하여 새로운 컬럼 생성
data['combined'] = data['curExplain'].astype(str) + ' ' + data['curHead'].astype(str) + ' ' + data['curObject'].astype(str)

# 범주형 변수를 category 타입으로 변환
categorical_cols = ['curColor', 'curColor2', 'curColor3', 'genre', 'song']
for col in categorical_cols:
    data[col] = data[col].astype('category')

# 'song' 열을 Label Encoding
label_encoder = LabelEncoder()
data['song'] = label_encoder.fit_transform(data['song'])

# LabelEncoder 저장
with open('label_encoder1.pkl', 'wb') as le_file:
    pickle.dump(label_encoder, le_file)

# TF-IDF 벡터화
tfidf_vectorizer = TfidfVectorizer(max_features=5000, ngram_range=(1, 2), min_df=2, max_df=0.8)
tfidf_matrix = tfidf_vectorizer.fit_transform(data['combined'])

# TF-IDF 결과를 데이터프레임으로 변환
tfidf_df = pd.DataFrame(tfidf_matrix.toarray(), columns=tfidf_vectorizer.get_feature_names_out())

# TF-IDF Vectorizer 저장
with open('tfidf_vectorizer1.pkl', 'wb') as tv_file:
    pickle.dump(tfidf_vectorizer, tv_file)

# TF-IDF 행렬 저장
with open('tfidf_matrix1.pkl', 'wb') as tm_file:
    pickle.dump(tfidf_matrix, tm_file)

# 모델 학습에 사용할 데이터 준비 (curExplain, curHead, curObject, combined 열 제거)
X = pd.concat([data[['curColor', 'curPer', 'curColor2', 'curPer2', 'curColor3', 'curPer3', 'genre']].reset_index(drop=True), tfidf_df.reset_index(drop=True)], axis=1)
y = data['song']

# DMatrix 생성
dtrain = xgb.DMatrix(X, label=y, enable_categorical=True)

# LabelEncoder 저장
with open('label_encoder1.pkl', 'wb') as le_file:
    pickle.dump(label_encoder, le_file)
    
    # TF-IDF Vectorizer 저장
with open('tfidf_vectorizer1.pkl', 'wb') as tv_file:
    pickle.dump(tfidf_vectorizer, tv_file)

# TF-IDF 행렬 저장
with open('tfidf_matrix1.pkl', 'wb') as tm_file:
    pickle.dump(tfidf_matrix, tm_file)

# 모델 파라미터 설정
params = {
    'objective': 'multi:softmax',
    'learning_rate': 0.05,
    'max_depth': 6,
    'num_class': len(label_encoder.classes_)
}

# 학습 시간 측정
start_time = time.time()
model = xgb.train(params, dtrain, num_boost_round=100)
end_time = time.time()

# 학습 시간
training_time = end_time - start_time
print(f'학습 시간: {training_time} 초')

# 모델 저장
with open('xgboost_model1.pkl', 'wb') as f:
    pickle.dump(model, f)

# 예측 수행 및 랜덤 추천 함수
def recommend_random_songs(model, label_encoder, tfidf_vectorizer, tfidf_matrix, input_keywords, input_genre, n_recommendations=500, n_random=20):
    # 입력 키워드를 TF-IDF 벡터화
    input_vector = tfidf_vectorizer.transform([input_keywords])
    
    # 코사인 유사도 계산
    cosine_sim = cosine_similarity(input_vector, tfidf_matrix)
    
    # 입력한 장르와 일치하는 인덱스 필터링
    genre_indices = data[data['genre'] == input_genre].index
    
    # 유사도가 높은 순서로 정렬된 인덱스
    sorted_indices = genre_indices[np.argsort(-cosine_sim[0][genre_indices])]
    
    # 상위 n개의 유사한 노래 추천
    recommended_song_indices = sorted_indices[:n_recommendations]
    recommended_songs = label_encoder.inverse_transform(data.loc[recommended_song_indices, 'song'])
    
    # n개의 랜덤 추천 노래 선택
    random_recommendations = random.sample(list(recommended_songs), n_random)
    
    return random_recommendations

# 저장된 모델 불러오기
with open('xgboost_model1.pkl', 'rb') as f:
    loaded_model = pickle.load(f)
```
</div>
</details>

## ⛏ 기술스택
<table>
    <tr>
        <th>구분</th>
        <th>내용</th>
    </tr>
    <tr>
        <td>사용언어</td>
        <td>
            <img src="https://img.shields.io/badge/Java-007396?style=flat&logo=OpenJDK&logoColor=white"/>
            <img src="https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=HTML5&logoColor=white"/>
            <img src="https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=CSS3&logoColor=white"/>
            <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=JavaScript&logoColor=white"/>
	    <img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white"/>
        </td>
    </tr>
    <tr>
        <td>라이브러리</td>
        <td>
	<img src="https://img.shields.io/badge/AJAX-FFFFFF?style=for-the-badge"/>
	<img src="https://img.shields.io/badge/BootStrap-7952B3?style=for-the-badge&logo=BootStrap&logoColor=white"/>
          <img src="https://img.shields.io/badge/spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white">
        </td>
    </tr>
    <tr>
        <td>개발도구</td>
        <td>
	    <img src="https://img.shields.io/badge/Eclipse-2C2255?style=for-the-badge&logo=Eclipse&logoColor=white"/>
            <img src="https://img.shields.io/badge/VSCode-007ACC?style=for-the-badge&logo=VisualStudioCode&logoColor=white"/>
	    <img src="https://img.shields.io/badge/Jupyter%20Notebook-F37626.svg?&style=for-the-badge&logo=Jupyter&logoColor=white"/> 
        </td>
    </tr>
    <tr>
        <td>서버환경</td>
        <td>
            <img src="https://img.shields.io/badge/Apache Tomcat-D22128?style=for-the-badge&logo=Apache Tomcat&logoColor=white"/>
            <img src="https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=Flask&logoColor=white"/> 
        </td>
    </tr>
    <tr>
        <td>데이터베이스</td>
        <td>
            <img src="https://img.shields.io/badge/mysql-4479A1?style=for-the-badge&logo=mysql&logoColor=white">
        </td>
    </tr>
    <tr>
        <td>협업도구</td>
        <td>
            <img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=Git&logoColor=white"/>
            <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=GitHub&logoColor=white"/>
        </td>
    </tr>
</table>


<br>

## ⚙ 시스템 아키텍처
![아키텍처](https://github.com/Envoy-VC/awesome-badges/assets/155121578/85619e76-a6f6-4cd8-8680-18dd34177faa)
<br>

## 📌 SW유스케이스
![유스케이스](https://github.com/Eehnodu/Project/assets/155121578/3f63bc55-87c4-45ad-ad3d-eac5cff29e1f)
<br>

## 📌 서비스 흐름도
![서비스흐름도 drawio](https://github.com/Eehnodu/FinalProject/assets/155136516/f075a2c5-248b-4966-a844-db612f811ac3)
<br>

## 📌 ER다이어그램
<img width="741" alt="ERD(ver Aquery)" src="https://github.com/Eehnodu/crawling_test/assets/155121578/a98b1740-c2f2-487b-992e-c85420a637b6">
<br>

## 🖥 화면 구성







|🎞 서비스 소개 페이지 |
|:---:|
| ![image](https://github.com/Eehnodu/Eumakase/assets/155121578/a22a46ae-acdb-4455-84a9-b0f377d9a605)|

|🎞 메인 페이지 |🎞 메인 페이지 |
|:---:|:---:|
|![image](https://github.com/Eehnodu/Eumakase/assets/155121578/9057a45d-6694-455e-a970-f9c8904096ea)|![image](https://github.com/Eehnodu/Eumakase/assets/155121578/f5b4c6e5-13eb-4595-94b2-720216f13287)|

|🎞 AI 추천 페이지 |🎞 AI 추천 결과 페이지 |
|:---:|:---:|
|![image](https://github.com/Eehnodu/Eumakase/assets/155121578/359e8810-c346-4b05-8cdb-68b24220d6cc)|![image](https://github.com/Eehnodu/Eumakase/assets/155121578/dcfd1290-0e16-4909-9f69-ec93ea146815)|

|🎞 마이 페이지 |🎞 마이 페이지 |
|:---:|:---:|
|![image](https://github.com/Eehnodu/Eumakase/assets/155121578/74621c9a-d005-4682-8b9a-0ba228bd5f6a)|![image](https://github.com/Eehnodu/Eumakase/assets/155121578/881db3e7-0880-4fed-a740-02eb900da717)|

|🎞 플레이리스트 상세 페이지 |
|:---:|
|![image](https://github.com/Eehnodu/Eumakase/assets/155121578/d8e56db6-9f4c-4926-be85-9988ae7505f5)|

|🎞 곡 상세 정보 페이지 |
|:---:|
|![image](https://github.com/Eehnodu/Eumakase/assets/155121578/7cbf260f-c910-4d3b-993a-adaa6d7db39d)|

|🎞 검색 페이지 |
|:---:|
|![image](https://github.com/Eehnodu/Eumakase/assets/155121578/697a3821-bc2a-45f7-9bc5-80bfe9651b10)|



## 👨‍👩‍👦‍👦 팀원 역할
<table>
  <tr>
    <td align="center"><img src="https://i.namu.wiki/i/GirsrnQUH-q5qbVv871h4zLg_H1X25k25qY-Vr5DcO6xV8MWdcENwySAA0M62Xyurjt3ezZUbPm7GoVYJRRXWGIAXpWJ0_zsEH0mxNsLH2S_GX54w9exBaOg6io06JjbYZRHQiPSyUwPoLzRFA5aeQ.webp" width="100" height="100"/></td>
    <td align="center"><img src="https://mb.ntdtv.kr/assets/uploads/2019/01/Screen-Shot-2019-01-08-at-4.31.55-PM-e1546932545978.png" width="100" height="100"/></td>
    <td align="center"><img src="https://github.com/2024-SMHRD-KDT-BigData-23/FitNeeds/assets/155136709/60cfda0f-23f4-4e5d-a953-12565033b91b" height="100"/></td>
    <td align="center"><img src="https://i.pinimg.com/236x/ed/bb/53/edbb53d4f6dd710431c1140551404af9.jpg" width="100" height="100"/></td>
    <td align="center"><img src="https://pbs.twimg.com/media/B-n6uPYUUAAZSUx.png" width="100" height="100"/></td>
  </tr>
  <tr>
    <td align="center"><strong>김동현</strong></td>
    <td align="center"><strong>엄희수</strong></td>
    <td align="center"><strong>우동희</strong></td>
    <td align="center"><strong>조범수</strong></td>
    <td align="center"><strong>정규원</strong></td>
  </tr>
  <tr>
    <td align="center"><b>Back-end, DB</b></td>
    <td align="center"><b>Front-end</b></td>
    <td align="center"><b>Back-end, DB, Modeling</b></td>
    <td align="center"><b>Front-end, Back-end</b></td>
    <td align="center"><b>Front-end</b></td>
  </tr>
  <tr>
    <td align="center"><a href="https://github.com/dohdark" target='_blank'>github</a></td>
    <td align="center"><a href="https://github.com/heesooooooo" target='_blank'>github</a></td>
    <td align="center"><a href="https://github.com/Eehnodu" target='_blank'>github</a></td>
    <td align="center"><a href="https://github.com/beomsu-j" target='_blank'>github</a></td>
    <td align="center"><a href="https://github.com/Jungkyuwonnn" target='_blank'>github</a></td>
  </tr>
  <tr>
    <td align="center"><b>Crawling 및 데이터 전처리<br><br>마이페이지 구현<br><br>플레이리스트 상세페이지 DB에서 정보 가져오기 구현<br><br>동기, 비동기 검색 구현<br><br>플레이리스트 CRUD 기능<br></td>
    <td align="center"><b>UI/UX 디자인<br><br>소개 페이지 구현<br><br>AI 음악추천, 곡 정보 페이지 구현<br><br>검색창, 검색 결과 페이지 구현<br><br>회원관리 기능 구현<br></td>
    <td align="center"><b>PM<br><br>DB 설계 및 구축<br><br>XgBoost를 활용한 AI 개발<br><br>Crawling<br><br>Flask를 통한 AI 추천 결과 연동<br><br>다른 사용자 플레이리스트 화면 구현<br><br>곡 정보 페이지 Youtube iframe 구현<br><br>계절 및 장르별 추천 플레이리스트<br></td>
    <td align="center"><b>Crawling<br><br>OpenCV를 통한 색감 정보 추출<br><br>Google Vision, Transtation API를 활용한 이미지 객체 인식 구현<br><br>텍스트마이닝을 통한 큐레이션 데이터 분석<br><br>Chart.js를 통한 개인 및 사용자 데이터 시각화<br></b></td>
    <td align="center"><b>UI/UX 디자인<br><br>메인 페이지, 마이페이지 구현<br><br>AI 음악 추천 및 결과 페이지 구현<br><br>곡 정보, 플레이리스트 페이지 구현<br></b></td>
  </tr>
</table>

## 🤾‍♂️ 트러블슈팅


<details>
<summary>
### 🔨 Chart.js 로딩 속도 문제<br>
</summary>
- 문제<br>
	
  STS와 MySQL 연결 및 시각화의 어려움
  Value Object와 컨트롤러 호출의 빈번함
  Chart를 불러오는 과정에서 화면에 늦게 출력되는 시간이 10초 이상 걸림.

- 원인<br>

  STS에서 Mybatis를 이용하여 데이터를 가져옴
  데이터의 볼륨과 거치는 테이블이 많아서 속도 저하가 된다고 생각함.
 
- 해결방안<br>

  Pymysql에서 SQL쿼리문으로 해결하여 flask를 통해 값을 받아옴.
 
- 코드<br>
```
# pymysql 연결
def get_connection():
    return pymysql.connect(
        host='project-db-cgi.smhrd.com',
        port=3307,
        user='ehroqkfdbcah',
        password='q1w2e3!@#',
        db='ehroqkfdbcah',
        charset='utf8',
        cursorclass=pymysql.cursors.DictCursor
    )

# 값을 불러오는 sql문
def get_my_genre(input_memid):
    conn = get_connection()
    try:
        with conn.cursor() as cursor:
            get_context_sql = """
                SELECT s.surDesc, COUNT(*) as count
                FROM tb_context c
                JOIN tb_survey s ON c.surIdx = s.surIdx
                WHERE c.memId = %s
                  AND s.surType = 'A'
                  AND s.surItem = 'genre'
                GROUP BY s.surDesc
                ORDER BY count DESC
                LIMIT 3;
            """
            cursor.execute(get_context_sql, (input_memid))
            results = cursor.fetchall()
            mygenre_list = [{'surDesc': row['surDesc'], 'count': row['count']} for row in results]
            return mygenre_list
    finally:
        conn.close()

# sts와 flask 연결
@app.route('/getmygenre', methods=['POST'])
def get_my_genre_endpoint():
    content = request.json
    input_memid = content['memid']
    genre_data = get_my_genre(input_memid)
    return jsonify(genre_data).

```

</details>



