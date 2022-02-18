package kr.co.pegsystem.common.mail;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import kr.co.pegsystem.admin.vo.MemberMngVO;

@Service("adminMemberMailSender")
public class AdminMemberMailSender {
	
	@Autowired private JavaMailSender javaMailSender;
	
	
	/**
	 * 계정 생성 후 생성된 계정 정보를 메일로 발송
	 * CST_ID 유무로 계정 생성과 비밀번호 초기화 구분
	 * @param memberMngVO
	 * @throws MessagingException
	 */
	public void sendMail(MemberMngVO memberMngVO) throws MessagingException {
		StringBuilder sb = new StringBuilder();
		
		String createType = "[피이지시스템] 연말정산 고객 홈페이지의 계정이 생성되었습니다.";
		String initType = "[피이지시스템] 연말정산 고객 홈페이지의 비밀번호가 초기화 되었습니다.";
		String cstId = memberMngVO.getCst_id();
		String usrId = memberMngVO.getUsr_id();
		String usrName = memberMngVO.getUsr_name();
		String recipient = memberMngVO.getUsr_email();
		String pass = memberMngVO.getEtc_05();	// 비밀번호
		
		String LINE_SPACE = "\n\n";
		sb.append(LINE_SPACE).append(LINE_SPACE);
		sb.append("1) 이름 : " + usrName);
		sb.append(LINE_SPACE);
		sb.append("2) 아이디 : " + usrId);
		sb.append(LINE_SPACE);
		sb.append("3) 비밀번호 : " + pass);
		
		MimeMessage message = javaMailSender.createMimeMessage(); 	// 메일 생성
		MimeMessageHelper helper = new MimeMessageHelper(message);
		helper.setTo(recipient);
		helper.setText(sb.toString());
		helper.setSubject(cstId == null ? initType : createType);
		javaMailSender.send(message);								// 메세지 전송
	}
	
}
