package kr.co.pegsystem;

import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Configuration
@PropertySource("classpath:pegWebConfig.properties")
@Setter
@Getter
@ToString
public class PegWebConfigProperties {

	@Value("${attach.physical.path}")
	String filePhysicalPath;

    @Value("${sessionCheck.include.pattern}")
    private List<String> sessionCheckIncludePattern;
	
    @Value("${sessionCheck.exclude.pattern}")
    private List<String> sessionCheckExcludePattern;
    
    @Value("${adminCheck.include.pattern}")
    private List<String> adminCheckIncludePattern;
    
    @Value("${admin.paging.size}")
    private int adminPagingSize;
	
	
	
	
	
}