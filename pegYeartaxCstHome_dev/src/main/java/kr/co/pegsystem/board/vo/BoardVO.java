package kr.co.pegsystem.board.vo;

import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import kr.co.pegsystem.common.vo.Board;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@Alias("boardVO")
public class BoardVO extends Board{
	private String wrk_cat;
	private String wrk_cat_name;
	private String qst_cat;
	private String qst_cat_name;
	private String sac_yy;
	private int brd_group;
	private int brd_step;
	private int brd_level;
	private String subject;
	private String brd_pwd;
	private int brd_hit;
	private String ntc_yn;
	private String del_yn;
	private String client_ip;
	private String etc_01;
	private String etc_02;
	private String etc_03;
	private String etc_04;
	private String etc_05;
	private String ent_uno;
	private String ent_dtm;
	private String upd_uno;
	private String upd_dtm;
	private String content;
	
	private String brd_cat;
	private String save_cat;
	private List<MultipartFile> attachFiles;
	private int total_count;
	private int attach_count;
}
