package com.smhrd.db;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smhrd.model.ContextVO;
import com.smhrd.model.SurveyVO;

public interface SurveyMapper {

	public String getAnswer(SurveyVO vo);

	public String getQuestion(SurveyVO vo);

	public List<SurveyVO> joiningSurvey();

	public List<SurveyVO> aiQuestion();

	public List<SurveyVO> aiAnswer();

	public SurveyVO aiSurveyAnser(SurveyVO vo);

	public List<SurveyVO> selectSurvey(@Param("surDescList") List<String> surDescList);
	
	public SurveyVO getOtherSurDesc(int i);
	
	public List<SurveyVO> getSeasonGenre();
	
	public SurveyVO surbayIdx(ContextVO context);

	public List<SurveyVO> getTopSurveysByGenres(List<String> genres);
    
	public List<SurveyVO> getGenreBySurIdx(String surIdx);
	
	public SurveyVO getEmotion(ContextVO context);
	
	public List<Integer> getSurveyIdsByDesc(String desc);
    public SurveyVO getIntro(ContextVO context);
}
