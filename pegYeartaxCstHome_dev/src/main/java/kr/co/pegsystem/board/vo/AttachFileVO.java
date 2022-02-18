package kr.co.pegsystem.board.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@Alias("attachFileVO")
public class AttachFileVO {
	private String brd_code;
	private int brd_idx;
	private int file_idx;
	private String org_name;
	private String atc_name;
	private String atc_path;
	private long atc_size;
	private String ent_uno;
	private String ent_dtm;
	private String upd_uno;
	private String upd_dtm;
}
