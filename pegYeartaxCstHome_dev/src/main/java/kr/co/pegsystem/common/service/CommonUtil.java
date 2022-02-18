package kr.co.pegsystem.common.service;

import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * 공통 유틸객체
 */
public class CommonUtil {

	public static EgovMap savePostProc(int count) {
		EgovMap result = new EgovMap();
		String msg = count > 0 ? "success" : "fail";
		result.put("result", msg);
		return result;
	}
	
}
