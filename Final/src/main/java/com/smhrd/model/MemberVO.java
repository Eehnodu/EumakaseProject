package com.smhrd.model;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {

	private String memId;
	private String memPw;
	private String name;
	private String gender;
	private String birth;
	private Date createdAt;
	
}
