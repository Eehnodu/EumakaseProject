package com.smhrd.db;


import java.util.List;

import com.smhrd.model.AiPlaylistVO;
import com.smhrd.model.ContextVO;

public interface AiPlaylistMapper {
    public List<AiPlaylistVO> getMusicIdx(ContextVO context);
}
