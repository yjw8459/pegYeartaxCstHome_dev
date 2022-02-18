package kr.co.pegsystem.common.vo;

import java.util.List;

import org.apache.ibatis.type.Alias;

import kr.co.pegsystem.board.vo.BoardMstVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@Alias("userDataVO")
public class UserDataVO {
	private String cst_id;
	private String cst_name;
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
	private String use_yn;
	private String off_tel;
	private String etc_03;
	private String etc_04;
	private String etc_05;
	private String comp_role;
	private List<BoardMstVO> menu;
}
