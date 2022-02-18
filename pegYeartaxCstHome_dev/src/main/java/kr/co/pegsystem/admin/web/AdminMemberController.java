
package kr.co.pegsystem.admin.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.admin.service.AdminMemberService;
import kr.co.pegsystem.admin.vo.MemberMngVO;

@Controller
public class AdminMemberController {

	@Resource(name="adminMemberService") private AdminMemberService service;
	
	
	
	
	
	/**
	 * 회원관리 리스트 페이지
	 * @return
	 */
	@GetMapping(value="/adm/mem-mng")
	public ModelAndView memberMng() {
		EgovMap result = null;
		return new ModelAndView("/admin/memberMng").addObject("result", result);
	}
	
	
	/**
	 * 검색
	 * @param search_cat
	 * @param keyword
	 * @param page_num
	 * @return
	 */
	@PostMapping(value="/adm/mem-mng")
	@ResponseBody
	public EgovMap memberList(@RequestParam(value="keyword", defaultValue="")String keyword
		    				 ,@RequestParam(value="page_num", defaultValue="1")int page_num) {
		EgovMap result = service.memberMngList(keyword, page_num);
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
	@PostMapping(value="/adm/mem-use")
	@ResponseBody
	public EgovMap updateUseYn(@RequestParam(value="cst_id", defaultValue="")String cst_id
							  ,@RequestParam(value="comp_code", defaultValue="")String comp_code
							  ,@RequestParam(value="usr_id", defaultValue="")String usr_id
							  ,@RequestParam(value="use_yn", defaultValue="")String use_yn) {
		EgovMap result = service.updateUseYn(cst_id, comp_code, usr_id, use_yn);
		return result;
	}
	
	
	/**
	 * 회원정보 추가/수정 폼
	 * @param memberMngVO
	 * @return
	 */
	@PostMapping(value="/adm/mem-form")
	@ResponseBody
	public EgovMap modalMemberForm(MemberMngVO memberMngVO) {
		EgovMap result = service.modalMemberForm(memberMngVO);
		return result;
	}
	
	
	/**
	 * 사업장정보 조회
	 * @param cst_id
	 * @return
	 */
	@PostMapping(value="/adm/comp-code")
	@ResponseBody
	public EgovMap getCompCode(String cst_id) {
		EgovMap result = service.getCompCode(cst_id);
		return result;
	}
	
	
	/**
	 * 아이디 중복 체크
	 * @param usr_id
	 * @return
	 */
	@PostMapping(value="/adm/usr-dup")
	@ResponseBody
	public EgovMap userIdDupCheck(@RequestParam(value="usr_id", defaultValue="")String usr_id) {
		EgovMap result = service.usrIdDupCheck(usr_id);
		return result;
	}
	
	
	/**
	 * 변경사항 저장
	 * @param memberMngVO
	 * @return
	 */
	@PostMapping(value="/adm/mem-save")
	@ResponseBody
	public EgovMap save(MemberMngVO memberMngVO) {
		EgovMap result = service.save(memberMngVO);
		return result;
	}
	
	
	
	
}
