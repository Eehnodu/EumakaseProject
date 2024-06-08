package com.smhrd.model;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MyPlaylistVO {
	
	private int myplIdx;
	private String memId;
	private String plName;
	private Date createdAt;
	
}
