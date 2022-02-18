package kr.co.pegsystem.admin.mapper;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper
public interface AdminDistMapper {

	public String selectSacYy(String sac_yy);
	public List<EgovMap> selectDistList(String sac_yy);
	
}
