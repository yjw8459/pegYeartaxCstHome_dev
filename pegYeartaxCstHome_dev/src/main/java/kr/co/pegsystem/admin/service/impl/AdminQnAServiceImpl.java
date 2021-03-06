package kr.co.pegsystem.admin.service.impl;


import java.time.LocalDate;

import java.time.format.DateTimeFormatter;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.admin.mapper.AdminQnAMapper;
import kr.co.pegsystem.admin.service.AdminQnAService;
import kr.co.pegsystem.admin.vo.MemberMngVO;
import kr.co.pegsystem.board.vo.AttachFileVO;
import kr.co.pegsystem.board.vo.BoardMstVO;
import kr.co.pegsystem.common.service.CommonService;
import kr.co.pegsystem.common.service.CommonUtil;
import kr.co.pegsystem.common.vo.CommonVO;
import kr.co.pegsystem.common.vo.SearchConditionVO;
import kr.co.pegsystem.qna.mapper.QnAMapper;
import kr.co.pegsystem.qna.vo.QnAVO;
import pegsystem.util.PagingUtil;

@Service("adminQnAService")
public class AdminQnAServiceImpl implements AdminQnAService{

	@Resource(name = "commonService") private CommonService commonService;
	
	@Resource(name = "adminQnAMapper") private AdminQnAMapper mapper;
	
	@Resource(name = "qnaMapper") private QnAMapper qnaMapper;
	
	@Override
	public EgovMap main() {
		EgovMap result = new EgovMap();
		//commonService.defaultQnASettings();
		List<CommonVO> c001 = commonService.selectCommonCode("C001");	//업무구분
		List<CommonVO> c002 = commonService.selectCommonCode("C002");	//질문구분
		List<CommonVO> c003 = commonService.selectCommonCode("C003");	//문의방법
		List<CommonVO> c004 = commonService.selectCommonCode("C004");	//진행상태
		List<CommonVO> c007 = commonService.selectCommonCode("C007");	//정산년도
		String brd_code = commonService.findeByBrdCodeWithUrl("QnA");
		BoardMstVO brdMst = commonService.findeByBrdCode(brd_code);
		result.put("c001", c001);
		result.put("c002", c002);
		result.put("c003", c003);
		result.put("c004", c004);
		result.put("c007", c007);
		result.put("brdMst", brdMst);
		result.put("defaultDate", defaultConditionDate());
		return result;
	}
	
	@Override
	public EgovMap qnaList(SearchConditionVO conditionVO) {
		EgovMap result = new EgovMap();
		int page_num = conditionVO.getPage_num();
		EgovMap pagingObject = getPageUtil(page_num);
		PagingUtil paging = (PagingUtil)pagingObject.get("paging");
		conditionVO.setStr_num((Integer)pagingObject.get("strNum"));
		conditionVO.setEnd_num((Integer)pagingObject.get("endNum"));
		List<QnAVO> list = mapper.findByAdmQnAList(conditionVO);
		
		if ( list != null && list.size() > 0 ) {
			QnAVO vo = list.get(0);
			paging.setTotalCount(vo.getTotal_count());
		}
		result.put("boardList", list);
		result.put("paging", paging);
		return result;
	}
	
	/**
	 * 관리자 QnA글 상세조회
	 * 
	 * P2Y_CST_QNA 테이블 구조 수정 (답변 컬럼 추가)에 따른 Answer 로직 수정 
	 */
	@Override
	public EgovMap qnaDetail(int brd_idx) {
		if ( brd_idx < 1 )	return null;
		EgovMap result = new EgovMap();
		QnAVO question = mapper.findQnAByBrdIdx(brd_idx);
		List<AttachFileVO> questionFiles = null;
		
		if ( question != null ) {
			questionFiles = commonService.findAttachFilesByBrdCodeAndBrdIdx(question);
			result.put("questionFiles", questionFiles);
		}

		result.put("question", question);
		
		return result;
	}
	
	/**
	 * 관리자가 답변 저장 
	 */
	@Override
	@Transactional
	public EgovMap saveAnswer(QnAVO qnaVO) {
		EgovMap result = new EgovMap();
		qnaVO.setLst_sts("21");
		try {
			if ( qnaVO.getBrd_idx() < 1 ) 
				throw new IllegalStateException("올바른 값이 아닙니다.");
			if ( mapper.saveAnswer(qnaVO) > 0 ) 
				result = CommonUtil.savePostProc(commonService.insertSts(qnaVO));
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
	
	/**
	 * 관리자가 질문 답변 둘 다 저장 
	 */
	@Override
	public EgovMap directSave(QnAVO qnaVO) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		try {
			//질문 insert
			qnaVO.setBrd_idx(mapper.findQnAIdx());
			qnaVO.setShr_yn("N");
			retCode = qnaMapper.insertQnA(qnaVO);
			
			//파일 저장
			if ( retCode > 0 ) insertFile(qnaVO);
			
			//sts 히스토리 로그 insert (확인완료)
			if ( retCode > 0 ) {
				retCode = commonService.insertSts(qnaVO);
				if(retCode > 0) retCode += mapper.updateSts(qnaVO);
				if(retCode > 1) retMsg = "SUCCESS";
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
	@Transactional
	public int directUpdate(QnAVO qnaVO) {
		int retCode = 0;
		try {
			retCode = mapper.updateDirectQnA(qnaVO);
			
			if ( retCode > 0 ) {
				insertFile(qnaVO);
				commonService.insertSts(qnaVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
			retCode = -999;
		}
		return retCode;
	}
	
	
	@Override
	public EgovMap search_users(String keyword) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		List<MemberMngVO> users = null;
		try {
			users = mapper.findUsersByKeyword(keyword);
		} catch (Exception e) {
			e.printStackTrace();
			retCode = -999;
			retMsg = e.getMessage();
		}
		result.put("retCode", retCode);
		result.put("retMsg", retMsg);
		result.put("users", users);
		return result;
	}

	
	@Override
	@Transactional
	public EgovMap updateSts(QnAVO qnaVO) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		try {
			retMsg = "접수 처리에 실패했습니다.";
			retCode = mapper.updateSts(qnaVO);
			if ( retCode > 0 ) {//STS 히스토리 INSERT
				retCode = commonService.insertSts(qnaVO);
				retMsg = "접수 상태가 변경되었습니다.";
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
	

	
	public void insertFile(QnAVO qnaVO) throws Exception{
		List<MultipartFile> files = qnaVO.getAttachFiles();
		if ( files.size() > 0 ) {
			commonService.insertAttachFiles(files, qnaVO.getBrd_code(), 
											qnaVO.getBrd_idx(), qnaVO.getEnt_uno());
		}
	}
	
	public EgovMap getPageUtil(int page_num) {
		EgovMap result = new EgovMap();
		int pageSize = 10;
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
	
	//검색기간 from to 기본 날짜 
	public EgovMap defaultConditionDate() {
		EgovMap result = new EgovMap();
		DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyyMMdd");
		
		//from : 작년 해당 월 초일
		LocalDate date = LocalDate.now();
		date = date.minusYears(1);
		date = date.withDayOfMonth(1);
		String before = format.format(date);
		
		//to : 내년 해당 월 말일
		date = LocalDate.now();
		date = date.plusYears(1);
		date = date.withDayOfMonth(date.getMonth().length(false));
		String after = format.format(date);
		
		result.put("from", before);
		result.put("to", after);
		return result;
	}

	/**
	 * QnA 질문 삭제 || 답글 삭제 || 전체삭제
	 */
	@Override
	@Transactional
	public EgovMap deleteQnA(QnAVO qnaVO) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		try {
			retCode = mapper.deleteQnA(qnaVO);
		} catch (Exception e) {
			e.printStackTrace();
			retCode = -999;
			retMsg = e.getMessage();
		}
		result.put("retCode", retCode);
		result.put("retMsg", retMsg);
		return result;
	}
	
	
	
}
