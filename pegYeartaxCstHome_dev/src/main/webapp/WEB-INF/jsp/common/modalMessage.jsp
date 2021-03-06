<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstl.jsp" %>


<script type="text/javascript">

function fn_modalClose(modal_id){
	let id = '#' + modal_id;
	if($(id).dialog('isOpen')) $(id).dialog('close');
}

</script>





<div class="loading"></div>



<!-- 
	게시판 관리 모달
 -->
<div id="dialog_boardForm" title="게시판 관리" style="display:none">
	<div class="tblMemberForm_dialog">
		<div class="mFormHeader"><div class="title">게시판 정보</div></div>
<form name="modal_board_form" id="modal_board_form">
	<input type="hidden" name="save_cat" />
	<input type="hidden" name="ent_uno" value="${userDataVO.usr_id }" />
	<input type="hidden" name="upd_uno" value="${userDataVO.usr_id }" />
	<input type="hidden" name="brd_code" id="modal_board_brd_code" class="notModify" />
		<table>
			<tr>
				<th>게시판 이름</th>
				<td><input type="text" name="brd_name" id="modal_board_brd_name" required="required" title="게시판 이름" /></td>
			</tr>
			<tr>
				<th>게시판 타입</th>
				<td>
					<select name="brd_type" id="modal_board_brd_type" required="required" title="게시판 타입"></select>
				</td>
			</tr>
			<tr>
				<th>리스트 사이즈</th>
				<td>
					<select name="page_size" id="modal_board_page_size" required="required" title="리스트 사이즈">
						<option value=""> 코드 선택 </option>
		<c:forEach begin="0" end="20" var="number" step="5">
			<c:if test="${number > 0 }">
						<option value="${number }">${number }</option>
			</c:if>
		</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>첨부파일 사용여부</th>
				<td>
					<select name="atc_yn" id="modal_board_atc_yn" required="required" title="첨부파일 사용여부">
						<option value=""> 코드 선택 </option>
						<option value="N">사용안함</option>
						<option value="Y">사용함</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>첨부파일 갯수</th>
				<td>
					<select name="atc_num" id="modal_board_atc_num">
		<c:forEach begin="1" end="5" var="number">
						<option value="${number }">${number }</option>
		</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>URL</th>
				<td>
					<input type="text" name="url" id="modal_board_url" class="notModify" required="required" title="URL" onchange="fn_dupCheckReset();" />
					<div class="btnCheck_item" title="ID 중복확인" onclick="fn_brdUrlDupCheck();">중복확인</div>
					<div id="modal_board_true" class="checking_Result true">※ 사용가능한 URL 입니다.</div>
					<div id="modal_board_false" class="checking_Result false">※ 이미 사용 중인 URL 입니다.</div>
				</td>
			</tr>
			<tr>
				<th>순번</th>
				<td>
					<input type="text" name="inq_ord" id="modal_board_inq_ord" required="required" title="순번" maxlength="2" onkeyup="fn_setInputOnlyNumber(this);" />
				</td>
			</tr>
		</table>
</form>
		<div class="btnFormSubmit" onclick="fn_boardMngSubmit();" >저장</div>
	</div>
</div>







<!-- 
	회원정보 관리 모달
 -->
<div id="dialog_memberForm" title="회원 관리" style="display:none">
	<div class="tblMemberForm_dialog">
		<div class="mFormHeader"><div class="title">회원 정보</div></div>
<form name="modal_member_form" id="modal_member_form">
	<input type="hidden" name="save_cat" />
	<input type="hidden" name="comp_name" id="modal_member_comp_name" />
	<input type="hidden" name="ent_uno" value="${userDataVO.usr_id }" />
	<input type="hidden" name="upd_uno" value="${userDataVO.usr_id }" />
		<table>
			<tr>
				<th>사업장</th>
				<td>
					<select name="cst_id" id="modal_member_cst_id" onchange="fn_setCompCode(this.value)" class="notModify"
						    required="required" title="고객사">
						<option value="">고객사 선택</option>
					</select>
					<select name="comp_code" id="modal_member_comp_code" onchange="fn_setCompName(this.value)"
							required="required" title="사업장">
						<option value="">사업장 선택</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>이메일(아이디)</th>
				<td>
					<input type="hidden" name="usr_id" id="modal_member_usr_id" class="notModify" />
					<input type="hidden" name="usr_email" id="modal_member_usr_email" required="required" title="아이디" class="notModify" />
					<input type="text" id="modal_member_email_temp01" class="notModify" />
					<div class="term">@</div>
					<input type="text" id="modal_member_email_temp02" class="notModify" style="width:134px" />
					<select id="modal_member_email_domain" class="email_Addr notModify" onchange="fn_setMemberEmail(this);">
						<option value=""> -직접입력- </option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="daum.net">daum.net</option>
						<option value="nate.com">nate.com</option>
					</select>
					<div class="btnCheck_item" title="ID 중복확인" onclick="fn_usrIdDupCheck();">중복확인</div>
					<div id="modal_member_false" class="checking_Result false">※ 이미 사용 중인 ID입니다.</div>
					<div id="modal_member_true" class="checking_Result true">※ 사용가능한 ID입니다.</div>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="usr_name" id="modal_member_usr_name" maxlength="10" required="required" title="이름" /></td>
			</tr>
			<tr>
				<th>사용자 구분</th>
				<td>
					<select name="usr_cat" id="modal_member_usr_cat" required="required" title="사용자 구분" onchange="fn_setUsrCat(this);"></select>
					
					<div class="checking_Result02">* 피이지시스템 직원용 계정만 관리자로 선택해주세요.</div>
				</td>
			</tr>
			<tr>
				<th>연락처(사무실)</th>
				<td>
					<input type="hidden" name="off_tel" id="modal_member_off_tel" />
					<input type="text" id="modal_member_off_tel01" class="num" maxlength="3" autocomplete="off" onkeyup="fn_setTelNumFocus(this, '#modal_member_off_tel02');" />
					<div class="term">-</div>
					<input type="text" id="modal_member_off_tel02" class="num" maxlength="4" autocomplete="off" onkeyup="fn_setTelNumFocus(this, '#modal_member_off_tel03');" />
					<div class="term">-</div>
					<input type="text" id="modal_member_off_tel03" class="num" maxlength="4" autocomplete="off" />
				</td>
			</tr>
			<tr>
				<th>연락처(휴대전화)</th>
				<td>
					<input type="hidden" name="usr_tel" id="modal_member_usr_tel" />
					<input type="text" id="modal_member_usr_tel01" class="num" maxlength="3" autocomplete="off" onkeyup="fn_setTelNumFocus(this, '#modal_member_usr_tel02');" />
					<div class="term">-</div>
					<input type="text" id="modal_member_usr_tel02" class="num" maxlength="4" autocomplete="off" onkeyup="fn_setTelNumFocus(this, '#modal_member_usr_tel03');" />
					<div class="term">-</div>
					<input type="text" id="modal_member_usr_tel03" class="num" maxlength="4" autocomplete="off" />
				</td>
			</tr>
			<tr>
				<th>부서 구분</th>
				<td>
					<select name="usr_dept" id="modal_member_usr_dept" required="required" title="부서 구분"></select>
				</td>
			</tr>
			<tr>
				<th>사용기한</th>
				<td>
					<input type="text" name="str_dt" id="modal_member_str_dt" class="num mask_date"
						   value="20210101" required="required" title="시작일" />
					<div class="term">~</div>
					<input type="text" name="end_dt" id="modal_member_end_dt" class="num mask_date"
						   value="20991231" required="required" title="종료일" />
				</td>
			</tr>
		</table>
</form>
		<div class="btnFormSubmit" onclick="fn_memberMngSubmit();">저장</div>
	</div>
</div>



<!-- DIALOG -->
<!--
 
id = modal_singUp_* 

-->
<div id="dialog_signUpForm" title="회원가입신청" style="display:none">
	
	<div class="tblMemberForm_dialog">
		<div class="mFormHeader"><div class="title">회원가입신청</div></div>
		<form id="modal_signUp_form" name="signUpForm">
		<table>
			<tr>
				<th>사업장</th>
				<td>
					<input type="text" id="modal_signUp_cstName" name="cst_name" class="required validate_1" value="" />
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" id="modal_signUp_usrName"  name="usr_name" class="required validate_1" value="" maxlength="10" /></td>
			</tr>
			<tr>
				<th>이메일(아이디)</th>
				<td class="modal_signUp_mailBox">
					<input type="text" id="modal_signUp_usrEmail1" class="required validate_1" onchange="fn_initEmailCheck();" />
					<div class="term">@</div>
					<input type="text" id="modal_signUp_usrEmail2" class="required" onchange="fn_initEmailCheck();" />
					<select id="modal_signUp_usrEmail_Opt" onchange="fn_changeEmailOpt(this);">
						<option value=""> -직접입력- </option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="daum.net">daum.net</option>
						<option value="nate.com">nate.com</option>
					</select>
					<input type="hidden" name="usr_email" id="modal_signUp_usrEmail">
					<div id="modal_signUp_email_auth" class="btnCheck_item" title="인증KEY발송" onclick="fn_emailAuthCheck();" style="display:none">KEY 발송</div>
					<div id="modal_signUp_chkBtn" class="btnCheck_item" title="ID 중복확인" onclick="fn_mailChk();">중복확인</div>
					<div id="modal_signUp_true" class="checking_Result true">※ 사용가능한 ID입니다.</div>
					<div id="modal_signUp_false" class="checking_Result false">※ 이미 사용 중인 ID입니다.</div>
				</td>
			</tr>
<!-- display:none -->
			<tr id="emailAuthKey" style="display:none">
				<th style="color:#2B7FEB">인증키 입력</th>
				<td>
					<input type="text" id="modal_signUp_email_auth_key" style="border:1px solid #2B7FEB" />
					<div id="modal_signUp_key_submit" class="btnCheck_item" title="인증확인" onclick="fn_compareEmailAuthKey();" style="display:none">인증 확인</div>
				</td>
			</tr>
			<tr>
				<th>연락처(사무실)</th>
				<td>
					<input type="text" id="modal_signUp_offTel1" value="" class="offTel num validate_1" maxlength="3" autocomplete="off" onkeyup="fn_setTelNumFocus(this, '#modal_signUp_offTel2');" />
					<div class="term">-</div>
					<input type="text" id="modal_signUp_offTel2" value="" class="offTel num validate_1" maxlength="4" autocomplete="off" onkeyup="fn_setTelNumFocus(this, '#modal_signUp_offTel3');" />
					<div class="term">-</div>
					<input type="text" id="modal_signUp_offTel3" value="" class="offTel num validate_1" maxlength="4" autocomplete="off" />
					<input type="hidden" name="off_tel" id="modal_signUp_offTel">
					<div id="modal_signUp_true" class="true" style="float:left;font-size:12px;margin:14px 0 0 9px;font-weight:bold;color:#F73434">※ 연락처 중 하나는 입력해야 합니다.</div>
				</td>
			</tr>
			<tr>
				<th>연락처(휴대전화)</th>
				<td>
					<input type="text" id="modal_signUp_usrTel1" value="" class="usrTel num validate_1" maxlength="3" autocomplete="off" onkeyup="fn_setTelNumFocus(this, '#modal_signUp_usrTel2');" />
					<div class="term">-</div>
					<input type="text" id="modal_signUp_usrTel2" value="" class="usrTel num validate_1" maxlength="4" autocomplete="off" onkeyup="fn_setTelNumFocus(this, '#modal_signUp_usrTel3');" />
					<div class="term">-</div>
					<input type="text" id="modal_signUp_usrTel3" value="" class="usrTel num validate_1" maxlength="4" autocomplete="off" />
					<input type="hidden" name="usr_tel" id="modal_signUp_usrTel">
				</td>
			</tr>
			<tr>
				<th>부서 구분</th>
				<td>
					<select name="usr_dept" id="modal_signUp_usrDept">
					</select>
				</td>
			</tr>
		</table>
		<input id="modal_signUp_overlap" type="hidden" value="N">
		</form>
		<div class="btnFormSubmit" onclick="fn_signUp();">신청</div>
	</div>
</div>


<!-- DIALOG -->
<!--
 
id = modal_sts_* 

-->
<div id="dialog_stsForm" title="진행상태" style="display: none;">
	<div class="tblMemberForm_dialog">
		<div class="mFormHeader"><div class="title">Q＆A 진행상태</div></div>
		<table id="modal_sts_table" class="qnaDetail">
			<tbody>
			</tbody>
		</table>
		<div class="btnFormSubmit" onclick="fn_modalClose('dialog_stsForm');">닫기</div>
	</div>
</div>








<!-- 
	비밀번호 초기화 모달
 -->
<div id="dialog_initPassword" title="비밀번호 초기화" style="display: none;">
	<div class="tblMemberForm_dialog">
	<div class="mFormHeader"><div class="title">비밀번호 초기화</div></div>
<form name="modal_initPassword_form" id="modal_initPassword_form">
	<input type="hidden" name="usr_id" id="modal_initPwd_usr_email">
		<table>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" name="usr_name" id="modal_initPwd_usr_name" />
				</td>
			</tr>
			<tr>
				<th>아이디(이메일)</th>
				<td class="modal_signUp_mailBox">
					<input type="text" id="modal_initPwd_usr_email01" />
					<div class="term">@</div>
					<input type="text" id="modal_initPwd_usr_email02" />
					<select id="modal_initPwd_usr_email03" onchange="fn_setEmailDoamin(this);">
						<option value=""> -직접입력- </option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="daum.net">daum.net</option>
						<option value="nate.com">nate.com</option>
					</select>
				</td>
			</tr>
		</table>
</form>
		<div class="btnFormSubmit" onclick="fn_initPassword();">초기화</div>
	</div>
</div>









<!-- 
	회원정보 변경 모달
 -->
<div id="dialog_memberModifyForm" title="회원정보 변경" style="display: none;">
	<div class="tblMemberForm_dialog">
		<div class="mFormHeader"><div class="title">회원 정보</div></div>
<form name="modal_member_modify_form" id="modal_member_modify_form">
	<input type="hidden" name="save_cat" value="update" />
	<input type="hidden" name="usr_id" value="${userDataVO.usr_id }" />
	<input type="hidden" name="ent_uno" value="${userDataVO.usr_id }" />
	<input type="hidden" name="upd_uno" value="${userDataVO.usr_id }" />
		<table>
			<tr>
				<th>이름</th>
				<td><input type="text" name="usr_name" id="modal_member_modify_usr_name" maxlength="10" required="required" title="이름" /></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="usr_pwd" id="modal_member_modify_usr_pwd" maxlength="20" /></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" id="modal_member_modify_usr_pwd_recheck" maxlength="20" /></td>
			</tr>
			<tr>
				<th>연락처(사무실)</th>
				<td>
					<input type="hidden" name="off_tel" id="modal_member_modify_off_tel" />
					<input type="text" id="modal_member_modify_off_tel01" class="num" maxlength="3" autocomplete="off" onkeyup="fn_setTelNumFocus(this, '#modal_member_modify_off_tel02');" />
					<div class="term">-</div>
					<input type="text" id="modal_member_modify_off_tel02" class="num" maxlength="4" autocomplete="off" onkeyup="fn_setTelNumFocus(this, '#modal_member_modify_off_tel03');" />
					<div class="term">-</div>
					<input type="text" id="modal_member_modify_off_tel03" class="num" maxlength="4" autocomplete="off" />
				</td>
			</tr>
			<tr>
				<th>연락처(휴대전화)</th>
				<td>
					<input type="hidden" name="usr_tel" id="modal_member_modify_usr_tel" />
					<input type="text" id="modal_member_modify_usr_tel01" class="num" maxlength="3" autocomplete="off" onkeyup="fn_setTelNumFocus(this, '#modal_member_modify_usr_tel02');" />
					<div class="term">-</div>
					<input type="text" id="modal_member_modify_usr_tel02" class="num" maxlength="4" autocomplete="off" onkeyup="fn_setTelNumFocus(this, '#modal_member_modify_usr_tel03');" />
					<div class="term">-</div>
					<input type="text" id="modal_member_modify_usr_tel03" class="num" maxlength="4" autocomplete="off" />
				</td>
			</tr>
		</table>
</form>
		<div class="btnFormSubmit" onclick="fn_memberModifySubmit();">변경</div>
	</div>
</div>







<!-- DIALOG -->
<!--
 
id = modal_findUser_* 

-->
<div id="dialog_findUserForm" title="회원 찾기" style="display:none">
	
	<div class="tblMemberForm_dialog">
		<div class="mFormHeader"><div class="title">회원 찾기</div></div>
		<form id="modal_findUser_form" name="findUserForm" onsubmit="return false;">
		<table>
			<tr>
				<th>통합 검색</th>
				<td colspan="2">
					<input type="text" id="modal_findUser_keyword" name="keyword" class="keyword" onkeypress="javascript:if(event.keyCode==13){fn_findUser();}">
				</td>
				<td>
					<div onclick="fn_findUser();" >검색</div>
				</td>
			</tr>
			
<!-- 			<tr>
				<th>고객사</th>
				<td>
					<select id="modal_findUser_cstName">
						
					</select>
				</td>
			</tr>
			<tr>
				<th>사업장</th>
				<td>
					<select id="modal_findUser_compName" disabled="disabled">
					</select>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<select id="modal_findUser_usrName" disabled="disabled">
					</select>
				</td>
			</tr> -->
		</table>
		<table id="modal_findUser_table">
			<thead>
				<tr>
					<th>고객사</th>
					<th>사업장</th>
					<th>이름</th>
				<tr>
			</thead>
			<tbody>
						
			</tbody>
		</table>
		</form>
		<div class="btnFormSubmit" onclick="fn_modalClose('dialog_findUserForm');">닫기</div>
	</div>
</div>



















