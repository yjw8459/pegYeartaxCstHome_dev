package kr.co.pegsystem.common.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@Alias("commonVO")
public class CommonVO {
	private String cd_id;
	private String cd;
	private String cd_nm;
	private String lang_seq;
	private String dsc;
	private String mgt_item;
	private String rmk;
	private String use_yn;
	private String inq_ord;
	private String ent_uno;
	private String ent_dtm;
	private String upd_uno;
	private String upd_dtm;
}
