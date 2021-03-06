package kr.co.pegsystem.qna.vo;

import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import kr.co.pegsystem.admin.vo.QnAMngVO;
import kr.co.pegsystem.common.vo.Board;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Alias("QnAVO")
public class QnAVO extends Board{
	private String brd_cat;
	private String wrk_cat;
	private String wrk_cat_name;
	private String qst_cat;
	private String qst_cat_name;
	private String req_cat;
	private String req_cat_name;
	private String sac_yy;
	private String shr_yn;
	private String shr_yn_name;
	private String subject;
	private String question;	//질문 contents
	private String answer;		//답변 contents
	private String answer_id;
	private String answer_name;
	private String answer_dtm;
	private String remark;
	private int qna_hit;
	private String client_ip;
	private String cst_id;
	private String comp_code;
	private String cust_id;
	private int qna_idx;
	private String qna_dtm;
	private String lst_sts;
	private String lst_sts_name;
	private String lst_uno;
	private String del_yn;
	private String ent_uno;		//사용자 아이디
	private String ent_dtm;
	private String upd_dtm;
	private String upd_uno;
	private String usr_name; //사용자 이름
	private int total_count;
	private int file_cnt;
	private String cst_name;	// 고객사 이름
	private String comp_name;	// 사업장 이름
	private String cust_name;	// 질문한 고객 이름
	private int sts_idx;
	
	private List<MultipartFile> attachFiles;
	
	private String state;
}
