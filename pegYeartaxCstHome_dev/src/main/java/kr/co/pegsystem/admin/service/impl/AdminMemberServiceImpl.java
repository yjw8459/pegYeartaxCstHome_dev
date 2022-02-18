package kr.co.pegsystem.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.PegWebConfigProperties;
import kr.co.pegsystem.admin.mapper.AdminMemberMapper;
import kr.co.pegsystem.admin.service.AdminMemberService;
import kr.co.pegsystem.admin.vo.CustomerDataVO;
import kr.co.pegsystem.admin.vo.MemberMngVO;
import kr.co.pegsystem.common.mail.AdminMemberMailSender;
import kr.co.pegsystem.common.service.CommonService;
import kr.co.pegsystem.common.vo.CommonVO;
import pegsystem.util.EncryptUtil;
import pegsystem.util.PagingUtil;
import pegsystem.util.StringUtil;

@Service("adminMemberService")
public class AdminMemberServiceImpl implements AdminMemberService{

	@Resource(name="commonService")	private CommonService commonService;
	@Resource(name="adminMemberMapper")	private AdminMemberMapper mapper;
	@Resource(name="pegWebConfigProperties") private PegWebConfigProperties props;
	@Resource(name="adminMemberMailSender") private AdminMemberMailSender adminMemberMailSender;	
	
	
	@Override
	public EgovMap memberMngList(String keyword, int page_num) {
		EgovMap result = new EgovMap();
		EgovMap pagingObject = getPagingObject(page_num);
		PagingUtil paging = (PagingUtil) pagingObject.get("paging");
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("keyword", keyword);
		param.put("str_num", pagingObject.get("strNum"));
		param.put("end_num", pagingObject.get("endNum"));
		List<MemberMngVO> list = mapper.findMemberMngListByKeyword(param);
		if(list != null && list.size() > 0) {
			MemberMngVO temp = list.get(0);
			paging.setTotalCount(temp.getTotal_count());
		}		
		
		result.put("list", list);
		result.put("paging", paging);
		return result;
	}
	
	
	@Override
	@Transactional
	public EgovMap updateUseYn(String cst_id, String comp_code, String usr_id, String use_yn) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		
		try {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("cst_id", cst_id);
			param.put("comp_code", comp_code);
			param.put("usr_id", usr_id);
			param.put("use_yn", use_yn);
			retCode = mapper.updateMemberUseYn(param);
		} catch(Exception e) {
			e.printStackTrace();
			retCode = -999;
			retMsg = e.getMessage();
		}
		
		result.put("retCode", retCode);
		result.put("retMsg", retMsg);
		return result;
	}
	
	
	@Override
	public EgovMap modalMemberForm(MemberMngVO memberMngVO) {
		EgovMap result = new EgovMap();
		
		List<CustomerDataVO> cstList = mapper.findCustomerMasterData();		// 거래처 마스터
		List<CommonVO> c005 = commonService.selectCommonCode("C005");	// 부서구분
		List<CommonVO> c006 = commonService.selectCommonCode("C006");	// 사용자구분
		MemberMngVO member = mapper.findMemberDataByCstIdAndCompCodeAndUsrId(memberMngVO);	// 사용자 정보
		
		result.put("cstList", cstList);
		result.put("c005", c005);
		result.put("c006", c006);
		result.put("member", member);
		return result;
	}
	
	
	@Override
	public EgovMap getCompCode(String cst_id) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		
		List<CustomerDataVO> compList = mapper.findCustomerDetailByCstId(cst_id);
		if(compList != null) retCode = compList.size();
		
		result.put("retCode", retCode);
		result.put("retCode", retMsg);
		result.put("compList", compList);
		return result;
	}
	
	@Override
	public EgovMap usrIdDupCheck(String usr_id) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		
		retCode = mapper.findUsrIdCountByUsrId(usr_id);
			
		result.put("retCode", retCode);
		result.put("retMsg", retMsg);
		return result;
	}
	
	
	@Override
	@Transactional
	public EgovMap save(MemberMngVO memberMngVO) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		
		try {
			String saveCat = memberMngVO.getSave_cat();
			if("insert".equals(saveCat)) {
				String newPass = StringUtil.makeRandomString(5);
				String hashed = EncryptUtil.getSHA256(newPass);
				memberMngVO.setUsr_pwd(hashed);
				mapper.insertP2yCstUsr(memberMngVO);
				
				// 이메일 발송
				memberMngVO.setEtc_05(newPass);
				adminMemberMailSender.sendMail(memberMngVO);
				retCode++;
			} else if("update".equals(saveCat)) {
				retCode = mapper.updateP2yCstUsr(memberMngVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
			retCode = -999;
			retMsg = e.getMessage();
		}
		
		result.put("retCode", retCode);
		result.put("retMsg", retMsg);
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	private EgovMap getPagingObject(int page_num) {
		EgovMap result = new EgovMap();
		int pageSize = props.getAdminPagingSize();
		int strNum = 0;
		int endNum = 0;
		if(page_num > 1) {
			strNum = (page_num - 1) * pageSize + 1;
			endNum = strNum + pageSize - 1;
		} else {
			strNum = 1;
			endNum = pageSize;
		}
		
		PagingUtil paging = new PagingUtil();
		paging.setPageNum(page_num);
		paging.setPageSize(pageSize);
		paging.setTotalCount(0);
		
		result.put("paging", paging);
		result.put("strNum", strNum);
		result.put("endNum", endNum);
		return result;
	}
	
	
	
	
	



}
