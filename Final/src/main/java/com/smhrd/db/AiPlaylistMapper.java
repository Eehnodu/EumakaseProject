package com.smhrd.db;

import java.util.List;

import com.smhrd.model.AiPlaylistVO;
import com.smhrd.model.MyPlaylistVO;

public interface AiPlaylistMapper {
	
	public void savePlaylist(AiPlaylistVO playlistvo);
	
	public List<AiPlaylistVO> getOtherPl(MyPlaylistVO vo);
}
