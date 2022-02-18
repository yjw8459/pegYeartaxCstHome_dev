package kr.co.pegsystem.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.pegsystem.admin.vo.BoardMngVO;

@Mapper
public interface AdminBoardMapper {
	public List<BoardMngVO> findBoardMngList(Map<String, Object> param);
	public int updateBoardUseYn(Map<String, Object> param);
	public BoardMngVO findBoardMngDataByBrdCode(String brd_code);
	public int findBrdCodeCountByBrdCode(String brd_code);
	public int findMaxBrdCode();
	public void insertP2yCstBrdMst(BoardMngVO boardMngVO);
	public int updateP2yCstBrdMst(BoardMngVO boardMngVO);
}
