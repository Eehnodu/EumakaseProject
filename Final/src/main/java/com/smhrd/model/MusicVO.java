package com.smhrd.model;

import java.sql.Date;
import java.time.Year;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class MusicVO {
	private int musicIdx;
	private String albumCov;
	private String title;
	private String artist;
	private String album;
	private String genre;
	private Date releasedAt;
	private String lyrics;
	private Year year;
}
