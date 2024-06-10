package com.smhrd.db;

import java.util.List;

import com.smhrd.model.MusicVO;

public interface MusicMapper {
	
	public MusicVO getMusic(MusicVO vo);
	
	public MusicVO getOtherAlbumCov(int i);
	
	public MusicVO getUserPlaylist(int i);
	
	public List<MusicVO> getMyMusic(String memId);
	
	
}
