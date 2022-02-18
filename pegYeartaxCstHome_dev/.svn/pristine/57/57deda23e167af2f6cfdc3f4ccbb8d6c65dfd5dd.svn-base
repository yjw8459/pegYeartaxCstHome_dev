package kr.co.pegsystem.admin.service;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.admin.vo.MemberMngVO;

public interface AdminMemberService {
	public EgovMap memberMngList(String keyword, int page_num);
	public EgovMap updateUseYn(String cst_id, String comp_code, String usr_id, String use_yn);
	public EgovMap modalMemberForm(MemberMngVO memberMngVO);
	public EgovMap getCompCode(String cst_id);
	public EgovMap usrIdDupCheck(String usr_id);
	public EgovMap save(MemberMngVO memberMngVO);
}
