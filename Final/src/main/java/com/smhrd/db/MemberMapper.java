package com.smhrd.db;

import com.smhrd.model.MemberVO;

public interface MemberMapper {

	// 회원가입
	public int join(MemberVO vo);

	// 아이디 중복체크
	public int checkId(String memId);

	// 로그인
	public MemberVO login(MemberVO vo);

	// 회원정보수정
	public int update(MemberVO vo);

	// 회원탈퇴
	public int delete(String memId);

}
