package kr.co.pegsystem.admin.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Alias("qnaMngVO")
public class QnAMngVO {
	
	private String subject;
	private String content;
	
	
}
