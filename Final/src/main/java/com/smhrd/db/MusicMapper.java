package com.smhrd.db;

import com.smhrd.model.MusicVO;

public interface MusicMapper {
	
	public MusicVO getMusic(MusicVO vo);
	
	public MusicVO getOtherAlbumCov(int i);
	
}
