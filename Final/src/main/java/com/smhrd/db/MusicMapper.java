package com.smhrd.db;

import java.util.List;

import com.smhrd.model.AiPlaylistVO;
import com.smhrd.model.MusicVO;

public interface MusicMapper {
	public List<MusicVO> getMusic(AiPlaylistVO playlist);
}
