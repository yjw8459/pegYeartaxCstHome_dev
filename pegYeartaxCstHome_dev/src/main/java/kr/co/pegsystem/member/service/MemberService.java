package kr.co.pegsystem.member.service;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.admin.vo.MemberMngVO;

public interface MemberService {
	public EgovMap save(MemberMngVO memberMngVO);
}
