package kr.co.pegsystem.admin.service.impl;

import org.springframework.stereotype.Service;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.admin.mapper.AdminDistMapper;
import kr.co.pegsystem.admin.service.AdminDistService;
import lombok.RequiredArgsConstructor;

@Service("adminDistService")
@RequiredArgsConstructor
public class AdminDistServiceImpl implements AdminDistService{

	private final AdminDistMapper adminDistMapper;
	
	@Override
	public EgovMap list(String sac_yy) {
		EgovMap result = new EgovMap();
		result.put("list", adminDistMapper.selectDistList(sac_yy));
		return result;
	}
	
}
