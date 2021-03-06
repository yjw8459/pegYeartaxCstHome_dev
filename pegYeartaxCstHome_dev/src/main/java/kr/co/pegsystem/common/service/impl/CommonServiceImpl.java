package kr.co.pegsystem.common.service.impl;

import java.io.File;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import kr.co.pegsystem.PegWebConfigProperties;
import kr.co.pegsystem.admin.vo.MemberMngVO;
import kr.co.pegsystem.board.vo.AttachFileVO;
import kr.co.pegsystem.board.vo.BoardMstVO;
import kr.co.pegsystem.common.mail.AdminMemberMailSender;
import kr.co.pegsystem.common.mail.EmailAuthKeyMailSender;
import kr.co.pegsystem.common.mapper.CommonMapper;
import kr.co.pegsystem.common.service.CommonService;
import kr.co.pegsystem.common.vo.Board;
import kr.co.pegsystem.common.vo.CommonVO;
import kr.co.pegsystem.common.vo.SignUpVO;
import kr.co.pegsystem.common.vo.UserDataVO;
import kr.co.pegsystem.core.util.MailHandler;
import kr.co.pegsystem.qna.vo.QnAVO;
import pegsystem.util.ContextUtil;
import pegsystem.util.DateUtil;
import pegsystem.util.EncryptUtil;
import pegsystem.util.FileUtil;
import pegsystem.util.IntegerUtil;
import pegsystem.util.PagingUtil;
import pegsystem.util.StringUtil;

@Service("commonService")
public class CommonServiceImpl implements CommonService {
	
	@Resource(name="commonMapper") private CommonMapper mapper;	
	@Resource(name = "mailHandler") private MailHandler mailHandler;
	
	@Resource(name="pegWebConfigProperties") private PegWebConfigProperties props;
	@Resource(name="adminMemberMailSender") private AdminMemberMailSender adminMemberMailSender;
	@Resource(name="emailAuthKeyMailSender") private EmailAuthKeyMailSender emailAuthKeyMailSender;
	
	
	
	/**
	 * 로그인 프로세스
	 */
	@Override
	public EgovMap loginAction(String user_id, String user_pwd) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		
		try {
			String hashed = EncryptUtil.getSHA256(user_pwd);
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("user_id", user_id);
			param.put("user_pwd", hashed);
			
			UserDataVO userDataVO = mapper.findByUserIdAndUserPwd(param);
			if(userDataVO != null) {
				List<BoardMstVO> menu = mapper.findByCstBrdMst();
				userDataVO.setMenu(menu);
				
				String use_yn = userDataVO.getUse_yn();
				if(!"Y".equals(use_yn)) {
					retCode = -2;
					retMsg = "계정이 비활성화되어 있습니다. 관리자에게 문의해 주세요.";
				}
			} else {
				retCode = -1;
				retMsg = "사용자 정보가 존재하지 않거나 비밀번호가 일치하지 않습니다.";
			}
			// 세션에 사용자 객체 추가
			ContextUtil.setAttrToSession("userDataVO", userDataVO);
		} catch(Exception e) {
			e.printStackTrace();
			retCode = -999;
			retMsg = e.getMessage();
		}
		
		result.put("retCode", retCode);
		result.put("retMsg", retMsg);
		return result;
	}
	
	
	/**
	 * 공통코드 조회
	 * (P2T_CD_D)
	 */
	@Override
	public List<CommonVO> selectCommonCode(String cd_id) {
		return mapper.findByCdId(cd_id);
	}
	
	/**
	 * QnA 공통코드 조회  
	 * @return
	 */
	@Override
	public EgovMap defaultQnASettings(String url){
		List<CommonVO> list = mapper.findAllByCdId();
		Map<String, List<CommonVO>> result = list.stream().collect(Collectors.groupingBy(CommonVO::getCd_id));
		return null;
	}

	/**
	 * 회원가입 신청 이메일 발송
	 */
	@Override
	public EgovMap signUpAction(SignUpVO signUpVO) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		try {
			mailHandler.sendMail(signUpVO);
			retMsg = "신청이 접수되었습니다.";
			retCode++;
		} catch (Exception e) {
			e.printStackTrace();
			retCode = -999;
			retMsg = e.getMessage();
		}
		
		result.put("retCode", retCode);
		result.put("retMsg", retMsg);
		return result;
	}

	
	/**
	 * 회원가입 신청 전 이메일 중복체크
	 * @return 
	 * 중복 retCode = 2
	 * 정상 retCode = 1
	 */
	@Override
	public EgovMap signUpMailChk(String mail) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		try {
			retCode = mapper.countByUsrEmail(mail);
			if ( retCode > 0 ) 	retCode = 2;		//중복된 아이디가 있으면 2
			else 				retCode = 1;
			
		} catch (Exception e) {
			e.printStackTrace();
			retCode = -999;
			retMsg = e.getMessage();
		}
		
		result.put("retCode", retCode);
		result.put("retMsg", retMsg);
		return result;
	}
	
	@Override
	public int insertSts(QnAVO qnaVO) {
		qnaVO.setSts_idx(mapper.findStsIdxBrdCodeAndBrdIdx(qnaVO));
		return mapper.insertSts(qnaVO);
	}
	
	@Override
	public void insertAttachFiles(List<MultipartFile> attachFiles, 
								  String brd_code, 
								  int brd_idx, 
								  String ent_uno)  throws Exception{
			if ( attachFiles != null ) {
				for (MultipartFile attachfile : attachFiles) {
					long size = attachfile.getSize();
					if ( size > 0 ) {
						AttachFileVO attachFileVO = setAttachFileVO(attachfile);
						attachFileVO.setBrd_code(brd_code);
						attachFileVO.setBrd_idx(brd_idx);
						attachFileVO.setEnt_uno(ent_uno);
						mapper.insertAttachFileData(attachFileVO);
					}
				}
			}
	}
	
	@Override
	public BoardMstVO findeByBrdCode(String brd_code) {
		return mapper.findeByBrdCode(brd_code);
	}
	
	@Override
	public String findeByBrdCodeWithUrl(String url) {
		return mapper.findeByBrdCodeWithUrl(url);
	}
	
	
	/**
	 * 첨부파일 저장 및 VO return
	 * @param attachFile
	 * @return
	 */
	public AttachFileVO setAttachFileVO(MultipartFile attachFile) {
		AttachFileVO attachFileVO = new AttachFileVO();
		
		try {
			String rootFolder = props.getFilePhysicalPath();	// d:\attach\test\
			String subFolder = DateUtil.getDate();
			
			// 폴더 생성
			FileUtil fileUtil = new FileUtil();
			fileUtil.makeTemploryFolder(rootFolder+subFolder);
			
			String orgFileName = attachFile.getOriginalFilename();
			String physicalName = UUID.randomUUID().toString().replace("-", "");
			long atcSize = attachFile.getSize();
			attachFileVO.setOrg_name(orgFileName);
			attachFileVO.setAtc_name(physicalName);
			attachFileVO.setAtc_path(subFolder);
			attachFileVO.setAtc_size(atcSize);
			
			File file = new File(rootFolder+subFolder, physicalName);
			attachFile.transferTo(file);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return attachFileVO;
	}
	
	
	@Override
	public void deleteFileData(Board board) throws Exception{
		List<AttachFileVO> attachFiles = mapper.findAttachFilesByBrdCodeAndBrdIdx(board);
		if ( attachFiles != null && !attachFiles.isEmpty() ) {
			for (AttachFileVO attachFile : attachFiles) {
				String rootFolder = props.getFilePhysicalPath();
				String subFolder = attachFile.getAtc_path();
				String  physicalName = attachFile.getAtc_name();
				File file = new File(rootFolder + subFolder, physicalName);
				if ( file.delete() ) {							//물리적인 파일을 먼저 삭제 후 데이터 지움
					mapper.deleteFileByBrdCodeAndBrdIdxAndFileIdx(attachFile);
				}
			}
		}
	}
	
	@Override
	public EgovMap getAttachFileData(String brd_code, int brd_idx, int file_idx, HttpServletRequest request) {
		EgovMap result = new EgovMap();
		File attachFile = null;
		String fileName = null;
		
		try {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("brd_code", brd_code);
			param.put("brd_idx", brd_idx);
			param.put("file_idx", file_idx);
			AttachFileVO attachFileVO = mapper.findAttachFilesByBrdCodeAndBrdIdxAndFileIdx(param);
			String folder = props.getFilePhysicalPath() + attachFileVO.getAtc_path();
			String physicalName = attachFileVO.getAtc_name();
			String orgName = attachFileVO.getOrg_name();
			attachFile = new File(folder, physicalName);
			
	        String userAgent = request.getHeader("User-Agent");
	        boolean ie = userAgent.contains("MSIE") || userAgent.contains("Trident");
	        if(ie) {
	        	orgName = URLEncoder.encode(orgName, "utf-8").replaceAll("\\+", "%20");
	        	fileName = "attachment; filename=" + orgName + ";";
	        } else {
	        	orgName = new String(orgName.getBytes("utf-8"), "iso-8859-1");
	        	fileName = "attachment; filename=\"" + orgName + "\";";
	        }
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		result.put("attachFile", attachFile);
		result.put("fileName", fileName);
		return result;
	}
	
	@Override
	public List<AttachFileVO> findAttachFilesByBrdCodeAndBrdIdx(Board board){
		return mapper.findAttachFilesByBrdCodeAndBrdIdx(board);
	}
	
	@Override
	public EgovMap fileDelete(String brd_code, int brd_idx, int file_idx) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		try {
			AttachFileVO attachFileVO = new AttachFileVO();
			attachFileVO.setBrd_code(brd_code);
			attachFileVO.setBrd_idx(brd_idx);
			attachFileVO.setFile_idx(file_idx);
			retCode = deleteFileByBrdCodeAndBrdIdxAndFileIdx(attachFileVO);
		} catch (Exception e) {
			e.printStackTrace();
			retCode = -999;
			retMsg = e.getMessage();
		}
		
		result.put("retCode", retCode);
		result.put("retMsg", retMsg);
		
		return result;
	}
	
	@Override
	public int deleteFileByBrdCodeAndBrdIdxAndFileIdx(AttachFileVO attachFileVO) {
		return mapper.deleteFileByBrdCodeAndBrdIdxAndFileIdx(attachFileVO);
	}
	
	
	/**
	 * 게시판 코드별 페이징 처리용 오브젝트 생성
	 * @param brd_code
	 * @param page_num
	 * @return
	 */
	@Override
	public EgovMap getPagingObject(String brd_code, int page_num) {
		EgovMap result = new EgovMap();
		BoardMstVO brdMst = findeByBrdCode(brd_code);
		int pageSize = IntegerUtil.isNull(brdMst.getPage_size());
		int strNum = 0;
		int endNum = 0;
		if(page_num > 1) {
			strNum = (page_num - 1) * pageSize + 1;
			endNum = strNum + pageSize - 1;
		} else {
			strNum = 1;
			endNum = pageSize;
		}
		
		PagingUtil paging = new PagingUtil();
		paging.setPageNum(page_num);
		paging.setPageSize(pageSize);
		paging.setTotalCount(0);
		
		result.put("paging", paging);
		result.put("strNum", strNum);
		result.put("endNum", endNum);
		return result;
	}
	
	
	@Override
	public EgovMap initPassword(MemberMngVO memberMngVO) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		
		try {
			int count = mapper.findUserCountByUsrIdAndUsrName(memberMngVO);
			if(count < 1) {
				retCode = -1;
				retMsg = "일치하는 사용자 정보가 없습니다.";
			} else if(count > 1) {
				retCode = -2;
				retMsg = "계정 정보 확인 중 오류가 발생했습니다.\n관리자에게 문의해주세요.("+count+")";
			} else {
				String newPass = StringUtil.makeRandomString(5);
				String hashed = EncryptUtil.getSHA256(newPass);
				memberMngVO.setUsr_pwd(hashed);
				retCode = mapper.updateUsrPwassword(memberMngVO);
				
				if(retCode > 0) {
					// 이메일 발송
					memberMngVO.setUsr_email(memberMngVO.getUsr_id());
					memberMngVO.setEtc_05(newPass);
					adminMemberMailSender.sendMail(memberMngVO);
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
			retCode = -999;
			retMsg = e.getMessage();
		}
		
		result.put("retCode", retCode);
		result.put("retMsg", retMsg);
		return result;
	}

	
	@Override
	public EgovMap createEmailAuthKey(String email, HttpSession session) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		
		try {
			String key = StringUtil.makeRandomString(10);
			emailAuthKeyMailSender.sendMail(email, key);
			session.setAttribute("emailAuthKey", key);
			retCode++;
		} catch(Exception e) {
			e.printStackTrace();
			retCode = -999;
			retMsg = e.getMessage();
		}
		
		result.put("retCode",retCode);
		result.put("retMsg", retMsg);
		return result;
	}
	
	
	@Override
	public EgovMap compareEmailAuthKey(String key, HttpSession session) {
		EgovMap result = new EgovMap();
		int retCode = 0;
		String retMsg = "";
		
		String authKey = StringUtil.isNull(session.getAttribute("emailAuthKey"));
		if("".equals(authKey)) {
			retCode = -1;
			retMsg = "인증키가 존재하지 않습니다.다시 시도해주세요.";
		} else {
			if(authKey.equals(key)) {
				retCode = 1;
				session.setAttribute("emailAuthKey", null);
			} else {
				retCode = -2;
				retMsg = "인증값이 일치하지 않습니다.";
			}
		}
		
		result.put("retCode", retCode);
		result.put("retMsg", retMsg);
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
