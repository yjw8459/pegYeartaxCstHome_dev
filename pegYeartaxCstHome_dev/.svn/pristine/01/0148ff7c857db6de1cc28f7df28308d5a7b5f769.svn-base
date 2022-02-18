package kr.co.pegsystem.member.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.admin.vo.MemberMngVO;
import kr.co.pegsystem.member.mapper.MemberMapper;
import kr.co.pegsystem.member.service.MemberService;
import pegsystem.util.EncryptUtil;
import pegsystem.util.StringUtil;

@Service("memberService")
public class MemberServiceImpl implements MemberService {

	
	@Resource(name="memberMapper") private MemberMapper mapper;

	
	
	
	@Override
	public EgovMap save(MemberMngVO memberMngVO) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";

		try {
			String usrPwd = StringUtil.isNull(memberMngVO.getUsr_pwd());
			if(!"".equals(usrPwd)) {
				String hashed = EncryptUtil.getSHA256(usrPwd);
				memberMngVO.setUsr_pwd(hashed);
			} else {
				memberMngVO.setUsr_pwd(null);
			}
			retCode = mapper.updateMemberData(memberMngVO);
		} catch(Exception e) {
			e.printStackTrace();
			retCode = -999;
			retMsg = e.getMessage();
		}
		
		result.put("retCode", retCode);
		result.put("retMsg", retMsg);
		return result;
	}
	
	
	
	
	
}
