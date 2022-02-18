package kr.co.pegsystem.member.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.admin.vo.MemberMngVO;
import kr.co.pegsystem.common.vo.UserDataVO;
import kr.co.pegsystem.member.service.MemberService;


@Controller
public class MemberController {

	
	
	
	@Resource(name="memberService") private MemberService service;
	
	
	
	/**
	 * 회원정보 리턴
	 * @param session
	 * @return
	 */
	@PostMapping(value="/mem/usr-data")
	@ResponseBody
	public EgovMap memberModifyData(HttpSession session) {
		EgovMap result = new EgovMap();
		UserDataVO userDataVO = (UserDataVO) session.getAttribute("userDataVO");
		result.put("user", userDataVO);
		return result;
	}
	
	
	/**
	 * 변경사항 저장
	 * @param memberMngVO
	 * @return
	 */
	@PostMapping(value="/mem/usr-save")
	@ResponseBody
	public EgovMap save(MemberMngVO memberMngVO) {
		EgovMap result = service.save(memberMngVO);
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
