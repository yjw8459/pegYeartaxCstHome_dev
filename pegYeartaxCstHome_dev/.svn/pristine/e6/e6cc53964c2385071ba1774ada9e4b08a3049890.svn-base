package kr.co.pegsystem.qna.service;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.admin.vo.QnAMngVO;
import kr.co.pegsystem.common.vo.SearchConditionVO;
import kr.co.pegsystem.qna.vo.QnAVO;

public interface QnAService {
	public EgovMap main(String url);
	public EgovMap qnaList(SearchConditionVO conditionVO, String usr_cat);
	public EgovMap qnaDetail(SearchConditionVO conditionVO);
	public EgovMap save(QnAVO qnaVO);
	public EgovMap qnaForm(String brd_code, int brd_idx);
	public EgovMap delete(QnAVO qnaVO);
	public EgovMap stsList(String brd_code, int brd_idx);
}
