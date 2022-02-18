package kr.co.pegsystem.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.pegsystem.board.vo.AttachFileVO;
import kr.co.pegsystem.board.vo.BoardMstVO;
import kr.co.pegsystem.board.vo.BoardVO;
import kr.co.pegsystem.common.vo.Board;

@Mapper
public interface BoardMapper {
	public List<BoardVO> findByBrdList(Map<String, Object> param);
	public BoardVO findByBrdCodeAndBrdIdx(Board board);
	public void insertBoardData(BoardVO boardVO);
	public int updateBoardData(BoardVO boardVO);
	public int deleteBoardData(Map<String, Object> param);
	public int updateHitCount(Board board);
	public BoardVO findeByBrdCodeAndBrdIdx(Board board);
	public BoardVO findByBrdCodeAndParentIdx(Board board);
	public int findByMaxBrdIdxWithBrdCodeAndBrdIdx(String brd_code);
	public void insertAttachFileData(AttachFileVO attachFileVO);
}
