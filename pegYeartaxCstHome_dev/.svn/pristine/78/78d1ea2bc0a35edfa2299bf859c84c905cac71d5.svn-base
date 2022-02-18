package kr.co.pegsystem.core.config;

import javax.annotation.Resource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import kr.co.pegsystem.PegWebConfigProperties;
import kr.co.pegsystem.core.util.AdminCheckInterceptor;
import kr.co.pegsystem.core.util.BoardCheckInterceptor;
import kr.co.pegsystem.core.util.SessionCheckInterceptor;

@Configuration
public class PegWebMvcConfigurer implements WebMvcConfigurer{

	
	@Resource PegWebConfigProperties pegProps;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(sessionCheckInterceptor()).addPathPatterns(pegProps.getSessionCheckIncludePattern()).excludePathPatterns(pegProps.getSessionCheckExcludePattern());
		registry.addInterceptor(adminCheckInterceptor()).addPathPatterns(pegProps.getAdminCheckIncludePattern()).excludePathPatterns();
		registry.addInterceptor(boardCheckInterceptor()).addPathPatterns("/brd/*").excludePathPatterns();
	}
	
	/**
	 * set welcome page
	 * index.jsp 
	 */
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("forward:/index.jsp");
	}
	

	
	
	
	
	
	
	@Bean
	public SessionCheckInterceptor sessionCheckInterceptor() {
		return new SessionCheckInterceptor();
	}
	
	@Bean
	public AdminCheckInterceptor adminCheckInterceptor() {
		return new AdminCheckInterceptor();
	}
	
	@Bean
	public BoardCheckInterceptor boardCheckInterceptor() {
		return new BoardCheckInterceptor();
	}


	@Bean
	public CommonsMultipartResolver multipartResolver() {
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
		multipartResolver.setDefaultEncoding("UTF-8");
		multipartResolver.setMaxUploadSizePerFile(5 * 1024 * 1024);
		return multipartResolver;
	}
	
}
