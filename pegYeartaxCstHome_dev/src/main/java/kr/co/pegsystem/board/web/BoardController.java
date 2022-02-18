package kr.co.pegsystem.board.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.board.service.BoardService;
import kr.co.pegsystem.board.vo.BoardVO;
import kr.co.pegsystem.common.service.CommonService;
import pegsystem.util.StringUtil;

@Controller
public class BoardController {

	@Resource(name = "commonService") private CommonService commonService;
	@Resource(name="boardService") private BoardService service;
	
	
	
	
	
	
	
	/**
	 * 게시판 메인 리스트
	 * brdType 1: 일반게시판
	 *         2: FAQ
	 *         3: Q&A(Q&A는 별도 로직으로)
	 * @param url
	 * @return
	 */
	@GetMapping(value="/brd/list")
	public ModelAndView faqBoardMain(@RequestParam(value="brd_cat", defaultValue="")String url) {
		EgovMap result = service.boardMain(url);
		String brdType = StringUtil.isNull(result.get("brdType"));
		String viewName = "";
		if("01".equals(brdType)) viewName = "/board/list";
		else if("02".equals(brdType)) viewName = "/board/faq";
		else if("03".equals(brdType)) viewName = "/qna/qna";
		return new ModelAndView(viewName).addObject("result", result);
	}
	
	
	/**
	 * 검색
	 * @param brd_code
	 * @param sac_yy
	 * @param wrk_cat
	 * @param qst_cat
	 * @param keyword
	 * @return
	 */
	@PostMapping(value="/brd/list")
	@ResponseBody
	public EgovMap boardList(@RequestParam(value="brd_code", defaultValue="")String brd_code
						    ,@RequestParam(value="sac_yy", defaultValue="")String sac_yy
							,@RequestParam(value="wrk_cat", defaultValue="")String wrk_cat
							,@RequestParam(value="qst_cat", defaultValue="")String qst_cat
							,@RequestParam(value="keyword", defaultValue="")String keyword
							,@RequestParam(value="page_num", defaultValue="1")int page_num) {
		EgovMap result = service.boardList(brd_code, sac_yy, wrk_cat, qst_cat, keyword, page_num);
		return result;
	}
	
	
	/**
	 * 게시글 작성폼
	 * @param brd_code
	 * @param brd_idx
	 * @return
	 */
	@PostMapping(value="/brd/form")
	public ModelAndView boradFormPage(@RequestParam(value="brd_code", defaultValue="")String brd_code
							  		 ,@RequestParam(value="brd_idx", defaultValue="0")int brd_idx) {
		EgovMap result = service.boardFormDefaultData(brd_code, brd_idx);
		return new ModelAndView("/board/form").addObject("result", result);
	}
	
	
	/**
	 * 게시글 저장/수정
	 * @param boardVO
	 * @return
	 */
	@PostMapping(value="/brd/save")
	public ModelAndView save(BoardVO boardVO) {
		EgovMap result = service.saveBoardData(boardVO);
		return new ModelAndView("redirect:/brd/list?brd_cat=" + boardVO.getBrd_cat()).addObject("result", result);
	}	
	
	
	/**
	 * 게시글 삭제
	 * @param brd_code
	 * @param brd_idx
	 * @param usr_id
	 * @return
	 */
	@PostMapping(value = "/brd/delete")
	@ResponseBody
	public EgovMap delete(@RequestParam(name="brd_code", defaultValue="")String brd_code
						 ,@RequestParam(name="brd_idx", defaultValue="0")int brd_idx
						 ,@RequestParam(name="usr_id", defaultValue="")String usr_id) {
		EgovMap result = service.deleteBoardData(brd_code, brd_idx, usr_id);
		return result;
	}	
	
	
	/**
	 * 상세보기
	 */
	@PostMapping(value="/brd/content")
	public ModelAndView content(@RequestParam(name="brd_code", defaultValue="")String brd_code
					 		   ,@RequestParam(value="brd_idx", defaultValue="0")int brd_idx) {
		EgovMap result = service.boardDetail(brd_code, brd_idx);
		return new ModelAndView("/board/content").addObject("result", result);
	}	
	
	
	/**
	 * 첨부파일 다운로드
	 * @param brd_code
	 * @param brd_idx
	 * @param file_idx
	 * @return
	 */
	@GetMapping(value="/brd/download")
	public void downloadFile(@RequestParam(value="brd_code", defaultValue="")String brd_code
						 		    ,@RequestParam(value="brd_idx", defaultValue="")int brd_idx
						 		    ,@RequestParam(value="file_idx", defaultValue="")int file_idx
						 		    ,HttpServletRequest request
						 		    ,HttpServletResponse response) {
		EgovMap result = commonService.getAttachFileData(brd_code, brd_idx, file_idx, request);
		File attachFile = (File) result.get("attachFile");
		String fileName = StringUtil.isNull(result.get("fileName"));
		OutputStream outputStream = null;
		FileInputStream fileInputStream = null;
        try {
        	response.setHeader("Content-Disposition", fileName);
        	response.setHeader("Content-Transfer-Encoding", "binary");
        	
        	outputStream = response.getOutputStream();
        	fileInputStream = new FileInputStream(attachFile);
            FileCopyUtils.copy(fileInputStream, outputStream);
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            if(fileInputStream != null) {
                try { fileInputStream.close(); } 
                catch(Exception e) { e.printStackTrace(); }
            }
            if(outputStream != null) {
            	try { outputStream.close(); } 
            	catch(Exception e) { e.printStackTrace(); }
            }
        }
	}
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	
	

	
	
}
