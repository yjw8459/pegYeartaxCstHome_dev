package kr.co.pegsystem.admin.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("memberMngVO")
public class MemberMngVO {
	private String cst_id;
	private String str_dt;
	private String end_dt;
	private String comp_code;
	private String comp_name;
	private String usr_id;
	private String usr_pwd;
	private String usr_cat;
	private String usr_name;
	private String usr_email;
	private String usr_tel;
	private String usr_dept;
	private String usr_dept_name;
	private String use_yn;
	private String off_tel;
	private String etc_03;
	private String etc_04;
	private String etc_05;
	private String ent_uno;
	private String ent_dtm;
	private String upd_uno;
	private String upd_dtm;
	private String comp_role;
	private String cst_nm;
	private int total_count;
	private String save_cat;
}
