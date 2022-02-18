package kr.co.pegsystem.core.util;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.lang.Nullable;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import kr.co.pegsystem.board.mapper.BoardMapper;
import kr.co.pegsystem.board.vo.BoardMstVO;
import kr.co.pegsystem.common.mapper.CommonMapper;
import pegsystem.util.StringUtil;

public class BoardCheckInterceptor implements HandlerInterceptor  {


	@Resource(name = "boardMapper") private BoardMapper boardMapper;
	@Resource(name="commonMapper") private CommonMapper commonMapper;
	
	
	

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String returnUrl = request.getContextPath() + "/cmmn/denied?wrk_cat=brd";
		
		String brd_code = StringUtil.isNull(request.getParameter("brd_code"));
		if("".equals(brd_code))  {
			String brd_cat = StringUtil.isNull(request.getParameter("brd_cat"));
			brd_code = commonMapper.findeByBrdCodeWithUrl(brd_cat);
		}
		
		BoardMstVO brdMst = commonMapper.findeByBrdCode(brd_code);
		if(brdMst == null) {
			response.sendRedirect(returnUrl);
			return false;
		}
		
		String useYn = brdMst.getUse_yn();
		if(!"Y".equals(useYn)) {
			response.sendRedirect(returnUrl);
			return false;
		}
		
		
		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable ModelAndView modelAndView) throws Exception {
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object object, @Nullable Exception arg3) throws Exception {
	}



}
