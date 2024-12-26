package org.zerock.domain;

import java.util.List;

import lombok.Data;

@Data
public class DeliveryVO {
	
	private String shukkaID;
	private String hitsuke;
	private String no;
	private String hitsuke_No;
	private String shukkaShiziShoukaiID;
	private String torihikisakiID;
	private String tantoushaID;
	private String soukoID;
	private String projectID;
	private String shinKoumokuTsuika;
    private String hinmokuCode;
	private String hinmokuMei;
	private String zyuusho;
	private String referenceType;
	private String hitsuke_No_referType;
	private String latestSuuryou;
	
	private String itemName;
	private String itemCode;
	private String kikaku;
	private String tekiyo;
	private String suuryouGoukei;
	
	private String suuryou;
    private String firstItemName; // MIN(ch.ItemName)の結果
    private int otherHinmokuCount;   // COUNT(ch.ItemName) - 1の結果
	private String hinmokuZaiko;
	
    
    // TorihikisakiVO 객체 추가 /オブジェクト追加
	/* private TorihikisakiVO torihikisaki; */ 
    private String torihikisakiMei;		
    private String torihikisakiCode;	
    private String yuubinBangou;
    private String renrakusaki;
    // TantoushaVO 객체 추가 / オブジェクト追加
	/* private TantoushaVO tantousha; */
    private String tantoushaMei;
    private String tantoushaCode;
    // SoukoVO 객체 추가 / オブジェクト追加
	/* private SoukoVO souko; */
    private String soukoMei;
    private String soukoCode;
    
    // ProjectVO 객체 추가　/ オブジェクト追加
	/* private ProjectVO project; */
    private String projectCode;
    private String projectMeimei;
    
	/* private HinmokuVO hinmoku; */
	/* private String hinmokuID; */
    private String zaikoKoodo;
    
	/* private CommonHinmokuVO commonHinmoku; */
    
	/* private ShukkaShiziShoukaiVO shukkaShiziShoukai; */
    
    private List<CommonHinmokuVO> commonHinmokuList;
    
}
