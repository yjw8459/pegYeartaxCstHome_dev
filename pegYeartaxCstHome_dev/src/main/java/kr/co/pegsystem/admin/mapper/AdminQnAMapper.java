package kr.co.pegsystem.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.co.pegsystem.common.vo.SearchConditionVO;
import kr.co.pegsystem.qna.vo.QnAVO;
import kr.co.pegsystem.admin.vo.MemberMngVO;
import kr.co.pegsystem.admin.vo.StsVO;
@Mapper
public interface AdminQnAMapper {
	
	//QnA관리
	public int findQnAIdx();
	public List<QnAVO> findByAdmQnAList(SearchConditionVO conditionVO);
	public int saveAnswer(QnAVO qnaVO);
	public int updateDirectQnA(QnAVO qnAVO);
	public int updateSts(QnAVO qnaVO);
	public QnAVO findQnAByBrdIdx(int brd_idx);
	public List<StsVO> findStsByBrdIdx(Map<String, Object> param);
	public int deleteQnA(QnAVO qnaVO);
	
	//회원 찾기 
	public List<MemberMngVO> findUsersByKeyword(String keyword);
}
