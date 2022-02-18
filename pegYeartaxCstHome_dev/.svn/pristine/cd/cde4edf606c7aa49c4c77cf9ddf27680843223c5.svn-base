package kr.co.pegsystem.common.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.admin.vo.MemberMngVO;
import kr.co.pegsystem.common.service.CommonService;
import kr.co.pegsystem.common.vo.CommonVO;
import kr.co.pegsystem.common.vo.SignUpVO;
import kr.co.pegsystem.common.vo.UserDataVO;
import kr.co.pegsystem.core.util.ReturnPath;
import pegsystem.util.ContextUtil;
import pegsystem.util.IntegerUtil;

@Controller
public class CommonController {

	
	@Resource(name="commonService") private CommonService service;
	
	
	
	
	/**
	 * 관리자가 아닌데 관리자 페이지에 접근
	 * @param request
	 * @return
	 */
	@GetMapping("/cmmn/denied")
	public ModelAndView accessDenied(@RequestParam(value="wrk_cat", defaultValue="")String wrk_cat
									,HttpServletRequest request) {
		String msg = "";
		if("usr".equals(wrk_cat)) msg = "로그인 정보가 존재하지 않습니다.";
		else if("adm".equals(wrk_cat)) msg = "관리자만 접근할 수 있는 페이지 입니다.";
		else if("brd".equals(wrk_cat)) msg = "유효하지 않은 게시판 코드 입니다.";
		
		ReturnPath.historyBack(request, msg);
		return new ModelAndView("/common/message");
	}
	
	
	/**
	 * 로그인 페이지
	 * @return
	 */
	@GetMapping(value="/cmmn/login")
	public ModelAndView loginPage(@RequestParam(value = "msg", defaultValue = "") String msg) {
		return new ModelAndView("/common/login").addObject("msg", msg);
	}
	
	
	/**
	 * 로그인 프로세스
	 * @return
	 */
	@PostMapping(value="/cmmn/login")
	@ResponseBody
	public EgovMap loginAction(@RequestParam(value="user_id", defaultValue="")String user_id
							  ,@RequestParam(value="user_pwd", defaultValue="")String user_pwd) {
		EgovMap result = service.loginAction(user_id, user_pwd);
		return result;
	}
	

	/**
	 * 로그인 이후 시작 페이지 분기
	 * @param request
	 * @return
	 */
	@GetMapping(value="/cmmn/loginCallback")
	public ModelAndView loginSuccessCallback(HttpServletRequest request) {
		UserDataVO userDataVO = (UserDataVO) ContextUtil.getAttrFromSession("userDataVO");
		if(userDataVO == null) {
			return new ModelAndView("redirect:/cmmn/denied?wrk_cat=usr");
		} else {
			String viewName = "";
			int usrCat = IntegerUtil.isNull(userDataVO.getUsr_cat());
			if(usrCat > 90) viewName = "redirect:/adm/QnA-mng";		// 관리자
			else if(usrCat > 0) viewName = "redirect:/brd/list?brd_cat=FAQ";	// 사용자
//			String usr_cat = userDataVO.getUsr_cat();
//			if("01".equals(usr_cat)) viewName = "redirect:/brd/list?brd_cat=FAQ";	// 사용자
//			else if("91".equals(usr_cat)) viewName = "redirect:/adm/QnA-mng";		// 관리자
//			else if("99".equals(usr_cat)) viewName = "redirect:/adm/QnA-mng";		// 관리자
			return new ModelAndView(viewName);
		}
	}
	
	
	
	/**
	 * 로그아웃 프로세스
	 * @param session
	 * @return
	 */
	@GetMapping(value="/cmmn/logout")
	public String logoutAction(HttpSession session) {
		session.invalidate();
		return "redirect:/cmmn/login";
	}
	
	

	
	
	
	
	
	/**
	 * 공통코드 조회 
	 * @param cd_id
	 * @return
	 */
	@PostMapping(value = "/cmmn/commonCode")
	@ResponseBody
	public List<CommonVO> commonCode(String cdId){
		return service.selectCommonCode(cdId);
	}
	
	
	/**
	 * 회원가입 신청 
	 * @param cstName, usrName, usrEmail, usrDept, usrTel, offTel
	 * @return
	 */
	@PostMapping(value = "/cmmn/signUp")
	@ResponseBody
	public EgovMap requestSignUp(SignUpVO signUpVO) {
		return service.signUpAction(signUpVO);
	}
	
	/**
	 * 이메일 중복체크 
	 * @param usrEmail
	 * @return
	 */
	@PostMapping(value = "/cmmn/mailChk")
	@ResponseBody
	public EgovMap mailChk(String mail) {
		return service.signUpMailChk(mail); 
	}
	
	
	/**
	 * 비밀번호 초기화
	 * @param memberMngVO
	 * @return
	 */
	@PostMapping(value = "/cmmn/initPwd")
	@ResponseBody
	public EgovMap initPassword(MemberMngVO memberMngVO) {
		EgovMap result = service.initPassword(memberMngVO);
		return result; 
	}
	
	
	
	
	
	
	
	
	
	
	/**
	 * 검색조건 세션 제거 프로세스
	 * @param session, formPath, detailPath, brd_cat
	 * @return
	 */
	@GetMapping(value = "/{formPath}/{detailPath}/reset")
	public ModelAndView conditionReset(HttpSession session,
									   @PathVariable("formPath") String formPath,
									   @PathVariable("detailPath") String detailPath,
									   @RequestParam(value = "brd_cat", defaultValue = "") String brd_cat) {
		String viewName = "redirect:/" + formPath + "/" + detailPath;
		session.removeAttribute("condition");
		if ( !"".equals(brd_cat) ) viewName += "?brd_cat=" + brd_cat;
		return new ModelAndView(viewName);
	}
	
	
	
	
	
	
	@GetMapping(value = "/error")
	public String handlerError(HttpServletRequest request) {
		String viewName = "error"; 
		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		System.out.println(status);
//		//404이고 로그인 정보가 없다면 로그인 창으로 이동
//		if ( "404".equals(status.toString()) ) 
//		{
//			HttpSession session = request.getSession();
//			if ( session.getAttribute("userRole") == null ) 	viewName = "redirect:/cmmn/login";
//		}
		
		return viewName;
	}
	
	
	
	/**
	 * 이메일 인증키 생성 후 이메일 발송
	 * @param email
	 * @param session
	 * @return
	 */
	@PostMapping(value="/cmmn/email-key")
	@ResponseBody
	public EgovMap createEmailKeySubmit(@RequestParam(value="email", defaultValue="")String email
									   ,HttpSession session) {
		EgovMap result = service.createEmailAuthKey(email, session);
		return result;
	}
	
	
	/**
	 * 이메일 인증
	 * @param key
	 * @param session
	 * @return
	 */
	@PostMapping(value="/cmmn/email-key-auth")
	@ResponseBody
	public EgovMap compareEmailAuthKey(@RequestParam(value="key", defaultValue="")String key
					   				  ,HttpSession session) {
		EgovMap result = service.compareEmailAuthKey(key, session);
		return result;
	}
	
	
	@PostMapping(value = "/cmmn/file_del")
	@ResponseBody
	public EgovMap fileDelete(@RequestParam(value = "brd_code") String brd_code,
							  @RequestParam(value = "brd_idx") int brd_idx,
							  @RequestParam(value = "file_idx") int file_idx) {
		EgovMap result = service.fileDelete(brd_code, brd_idx, file_idx);
		return result;
	}
	
}
