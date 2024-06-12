package com.smhrd.db;

import java.util.List;
import java.util.Map;
import com.smhrd.model.MemberVO;
import com.smhrd.model.AiPlaylistVO;
import com.smhrd.model.ContextVO;

public interface ContextMapper {
    public int insertContext(Map<String, Object> params);
    
    public List<ContextVO> getContext(String memId);
    
    public ContextVO getOtherSurIdx(int i);
    
    public List<ContextVO> chartjs(MemberVO member);
    
    public List<ContextVO> getContextIdx(MemberVO member);
    
    public void changeSurIdx(int i);

}
