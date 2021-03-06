package kr.co.pegsystem.common.mapper;

import java.util.List;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.pegsystem.admin.vo.MemberMngVO;
import kr.co.pegsystem.board.vo.AttachFileVO;
import kr.co.pegsystem.board.vo.BoardMstVO;
import kr.co.pegsystem.common.vo.Board;
import kr.co.pegsystem.common.vo.CommonVO;
import kr.co.pegsystem.common.vo.UserDataVO;
import kr.co.pegsystem.qna.vo.QnAVO;

@Mapper
public interface CommonMapper {
	public String findeByBrdCodeWithUrl(String url);
	public UserDataVO findByUserIdAndUserPwd(Map<String, Object> param);
	public List<BoardMstVO> findByCstBrdMst();
	public List<CommonVO> findByCdId(String cd_id);
	public List<CommonVO> findAllByCdId();
	public int countByUsrEmail(String mail);
	public BoardMstVO findeByBrdCode(String brd_code);
	public List<AttachFileVO> findAttachFilesByBrdCodeAndBrdIdx(Board board);
	
	//파일관련
	public AttachFileVO findAttachFilesByBrdCodeAndBrdIdxAndFileIdx(Map<String, Object> param);
	public int insertAttachFileData(AttachFileVO attachFileVO);
	public int deleteFileByBrdCodeAndBrdIdxAndFileIdx(AttachFileVO attachFileVO);
	
	public int findStsIdxBrdCodeAndBrdIdx(Board board);
	public int insertSts(QnAVO qnaVO);
	
	public int findUserCountByUsrIdAndUsrName(MemberMngVO memberMngVO);
	public int updateUsrPwassword(MemberMngVO memberMngVO);
}
