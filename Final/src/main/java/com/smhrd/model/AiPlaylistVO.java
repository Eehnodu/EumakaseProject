package com.smhrd.model;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AiPlaylistVO {
	private int plIdx;
	private int musicIdx;
	private int contextIdx;
	private int contextIdx2;
	private int contextIdx3;
	private int contextIdx4;
	private int contextIdx5;
	private String plName;
	private Date createdAt;
}
