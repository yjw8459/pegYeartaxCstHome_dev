package kr.co.pegsystem.admin.web;


import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.admin.mapper.AdminDistMapper;
import kr.co.pegsystem.admin.service.AdminDistService;
import kr.co.pegsystem.common.vo.CommonCode;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping(value = "/adm/dist")
@RequiredArgsConstructor
public class AdminDistController {

	private final AdminDistService adminDistService;
	private final AdminDistMapper adminDistMapper; 
	
	@GetMapping
	public ModelAndView main() {
		return new ModelAndView("/admin/distribution")
				.addObject("sac_yy", adminDistMapper.selectSacYy(CommonCode.C007.toString()));
	}
	
	@PostMapping
	@ResponseBody
	public EgovMap list(@RequestParam(value = "sac_yy", defaultValue = "") String sac_yy) {
		EgovMap result = adminDistService.list(sac_yy);
		return result;
	}
	
	@PutMapping
	@ResponseBody
	public EgovMap save() {
		return null;
	}
	
}
