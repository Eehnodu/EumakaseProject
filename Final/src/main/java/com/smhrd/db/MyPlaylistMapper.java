package com.smhrd.db;

import com.smhrd.model.MyPlaylistVO;

public interface MyPlaylistMapper {
	public void insertMypl(MyPlaylistVO vo);
	
	public MyPlaylistVO getMyplIdx(String memId);
}
