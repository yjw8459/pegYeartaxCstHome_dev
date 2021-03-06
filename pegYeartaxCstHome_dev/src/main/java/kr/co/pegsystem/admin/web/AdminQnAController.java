package kr.co.pegsystem.admin.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ch.qos.logback.core.Context;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.admin.service.AdminQnAService;
import kr.co.pegsystem.common.vo.SearchConditionVO;
import kr.co.pegsystem.common.vo.UserDataVO;
import kr.co.pegsystem.qna.vo.QnAVO;
import pegsystem.util.ContextUtil;

//QnA관리

@Controller
@RequestMapping(value = "/adm/QnA-mng")
public class AdminQnAController {

	@Resource(name = "adminQnAService") private AdminQnAService service;
	
	@RequestMapping(value="", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView list(SearchConditionVO conditionVO) {
		EgovMap result = service.main();
		return new ModelAndView("/admin/QnAMng")
				.addObject("result", result)
				.addObject("condition", conditionVO);
	}
	
	@RequestMapping(value="/direct", method={RequestMethod.GET, RequestMethod.POST})
	public ModelAndView direct(@RequestParam(value = "brd_idx", defaultValue = "0") int brd_idx) {
		
		return new ModelAndView("/admin/QnAMng_direct_form")
					.addObject("result", service.main())
					.addObject("detail", service.qnaDetail(brd_idx))
					.addObject("brd_idx", brd_idx)
					;
	}

	@PutMapping(value = "/save")
	@ResponseBody
	public EgovMap save(@RequestBody QnAVO qnaVO) {
		return service.saveAnswer(qnaVO);
	}
	
	
	@PostMapping(value = "/direct_save")
	public ModelAndView direct_save(QnAVO qnaVO) {
//		EgovMap result = service.directSave(qnaVO);
		service.directSave(qnaVO);
		return new ModelAndView("redirect:/adm/QnA-mng")
					;
	}
	
	@PostMapping(value = "/direct_update")
	public ModelAndView direct_update(QnAVO qnAVO,
									  RedirectAttributes redirectAttributes) {
		int retCode = service.directUpdate(qnAVO);
		if ( retCode > 0 ) 	redirectAttributes.addFlashAttribute("msgCode", "1");
		return new ModelAndView("redirect:/adm/QnA-mng");
	}
	
	
	@PostMapping(value = "/search_users")
	@ResponseBody
	public EgovMap search_users(@RequestParam(value = "keyword") String keyword) {
		EgovMap result = service.search_users(keyword);
		return result;
	}
	
	@RequestMapping(value = "/form", method = { RequestMethod.GET,RequestMethod.POST })
	public ModelAndView form(@RequestParam(value = "brd_idx") int brd_idx,
							 SearchConditionVO conditionVO) {
		UserDataVO userDataVO = (UserDataVO)ContextUtil.getAttrFromSession("userDataVO");
		EgovMap result = service.qnaDetail(brd_idx);
		return new ModelAndView("/admin/QnAMng_form")
				.addObject("result", result)
				.addObject("condition", conditionVO);
	}
	
	@PostMapping(value = "/detail")
	@ResponseBody
	public EgovMap detail(@RequestParam(value = "brd_idx") int brd_idx) {
		EgovMap result = service.qnaDetail(brd_idx);
		return result;
	}
	
	
	@PostMapping(value = "/search")
	@ResponseBody
	public EgovMap boardList(SearchConditionVO conditionVO) {
		EgovMap result = service.qnaList(conditionVO);
		return result;
	}
	

	@PostMapping(value = "/confirm")
	@ResponseBody
	public EgovMap confirm(QnAVO qnaVO) {
		
		EgovMap result = service.updateSts(qnaVO);
		return result;
	}
	
	@PostMapping(value = "/delete")
	@ResponseBody
	public EgovMap delete(QnAVO qnaVO) {
		EgovMap result = service.deleteQnA(qnaVO);
		return result;
	}
	
	
}
