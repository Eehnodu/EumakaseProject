package com.smhrd.db;

import java.util.List;

import com.smhrd.model.SurveyVO;

public interface SurveyMapper {
	
	public String getAnswer(SurveyVO vo);
	
	public String getQuestion(SurveyVO vo);
	
	public List<SurveyVO> joiningSurvey();
	
	}
