package kr.co.pegsystem.admin.service;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.admin.vo.BoardMngVO;

public interface AdminBoardService {
	public EgovMap boardMngList(int page_num);
	public EgovMap updateUseYn(String brd_code, String use_yn, String usr_id);
	public EgovMap modalBoardForm(String brd_code);
	public EgovMap brdCodeDupCheck(String brd_url);
	public EgovMap save(BoardMngVO boardMngVO);
}
