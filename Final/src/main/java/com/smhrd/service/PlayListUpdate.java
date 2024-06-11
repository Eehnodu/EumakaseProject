package com.smhrd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smhrd.db.MemberMapper;
import com.smhrd.db.MyPlaylistMapper;
import com.smhrd.model.MemberVO;
import com.smhrd.model.MyPlaylistVO;


@Service
public class PlayListUpdate {
	@Autowired
	MyPlaylistMapper myplaylistMapper;
	
	@Autowired
	MemberMapper memberMapper;

    public PlayListUpdate(MyPlaylistMapper myplaylistMapper, MemberMapper memberMapper) {
        this.myplaylistMapper = myplaylistMapper;
        this.memberMapper = memberMapper;
    }

    public MyPlaylistVO getUserPlaylist(int myplIdx) {
        return myplaylistMapper.getUserPlaylist(myplIdx);
    }

    public MemberVO getUserInfo(String memId) {
        return memberMapper.getUserInfo(memId);
    }

    public void updateMyPlayList(MyPlaylistVO mvo) {
        myplaylistMapper.updateMyPlayList(mvo);
    }
}
