package kr.co.pegsystem.board.service;

import javax.servlet.http.HttpServletRequest;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.board.vo.BoardMstVO;
import kr.co.pegsystem.board.vo.BoardVO;

public interface BoardService {
	public EgovMap boardMain(String url);
	public EgovMap boardList(String brd_code, String sac_yy, String wrk_cat, String qst_cat, String keyword, int page_num);
	public EgovMap boardFormDefaultData(String brd_code, int brd_idx);
	public EgovMap saveBoardData(BoardVO boardVO);
	public EgovMap deleteBoardData(String brd_code, int brd_idx, String usr_id);
	public EgovMap boardDetail(String brd_code, int brd_idx);
	public EgovMap getPagingObject(String brd_code, int page_num);
}
