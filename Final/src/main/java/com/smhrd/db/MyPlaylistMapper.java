package com.smhrd.db;

import java.util.List;

import com.smhrd.model.MyPlaylistVO;

public interface MyPlaylistMapper {
	
	public void insertMypl(MyPlaylistVO vo);
	
	public MyPlaylistVO getMyplIdx(String memId);
	
	public List<MyPlaylistVO> getOtherPl(String memId);
	
	public MyPlaylistVO getUserPlaylist(int myplidx);
	
	public List<MyPlaylistVO> getMyplayList(String memId);

	public void updateMyPlayList(MyPlaylistVO mvo);
}
