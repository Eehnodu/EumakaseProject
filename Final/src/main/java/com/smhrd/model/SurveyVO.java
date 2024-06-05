package com.smhrd.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SurveyVO {
	private int surIdx;
	private String surType;
	private String surItem;
	private String surDesc;
	
}
