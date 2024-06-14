package com.smhrd.db;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smhrd.model.ContextVO;
import com.smhrd.model.PreferenceVO;
import com.smhrd.model.SurveyVO;

public interface PreferenceMapper {
	
	public void insertPref(@Param("memId") String memId ,@Param("surIdxList") List<Integer> surIdx);

    public List<PreferenceVO> getMemPreCon(String memId);
	
	}
