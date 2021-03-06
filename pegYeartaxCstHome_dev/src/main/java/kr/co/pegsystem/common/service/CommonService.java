package kr.co.pegsystem.common.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.admin.vo.MemberMngVO;
import kr.co.pegsystem.board.vo.AttachFileVO;
import kr.co.pegsystem.board.vo.BoardMstVO;
import kr.co.pegsystem.common.vo.Board;
import kr.co.pegsystem.common.vo.CommonVO;
import kr.co.pegsystem.common.vo.SignUpVO;
import kr.co.pegsystem.qna.vo.QnAVO;

public interface CommonService {
	public EgovMap loginAction(String user_id, String user_pwd);
	public List<CommonVO> selectCommonCode(String cd_id);
	public EgovMap defaultQnASettings(String url);
	public EgovMap signUpAction(SignUpVO signUpVO);
	public EgovMap signUpMailChk(String mail); 
	
	//메뉴
	public BoardMstVO findeByBrdCode(String brd_code);
	public String findeByBrdCodeWithUrl(String url);
	
	//STS
	public int insertSts(QnAVO qnaVO);
	
	//파일 관련
	public void insertAttachFiles(List<MultipartFile> attachFiles,  String brd_code, int brd_idx, String ent_uno) throws Exception;
	public void deleteFileData(Board board) throws Exception;
	public EgovMap getAttachFileData(String brd_code, int brd_idx, int file_idx, HttpServletRequest request);
	public List<AttachFileVO> findAttachFilesByBrdCodeAndBrdIdx(Board board);
	public EgovMap fileDelete(String brd_code, int brd_idx, int file_idx);
	public int deleteFileByBrdCodeAndBrdIdxAndFileIdx(AttachFileVO attachFileVO);
	
	//페이징처리
	public EgovMap getPagingObject(String brd_code, int page_num);
	
	// 비밀번호 초기화
	public EgovMap initPassword(MemberMngVO memberMngVO);
	
	// 이메일 인증
	public EgovMap createEmailAuthKey(String email, HttpSession session);
	public EgovMap compareEmailAuthKey(String key, HttpSession session);
}
