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
	public void update(MemberVO vo);

	// 회원탈퇴
	public void delete(MemberVO vo);
	
	// 회원탈퇴 비밀번호확인
	public int checkDelete(MemberVO vo);

	// 수정시 비밀번호 확인
	public int checkPw(MemberVO vo);

}
