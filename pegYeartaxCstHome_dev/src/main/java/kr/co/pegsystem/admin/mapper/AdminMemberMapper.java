package kr.co.pegsystem.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.pegsystem.admin.vo.CustomerDataVO;
import kr.co.pegsystem.admin.vo.MemberMngVO;

@Mapper
public interface AdminMemberMapper {
	public List<MemberMngVO> findMemberMngListByKeyword(Map<String, Object> param);
	public int updateMemberUseYn(Map<String, Object> param);
	public List<CustomerDataVO> findCustomerMasterData();
	public MemberMngVO findMemberDataByCstIdAndCompCodeAndUsrId(MemberMngVO memberMngVO);
	public List<CustomerDataVO> findCustomerDetailByCstId(String cst_id);
	public int findUsrIdCountByUsrId(String usr_id);
	public void insertP2yCstUsr(MemberMngVO memberMngVO);
	public int updateP2yCstUsr(MemberMngVO memberMngVO);
}
