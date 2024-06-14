package com.smhrd.db;

import java.util.List;

import com.smhrd.model.MusicVO;
import com.smhrd.model.AiPlaylistVO;

public interface MusicMapper {
	
	public MusicVO getMusic(MusicVO vo);
	
	public MusicVO getOtherAlbumCov(int i);
	
	public MusicVO getUserPlaylist(int i);
	
	public List<MusicVO> getMyMusic(String memId);
	
	public List<MusicVO> getChartMusic(AiPlaylistVO playlist);

	public List<MusicVO> getSongsByGenre(String genre);
	
	public List<MusicVO> getSongsByEmotion(String emotion);
	
	public List<Integer> getMusicIdxByContextId(Integer contextId);
	
    public MusicVO getMusicById(Integer musicIdx);

	public List<Integer> getMusicIdxByContextId5(Integer contextId);

	public MusicVO getRecMusic(MusicVO vo);
	
}
