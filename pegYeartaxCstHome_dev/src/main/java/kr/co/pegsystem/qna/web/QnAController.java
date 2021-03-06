package kr.co.pegsystem.qna.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.common.vo.SearchConditionVO;
import kr.co.pegsystem.common.vo.UserDataVO;
import kr.co.pegsystem.qna.service.QnAService;
import kr.co.pegsystem.qna.vo.QnAVO;
import pegsystem.util.ContextUtil;

@Controller
@RequestMapping(value = "/qna")
public class QnAController {
	
	@Resource(name = "qnaService")private QnAService service;
	
	@GetMapping(value = "/list")
	public ModelAndView main(@RequestParam(value = "brd_cat", defaultValue = "") String brd_cat,
							 SearchConditionVO conditionVO) {
		EgovMap result = service.main(brd_cat);
		return new ModelAndView("/qna/qna")
					.addObject("result", result)
					.addObject("condition", conditionVO);
	}
	
	@PostMapping(value = "/search")
	@ResponseBody
	public EgovMap qnaList(SearchConditionVO conditionVO,
						   @RequestParam(value = "usr_cat") String usr_cat) {
		EgovMap result = service.qnaList(conditionVO, usr_cat);
		return result;
	}
	
	@PostMapping(value = "/content")
	public ModelAndView qnaContent(SearchConditionVO conditionVO) {
		EgovMap result = service.qnaDetail(conditionVO);
		return new ModelAndView("/qna/content")
				.addObject("result", result)
				.addObject("condition", conditionVO);
	}
	
	@PostMapping(value = "/form")
	public ModelAndView form(@RequestParam(value = "brd_code") String brd_code,
							 @RequestParam(value = "brd_idx") int brd_idx,
							 SearchConditionVO conditionVO) {
		UserDataVO user = (UserDataVO)ContextUtil.getAttrFromSession("userDataVO");
		EgovMap result = service.qnaForm(brd_code, brd_idx);
		return new ModelAndView("/qna/form")
				.addObject("result", result)
				.addObject("condition", conditionVO);
	}
	
	@PostMapping(value = "/save")
	public ModelAndView save(QnAVO qnaVO) {
		EgovMap result = service.save(qnaVO);
		String brd_cat = qnaVO.getBrd_cat();
		return new ModelAndView("redirect:/qna/list?brd_cat=" + brd_cat)
					.addObject("result", result);
	}
	
	@PostMapping(value = "/delete")
	@ResponseBody
	public EgovMap delete(QnAVO qnaVO) {
		EgovMap result = service.delete(qnaVO);
		return result;
	}
	
	@PostMapping(value = "/stsList")
	@ResponseBody
	public EgovMap stsList(@RequestParam(value = "brd_code") String brd_code,
						   @RequestParam(value = "brd_idx") int brd_idx) {
		EgovMap result = service.stsList(brd_code, brd_idx);
		return result;
	}

	
}
