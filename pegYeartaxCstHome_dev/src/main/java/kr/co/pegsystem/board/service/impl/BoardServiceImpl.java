package kr.co.pegsystem.board.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.PegWebConfigProperties;
import kr.co.pegsystem.board.mapper.BoardMapper;
import kr.co.pegsystem.board.service.BoardService;
import kr.co.pegsystem.board.vo.AttachFileVO;
import kr.co.pegsystem.board.vo.BoardMstVO;
import kr.co.pegsystem.board.vo.BoardVO;
import kr.co.pegsystem.common.mapper.CommonMapper;
import kr.co.pegsystem.common.service.CommonService;
import kr.co.pegsystem.common.vo.Board;
import kr.co.pegsystem.common.vo.CommonVO;
import pegsystem.util.IntegerUtil;
import pegsystem.util.PagingUtil;
import pegsystem.util.RequestUtil;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
	
	@Resource(name = "commonService") private CommonService commonService;
	@Resource(name="commonMapper") private CommonMapper commonMapper;
	@Resource(name="boardMapper") private BoardMapper mapper;
	@Resource(name="pegWebConfigProperties") private PegWebConfigProperties props;
	
	
	@Override
	public EgovMap boardMain(String url) {
		EgovMap result = new EgovMap();
		List<CommonVO> c001 = commonMapper.findByCdId("C001");	// 업무구분
		List<CommonVO> c002 = commonMapper.findByCdId("C002");	// 질문구분(카테고리)
		List<CommonVO> c003 = commonMapper.findByCdId("C003");	// 질문경로
		List<CommonVO> c004 = commonMapper.findByCdId("C004");	// 진행상태
		List<CommonVO> c005 = commonMapper.findByCdId("C005");	// 부서정보
		List<CommonVO> c006 = commonMapper.findByCdId("C006");	// 사용자구분
		List<CommonVO> c007 = commonMapper.findByCdId("C007");	// 정산년도
		List<CommonVO> c008 = commonMapper.findByCdId("C008");	// 게시판구분
		
		String brdCode = commonMapper.findeByBrdCodeWithUrl(url);
		BoardMstVO brdMst = commonMapper.findeByBrdCode(brdCode);
		
		result.put("brdMst", brdMst);
		result.put("brdType", brdMst == null ? "" : brdMst.getBrd_type());
		result.put("c001", c001);
		result.put("c002", c002);
		result.put("c003", c003);
		result.put("c004", c004);
		result.put("c005", c005);
		result.put("c006", c006);
		result.put("c007", c007);
		result.put("c008", c008);
		return result;
	}
	
	
	@Override
	public EgovMap boardList(String brd_code, String sac_yy, String wrk_cat, String qst_cat, String keyword, int page_num) {
		EgovMap result = new EgovMap();
		EgovMap pagingObject = getPagingObject(brd_code, page_num);
		PagingUtil paging = (PagingUtil) pagingObject.get("paging");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("brd_code", brd_code);
		param.put("sac_yy", sac_yy);
		param.put("wrk_cat", wrk_cat);
		param.put("qst_cat", qst_cat);
		param.put("keyword", keyword);
		param.put("str_num", pagingObject.get("strNum"));
		param.put("end_num", pagingObject.get("endNum"));
		
		List<BoardVO> list = mapper.findByBrdList(param);
		if(list != null && list.size() > 0) {
			BoardVO temp = list.get(0);
			paging.setTotalCount(temp.getTotal_count());
		}
		
		result.put("list", list);
		result.put("paging", paging);
		return result;
	}
	
	
	@Override
	public EgovMap boardFormDefaultData(String brd_code, int brd_idx) {
		EgovMap result = new EgovMap();
		
		Board board = new Board(brd_code, brd_idx);
		
		BoardMstVO brdMst = commonMapper.findeByBrdCode(brd_code);
		List<AttachFileVO> attachFiles = commonMapper.findAttachFilesByBrdCodeAndBrdIdx(board);
		int maxBrdIdx = mapper.findByMaxBrdIdxWithBrdCodeAndBrdIdx(brd_code); 
		BoardVO orderInfo = mapper.findByBrdCodeAndParentIdx(board);
		
		BoardVO data = null;
		if(brd_idx > 0) data = mapper.findByBrdCodeAndBrdIdx(board);
		
		// 신규입력
		if(data == null) {
			data = new BoardVO();
			data.setBrd_idx(maxBrdIdx);
			data.setBrd_group(orderInfo == null ? maxBrdIdx : orderInfo.getBrd_group());
			data.setBrd_step(orderInfo == null ? 1 : (orderInfo.getBrd_step()+1));
			data.setBrd_level(orderInfo == null ? 0 : (orderInfo.getBrd_level()+1));
		}
		
		// 공통코드
		List<CommonVO> c001 = commonMapper.findByCdId("C001");	// 업무구분
		List<CommonVO> c002 = commonMapper.findByCdId("C002");	// 질문구분(카테고리)
		List<CommonVO> c003 = commonMapper.findByCdId("C003");	// 질문경로
		List<CommonVO> c004 = commonMapper.findByCdId("C004");	// 진행상태
		List<CommonVO> c005 = commonMapper.findByCdId("C005");	// 부서정보
		List<CommonVO> c006 = commonMapper.findByCdId("C006");	// 사용자구분
		List<CommonVO> c007 = commonMapper.findByCdId("C007");	// 정산년도
		List<CommonVO> c008 = commonMapper.findByCdId("C008");	// 게시판구분
	
		result.put("maxBrdIdx", maxBrdIdx);
		result.put("brdMst", brdMst);
		result.put("attachFiles", attachFiles);
//		result.put("orderInfo", orderInfo);
		result.put("parent_no", brd_idx);
		result.put("data", data);
		result.put("c001", c001);
		result.put("c002", c002);
		result.put("c003", c003);
		result.put("c004", c004);
		result.put("c005", c005);
		result.put("c006", c006);
		result.put("c007", c007);
		result.put("c008", c008);
		return result;
	}


	@Override
	@Transactional
	public EgovMap saveBoardData(BoardVO boardVO) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		
		try {
			// 게시판 정보 insert / update
			String saveCat = boardVO.getSave_cat();
			if("insert".equals(saveCat)) {
				// insert
				String clientIP = RequestUtil.getClientIpAddress();
				boardVO.setClient_ip(clientIP);
				mapper.insertBoardData(boardVO);
				retCode++;
			} else if("update".equals(saveCat)) {
				// update
				retCode = mapper.updateBoardData(boardVO);
			}
			
			// insert or update가 정상적으로 완료된 후 첨부파일 처리
			if(retCode > 0) {
				// 파일 업로드
				List<MultipartFile> attachFiles = boardVO.getAttachFiles(); 
				String brd_code = boardVO.getBrd_code();
				int brd_idx = boardVO.getBrd_idx();
				String ent_uno = boardVO.getEnt_uno();
				commonService.insertAttachFiles(attachFiles, brd_code, brd_idx, ent_uno);
			}
		} catch(Exception e) {
			e.printStackTrace();
			retCode = -999;
			retMsg = e.getMessage();
		}
		
		result.put("retCode", retCode);
		result.put("retMsg", retMsg);
		return result;
	}

	
	@Override
	@Transactional
	public EgovMap deleteBoardData(String brd_code, int brd_idx, String usr_id) {
		EgovMap result = new EgovMap();
		int retCode = 0; 					//상태코드 
		String retMsg = "";					//상태 메세지 
		
		try {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("brd_code", brd_code);
			param.put("brd_idx", brd_idx);
			param.put("usr_id", usr_id);
			retCode = mapper.deleteBoardData(param);
			
//			if(retCode > 0) {
				// 첨부파일 삭제
//				commonService.deleteFileData(param);	실제 게시물을 삭제하지 않으므로 
//			}
		} catch (Exception e) {
			e.printStackTrace();
			retCode = -999;
			retMsg = e.getMessage();		//오류 메세지 삽입
		}
		
		result.put("retCode", retCode);
		result.put("retMsg", retMsg);
		return result;
	}


	@Override
	public EgovMap boardDetail(String brd_code, int brd_idx) {
		EgovMap result = new EgovMap();
		Board board = new Board(brd_code, brd_idx);
		BoardVO boardVO = mapper.findeByBrdCodeAndBrdIdx(board);
		BoardMstVO brdMst = commonMapper.findeByBrdCode(brd_code);
		List<AttachFileVO> attachFiles = commonMapper.findAttachFilesByBrdCodeAndBrdIdx(board);
		
		// 조회수++
		mapper.updateHitCount(board);
		
		result.put("board", boardVO);
		result.put("brdMst", brdMst);
		result.put("attachFiles", attachFiles);
		return result;
	}
	
	/**
	 * 게시판 코드별 페이징 처리용 오브젝트 생성
	 * @param brd_code
	 * @param page_num
	 * @return
	 */
	@Override
	public EgovMap getPagingObject(String brd_code, int page_num) {
		EgovMap result = new EgovMap();
		BoardMstVO brdMst = commonMapper.findeByBrdCode(brd_code);
		int pageSize = IntegerUtil.isNull(brdMst.getPage_size());
		int strNum = 0;
		int endNum = 0;
		if(page_num > 1) {
			strNum = (page_num - 1) * pageSize + 1;
			endNum = strNum + pageSize - 1;
		} else {
			strNum = 1;
			endNum = pageSize;
		}
		
		PagingUtil paging = new PagingUtil();
		paging.setPageNum(page_num);
		paging.setPageSize(pageSize);
		paging.setTotalCount(0);
		
		result.put("paging", paging);
		result.put("strNum", strNum);
		result.put("endNum", endNum);
		return result;
	}
		
		

		
	
	
	
	
	
}
