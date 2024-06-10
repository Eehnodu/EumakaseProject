package com.smhrd.db;

import java.util.List;

import org.apache.ibatis.annotations.Param;

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
	
	// season 추천곡에 쓰일 장르 정보 가져오기
	public List<SurveyVO> getSeasonGenre();
}
