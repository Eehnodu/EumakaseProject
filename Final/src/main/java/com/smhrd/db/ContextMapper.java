package com.smhrd.db;

import com.smhrd.model.ContextVO;
import com.smhrd.model.MemberVO;
import java.util.List;

public interface ContextMapper {
    public List<ContextVO> chartjs(MemberVO member);
    public List<ContextVO> getContextIdx(MemberVO member);
}
