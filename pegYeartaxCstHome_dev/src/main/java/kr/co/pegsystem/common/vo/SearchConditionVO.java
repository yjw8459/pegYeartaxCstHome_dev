package kr.co.pegsystem.common.vo;

import lombok.Data;

//검색조건 VO
@Data
public class SearchConditionVO {
	private String brd_code;
	private int brd_idx;
	private String sac_yy;
	private String wrk_cat;
	private String qst_cat;
	private String req_cat;
	private String keyword;
	private String shr_yn;
	private String lst_sts;
	private String usr_id;
	private String cst_id;
	private String comp_name;
	private String comp_code;
	private int page_num;
	private int str_num;
	private int end_num;
	private String from;
	private String to;
	private String usr_cat;
	private String del_yn;
}
