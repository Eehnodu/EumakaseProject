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
	private String plName;
	private Date createdAt;
}
