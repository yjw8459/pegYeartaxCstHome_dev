package kr.co.pegsystem.admin.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("stsVO")
public class StsVO {
	private String brd_code;
	private int brd_idx;
	private int sts_idx;
	private String brd_sts;
	private String brd_sts_name;
	private String ent_uno;
	private String ent_dtm;
}
