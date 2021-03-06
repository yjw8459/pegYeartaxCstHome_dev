package kr.co.pegsystem.qna.service.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;


import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.admin.service.AdminQnAService;
import kr.co.pegsystem.admin.vo.StsVO;
import kr.co.pegsystem.board.service.BoardService;
import kr.co.pegsystem.board.vo.AttachFileVO;
import kr.co.pegsystem.board.vo.BoardMstVO;
import kr.co.pegsystem.common.mapper.CommonMapper;
import kr.co.pegsystem.common.service.CommonService;
import kr.co.pegsystem.common.vo.Board;
import kr.co.pegsystem.common.vo.CommonVO;
import kr.co.pegsystem.common.vo.SearchConditionVO;
import kr.co.pegsystem.qna.mapper.QnAMapper;
import kr.co.pegsystem.qna.service.QnAService;
import kr.co.pegsystem.qna.vo.QnAVO;
import pegsystem.util.PagingUtil;
import pegsystem.util.RequestUtil;

// 1. 어떻게 구성할 것인가.
// 2. board 패키지와의 공통된 로직들을 효율적으로 묶을 수 있는 방법
// 3. QnA의 별도의 로직 분리

@Service("qnaService")
public class QnAServiceImpl implements QnAService{

	@Resource(name = "commonService") private CommonService commonService;
	@Resource(name = "boardService") private BoardService boardService;
	@Resource(name = "adminQnAService") private AdminQnAService adminQnAService;
	
	@Resource(name = "qnaMapper") private QnAMapper mapper;
	@Resource(name = "commonMapper") private CommonMapper commonMapper;
	
	@Override
	public EgovMap main(String url) {
		EgovMap result = new EgovMap();
		
		List<CommonVO> c001 = commonMapper.findByCdId("C001");
		List<CommonVO> c002 = commonMapper.findByCdId("C002");
		List<CommonVO> c004 = commonMapper.findByCdId("C004");
		List<CommonVO> c007 = commonMapper.findByCdId("C007");
		
		String brd_code = commonService.findeByBrdCodeWithUrl(url);
		BoardMstVO brdMst = commonService.findeByBrdCode(brd_code);
		
		result.put("brdMst", brdMst);
		result.put("c001", c001);
		result.put("c002", c002);
		result.put("c004", c004);
		result.put("c007", c007);
		
		return result;
	}
	
	@Override
	public EgovMap qnaList(SearchConditionVO conditionVO, String usr_cat) {
		EgovMap result = new EgovMap();
		String brd_code = conditionVO.getBrd_code();
		int page_num = conditionVO.getPage_num();
		EgovMap pagingObject = boardService.getPagingObject(brd_code, page_num);
		PagingUtil paging = (PagingUtil)pagingObject.get("paging");
		conditionVO.setStr_num((Integer)pagingObject.get("strNum"));
		conditionVO.setEnd_num((Integer)pagingObject.get("endNum"));
		List<QnAVO> list = mapper.findByQnAList(conditionVO);
		
		if ( list != null && list.size() > 0  ) {
			QnAVO vo = list.get(0);
			paging.setTotalCount(vo.getTotal_count());
		}
		
		result.put("list", list);
		result.put("page", paging);
		
		return result;
	}

	@Override
	@Transactional
	public EgovMap qnaDetail(SearchConditionVO conditionVO) {
		EgovMap result = new EgovMap();
		QnAVO question = null;
		BoardMstVO brdMst = null;
		List<AttachFileVO> files = null;
		try {
			String brd_code = conditionVO.getBrd_code();
			int brd_idx = conditionVO.getBrd_idx();
			brdMst = commonMapper.findeByBrdCode(brd_code);
			
			question = mapper.findQnAByBrdIdx(brd_idx);
			if ( question != null ) {
				files = commonMapper.findAttachFilesByBrdCodeAndBrdIdx(new Board(brd_code, brd_idx));
				mapper.updateQnAHitCount(question);
				
				//사용자 확인 완료 (질문 자가 답변을 확인했을경우)
				String lstSts = question.getLst_sts();
				if ( "21".equals(lstSts) ) 
				{
					String ent_uno = question.getEnt_uno();
					String usr_id = conditionVO.getUsr_id();
					if ( ent_uno.equals(usr_id) ) {
						question.setLst_sts("31");
						adminQnAService.updateSts(question);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		result.put("board", question);
		result.put("brdMst", brdMst);
		result.put("attachFiles", files);
		return result;
	}
	
	@Override
	@Transactional
	public EgovMap save(QnAVO qnaVO) {
		qnaVO.setReq_cat("01");
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		try {
			
			if ( qnaVO.getBrd_idx() > 0 ) 	retCode = mapper.updateQnA(qnaVO);
			else 
			{
				qnaVO.setBrd_idx(mapper.countQnA());
				qnaVO.setLst_sts("01");
				qnaVO.setClient_ip(RequestUtil.getClientIpAddress());
				retCode = mapper.insertQnA(qnaVO);
				
				if ( retCode > 0 ) //Sts 
					retCode = commonService.insertSts(qnaVO);
			}
			if ( retCode > 0 ) {	//첨부파일
				List<MultipartFile> attachFiles = qnaVO.getAttachFiles();
				commonService.insertAttachFiles(attachFiles, qnaVO.getBrd_code(), qnaVO.getBrd_idx(), qnaVO.getEnt_uno());
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

	@Override
	public EgovMap qnaForm(String brd_code, int brd_idx) {
		EgovMap result = new EgovMap();
		List<CommonVO> c001 = commonMapper.findByCdId("C001");
		List<CommonVO> c002 = commonMapper.findByCdId("C002");
		List<CommonVO> c003 = commonMapper.findByCdId("C003");
		List<CommonVO> c004 = commonMapper.findByCdId("C004");
		List<CommonVO> c005 = commonMapper.findByCdId("C005");
		List<CommonVO> c006 = commonMapper.findByCdId("C006");
		List<CommonVO> c007 = commonMapper.findByCdId("C007");
		List<CommonVO> c008 = commonMapper.findByCdId("C008");
		BoardMstVO brdMst = commonMapper.findeByBrdCode(brd_code);
		
		//수정일 경우
		if ( brd_idx > 0 ) {
			Board board = new Board(brd_code, brd_idx);
			List<AttachFileVO> files = commonMapper.findAttachFilesByBrdCodeAndBrdIdx(board);
			result.put("board", mapper.findQnAByBrdIdx(brd_idx));
			result.put("attachFiles", files);
		}
		
		result.put("c001", c001);
		result.put("c002", c002);
		result.put("c003", c003);
		result.put("c004", c004);
		result.put("c005", c005);
		result.put("c006", c006);
		result.put("c007", c007);
		result.put("c008", c008);
		result.put("brdMst", brdMst);
		result.put("brd_idx", brd_idx);
		return result;
	}
	
	@Override
	@Transactional
	public EgovMap delete(QnAVO qnaVO) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		try {
		retCode = mapper.deleteQnAData(qnaVO);
		if ( retCode > 0 ) 
		{
			qnaVO.setLst_sts("41");
			commonService.insertSts(qnaVO);
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
	
	
	@Override
	public EgovMap stsList(String brd_code, int brd_idx) {
		EgovMap result = new EgovMap();
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("brd_code", brd_code);
		param.put("brd_idx", brd_idx);
		List<StsVO> history = mapper.findStsByBrdIdx(param);
		result.put("stsList", history);
		
		return result;
	}

}
