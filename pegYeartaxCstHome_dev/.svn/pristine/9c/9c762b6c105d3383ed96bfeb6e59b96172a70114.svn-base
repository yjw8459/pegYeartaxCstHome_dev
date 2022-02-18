package kr.co.pegsystem.core.util;

import java.text.SimpleDateFormat;
import java.util.Date;


import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;


import kr.co.pegsystem.common.vo.SignUpVO;

@Service("mailHandler")
public class MailHandler {
	
	//spring-boot를 사용하면 JavaMailSender Bean을 생성할 필요없이, 자동으로 생성됨
	@Autowired
	JavaMailSender javaMailSender;
	
	public void sendMail(SignUpVO signUpVO) throws MessagingException{
		String mailContents = ""; 
		String cstName 	= signUpVO.getCst_name();
		String offTel 	= signUpVO.getOff_tel();
		String usrEmail = signUpVO.getUsr_email();
		String usrName 	= signUpVO.getUsr_name();
		String usrTel 	= signUpVO.getUsr_tel();
		String usrDept 	= signUpVO.getUsr_dept();
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		String date = format.format(new Date());
		
		if ( "01".equals(usrDept) ) 			usrDept = "현업";
		else if ( "02".equals(usrDept) ) 		usrDept = "전산";
		if ( "".equals(usrTel) ) 				usrTel = "미기입";
		else if ( "".equals(offTel) ) 			offTel = "미기입";
		
		String LINE_SPACE = "\n\n";
		mailContents += LINE_SPACE + LINE_SPACE;
		mailContents += "1) 사업장 : "			+ cstName;
		mailContents += LINE_SPACE;
		mailContents += "2) 이름 : "			+ usrName;
		mailContents += LINE_SPACE;
		mailContents += "3) 연락처(휴대전화) :"			+ usrTel;
		mailContents += LINE_SPACE;
		mailContents += "4) 연락처(사무실) :"	+ offTel;
		mailContents += LINE_SPACE;
		mailContents += "5) 이메일 :"			+ usrEmail;
		mailContents += LINE_SPACE;
		mailContents += "6) 담당부서 :"			+ usrDept;
		mailContents += LINE_SPACE + LINE_SPACE;
		mailContents += "신청일시 : " + date;
		
		MimeMessage message = javaMailSender.createMimeMessage(); 	// 메일 생성
		MimeMessageHelper helper = new MimeMessageHelper(message);
		helper.setTo("support@pegsystem.co.kr");
		helper.setSubject("연말정산 홈페이지 계정 추가 요청");
		helper.setText(mailContents);
		javaMailSender.send(message);								// 메세지 전송
	}
	
}
