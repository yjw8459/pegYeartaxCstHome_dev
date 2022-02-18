package kr.co.pegsystem.qna.mapper;


import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.co.pegsystem.admin.vo.StsVO;
import kr.co.pegsystem.common.vo.SearchConditionVO;
import kr.co.pegsystem.qna.vo.QnAVO;

@Mapper("qnaMapper")
public interface QnAMapper {
	public int countQnA();
	public List<QnAVO> findByQnAList(SearchConditionVO conditionVO);
	public QnAVO findQnAByBrdIdx(int brd_idx);
	public QnAVO findQnAByQnAIdx(int brd_idx);
	public int insertQnA(QnAVO qnaVO);
	public int updateQnA(QnAVO qnaVO);
	public int updateQnAHitCount(QnAVO qnaVO);
	public int deleteQnAData(QnAVO qnaVO);
	public List<StsVO> findStsByBrdIdx(Map<String, Object> param);
}

