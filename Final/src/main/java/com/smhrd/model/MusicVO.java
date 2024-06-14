package com.smhrd.model;

import java.sql.Date;
import java.time.Year;

import org.w3c.dom.Text;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MusicVO {
	
	private int musicIdx;
	private String albumCov;
	private String title;
	private String artist;
	private String album;
	private String genre;
	private Date releasedAt;
	private String lyrics;
	private String TEXT;
	private Year year;
	private String iframe;
}
