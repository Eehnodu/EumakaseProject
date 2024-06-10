package com.smhrd.model;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ContextVO {

	private int contextIdx;
	private String memId;
	private int surIdx;
	private Date createdAt;
}
