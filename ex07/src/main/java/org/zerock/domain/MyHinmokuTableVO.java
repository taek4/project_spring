package org.zerock.domain;

import lombok.Data;

@Data
public class MyHinmokuTableVO {
	private Integer MyHinmokuID;
	private String HinmokuCode;
	private String ShouhinMei;
	private Integer Tanka;
	private Integer GaikaKingaku;
	private Integer GenkaKingaku;
}
