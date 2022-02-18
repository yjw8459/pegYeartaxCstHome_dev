package kr.co.pegsystem.admin.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.admin.service.AdminBoardService;
import kr.co.pegsystem.admin.vo.BoardMngVO;

@Controller
public class AdminBoardController {

	@Resource(name="adminBoardService") AdminBoardService service;
	
	
	
	
	
	/**
	 * 게시판관리 리스트 페이지
	 * @return
	 */
	@GetMapping(value="/adm/brd-mng")
	public ModelAndView boardMng() {
		EgovMap result = null;
		return new ModelAndView("/admin/boardMng").addObject("result", result);
	}
	
	
	/**
	 * 검색
	 * @param page_num
	 * @return
	 */
	@PostMapping(value="/adm/brd-mng")
	@ResponseBody
	public EgovMap boardList(@RequestParam(value="page_num", defaultValue="1")int page_num) {
		EgovMap result = service.boardMngList(page_num);
		return result;
	}
	
	
	/**
	 * 사용여부 업데이트
	 * @param cst_id
	 * @param comp_code
	 * @param usr_id
	 * @param use_yn
	 * @return
	 */
	@PostMapping(value="/adm/brd-use")
	@ResponseBody
	public EgovMap updateUseYn(@RequestParam(value="brd_code", defaultValue="")String brd_code
							  ,@RequestParam(value="use_yn", defaultValue="")String use_yn
							  ,@RequestParam(value="usr_id", defaultValue="")String usr_id) {
		EgovMap result = service.updateUseYn(brd_code, use_yn, usr_id);
		return result;
	}
	
	
	/**
	 * 게시판 추가/수정 폼
	 * @param brd_code
	 * @return
	 */
	@PostMapping(value="/adm/brd-form")
	@ResponseBody
	public EgovMap modalBoardForm(String brd_code) {
		EgovMap result = service.modalBoardForm(brd_code);
		return result;
	}
	
	
	/**
	 * 게시판 코드 중복 체크
	 * @param brd_url
	 * @return
	 */
	@PostMapping(value="/adm/brd-dup")
	@ResponseBody
	public EgovMap brdCodeDupCheck(@RequestParam(value="brd_url", defaultValue="")String brd_url) {
		EgovMap result = service.brdCodeDupCheck(brd_url);
		return result;
	}	
	
	
	/**
	 * 변경사항 저장
	 * @param boardMngVO
	 * @return
	 */
	@PostMapping(value="/adm/brd-save")
	@ResponseBody
	public EgovMap save(BoardMngVO boardMngVO) {
		EgovMap result = service.save(boardMngVO);
		return result;
	}	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
