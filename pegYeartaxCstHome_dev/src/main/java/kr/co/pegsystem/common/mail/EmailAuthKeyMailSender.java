package kr.co.pegsystem.common.mail;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service("emailAuthKeyMailSender")
public class EmailAuthKeyMailSender {
	
	@Autowired private JavaMailSender javaMailSender;
	
	
	/**
	 * 이메일 인증용 key 발송
	 * @param email
	 * @param key
	 * @throws MessagingException
	 */
	public void sendMail(String email, String key) throws MessagingException {
		String subject = "[피이지시스템] 연말정산 고객 홈페이지 가입 신청 확인.";
		String LINE_SPACE = "\n\n";
		StringBuilder sb = new StringBuilder();
		sb.append(LINE_SPACE).append(LINE_SPACE);
		sb.append("KEY : " + key);
		
		MimeMessage message = javaMailSender.createMimeMessage(); 	// 메일 생성
		MimeMessageHelper helper = new MimeMessageHelper(message);
		helper.setTo(email);
		helper.setText(sb.toString());
		helper.setSubject(subject);
		javaMailSender.send(message);								// 메세지 전송
	}
	
}
