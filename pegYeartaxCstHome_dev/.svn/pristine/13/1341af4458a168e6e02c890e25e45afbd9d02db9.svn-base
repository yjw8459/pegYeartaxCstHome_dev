package kr.co.pegsystem.core.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.lang.Nullable;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import kr.co.pegsystem.common.vo.UserDataVO;
import pegsystem.util.ContextUtil;
import pegsystem.util.IntegerUtil;

public class AdminCheckInterceptor implements HandlerInterceptor  {



	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String returnUrl = request.getContextPath() + "/cmmn/denied?wrk_cat=adm";
		UserDataVO userDataVO = (UserDataVO) ContextUtil.getAttrFromSession("userDataVO");
		if(userDataVO == null) {
			// 로그인 객체가 없으면
			//response.sendRedirect(returnUrl);
			response.sendRedirect("/cmmn/login?msg=empty");
			return false;
		} else {
			// 관리자가 아니면
			int usrCat = IntegerUtil.isNull(userDataVO.getUsr_cat());
			if(usrCat < 90) {
				response.sendRedirect(returnUrl);
				return false;
			}
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
