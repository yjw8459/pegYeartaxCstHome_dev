package kr.co.pegsystem.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.PegWebConfigProperties;
import kr.co.pegsystem.admin.mapper.AdminBoardMapper;
import kr.co.pegsystem.admin.service.AdminBoardService;
import kr.co.pegsystem.admin.vo.BoardMngVO;
import kr.co.pegsystem.common.service.CommonService;
import kr.co.pegsystem.common.vo.CommonVO;
import pegsystem.util.PagingUtil;
import pegsystem.util.StringUtil;

@Service("adminBoardService")
public class AdminBoardServiceImpl implements AdminBoardService{

	
	@Resource(name="commonService")	private CommonService commonService;
	@Resource(name="adminBoardMapper")	private AdminBoardMapper mapper;
	@Resource(name="pegWebConfigProperties") private PegWebConfigProperties props;
	
	
	
	@Override
	public EgovMap boardMngList(int page_num) {
		EgovMap result = new EgovMap();
		EgovMap pagingObject = getPagingObject(page_num);
		PagingUtil paging = (PagingUtil) pagingObject.get("paging");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("str_num", pagingObject.get("strNum"));
		param.put("end_num", pagingObject.get("endNum"));
		List<BoardMngVO> list = mapper.findBoardMngList(param);
		if(list != null && list.size() > 0) {
			BoardMngVO temp = list.get(0);
			paging.setTotalCount(temp.getTotal_count());
		}		
		
		result.put("list", list);
		result.put("paging", paging);
		return result;
	}
	
	
	@Override
	@Transactional
	public EgovMap updateUseYn(String brd_code, String use_yn, String usr_id) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		
		try {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("brd_code", brd_code);
			param.put("use_yn", use_yn);
			param.put("upd_uno", usr_id);
			retCode = mapper.updateBoardUseYn(param);
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
	public EgovMap modalBoardForm(String brd_code) {
		EgovMap result = new EgovMap();
		
		List<CommonVO> c008 = commonService.selectCommonCode("C008");	// 게시판 타입
		BoardMngVO board = mapper.findBoardMngDataByBrdCode(brd_code);
		
		result.put("c008", c008);
		result.put("board", board);
		return result;
	}
	
	
	@Override
	public EgovMap brdCodeDupCheck(String brd_url) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		
		retCode = mapper.findBrdCodeCountByBrdCode(brd_url);
			
		result.put("retCode", retCode);
		result.put("retMsg", retMsg);
		return result;
	}
	
	
	@Override
	@Transactional
	public EgovMap save(BoardMngVO boardMngVO) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		
		try {
			String saveCat = boardMngVO.getSave_cat();
			if("insert".equals(saveCat)) {
				int maxBrdCode = mapper.findMaxBrdCode();
				String brdCode = StringUtil.lpad((maxBrdCode+1), 5);
				boardMngVO.setBrd_code(brdCode);
				mapper.insertP2yCstBrdMst(boardMngVO);
				retCode++;
			} else if("update".equals(saveCat)) {
				retCode = mapper.updateP2yCstBrdMst(boardMngVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
			retCode = -999;
			retMsg = e.getMessage();
		}
		
		result.put("retCode", retCode);
		result.put("retMsg", retMsg);
		return result;
	}	
	
	private EgovMap getPagingObject(int page_num) {
		EgovMap result = new EgovMap();
		int pageSize = props.getAdminPagingSize();
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
