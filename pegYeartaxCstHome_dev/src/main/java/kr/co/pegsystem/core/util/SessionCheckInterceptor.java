package kr.co.pegsystem.core.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.lang.Nullable;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import kr.co.pegsystem.common.vo.UserDataVO;
import pegsystem.util.ContextUtil;

public class SessionCheckInterceptor implements HandlerInterceptor  {



	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		UserDataVO userDataVO = (UserDataVO) ContextUtil.getAttrFromSession("userDataVO");
		if(userDataVO == null) {
			//response.sendRedirect("/cmmn/denied?wrk_cat=usr");
			response.sendRedirect("/cmmn/login?msg=empty");
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
