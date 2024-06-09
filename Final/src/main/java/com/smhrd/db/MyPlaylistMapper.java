package com.smhrd.db;

import java.util.List;

import com.smhrd.model.MyPlaylistVO;

public interface MyPlaylistMapper {
	
	public void insertMypl(MyPlaylistVO vo);
	
	public MyPlaylistVO getMyplIdx(String memId);
	
	public List<MyPlaylistVO> getOtherPl(String memId);
	
}
