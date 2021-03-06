<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstl.jsp" %>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<link type="text/css" rel="stylesheet" href="${contextPath }/resources/css/basic.css" />
<link type="text/css" rel="stylesheet" href="${contextPath }/resources/css/yeartaxhelp.css" />
<link type="text/css" rel="stylesheet" href="${contextPath }/resources/css/jquery-ui.css" />
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/jquery-ui.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/common.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/ajaxUtil.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/messageUtil.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/admin/QnAMng.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/dist/js/service/HuskyEZCreator.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/admin/common.js"></script>
<title>PEGSYSTEM</title>
<script type="text/javascript">
$(function(){
	// window resize
	resizeContent();
	$(window).resize(function() { resizeContent(); });
	
	//dialog 기초설정
	$( "#dialog_findUserForm" ).dialog({
		autoOpen: false,
		height: "auto",
		width: 1010,
		modal: true
	});
	
	fn_initProcessor();
});


function fn_save(){
	if(fn_savePre()) {
		let f = document.boardEditForm;
		const fAction = $('#brd_idx').val() > 0 ? '/adm/QnA-mng/direct_update' : '/adm/QnA-mng/direct_save';
		f.action = fAction;
		f.method = 'POST';
		f.submit();
	}
}


function fn_savePre() {
	
	let cst_id = $('#direct_cst_id').val();
	if(cst_id == '') {
		alert("고객사 코드가 존재하지 않습니다.\n고객사를 선택해주세요.");
		fn_openModalForm();
		return false;
	}
	
	let comp_code = $('#direct_comp_code').val();
	if(comp_code == '') {
		alert("사업장 코드가 존재하지 않습니다.\n사업장을 선택해주세요.");
		fn_openModalForm();
		return false;
	}
	
	let cust_name = $('#cust_name').val();
	if(cust_name == '') {
		alert("질문자 이름을 입력해주세요.");
		$('#cust_name').focus();
		return false;
	}
	
	let subject = $('#subject').val();
	if(subject == '') {
		alert("제목을 입력해주세요.");
		$('#subject').focus();
		return false;
	}
	
	if ( ! fn_isCheckedByName('wrk_cat') ) {
		alert('업무구분을 선택해주세요.');
		return false;
	}
	
	if ( ! fn_isCheckedByName('req_cat') ) {
		alert('문의방법을 선택해주세요.');
		return false;
	}
	
	oEditors.getById["contentBox"].exec("UPDATE_CONTENTS_FIELD", []);	// 질문
	let question = $('#contentBox').val();
	
	//질문 내용 입력되지 않았을 경우
	if(question == ""  || question == null || question == '&nbsp;' || question == '<p>&nbsp;</p>' || question == '<p><br></p>')  {
    alert("내용을 입력하세요.");
    oEditors.getById["contentBox"].exec("FOCUS"); //포커싱
    document.getElementsByName('lst_sts').forEach( (item) => item.value === '11' ? item.checked = true : null );
    return false;
	}	
//	else document.getElementsByName('lst_sts').forEach( (item) => item.value === '01' ? item.checked = true : null );
	
	oEditors.getById["contentBox2"].exec("UPDATE_CONTENTS_FIELD", []);	// 답변
	let answer = $('#contentBox2').val();
	
	//답변 내용이 입력 된 경우 
	if(!(answer == ""  || answer == null || answer == '&nbsp;' || answer == '<p>&nbsp;</p>' || answer == '<p><br></p>'))  {
		// 답변까지 작성되어 있으면 상태는 답변완료ㄲ 
		document.getElementsByName('lst_sts').forEach( (item) => item.value === '21' ? item.checked = true : null );
	}
	// 답변의 제목은 [ RE : 제목 ]
	let reSubject = 'RE : ' + subject;
	$('#reSubject').val(reSubject);
	return true; 
}


function fn_openModalForm(){
	$('#modal_findUser_form')[0].reset();
	$('#modal_findUser_table').css('display','none');
	$('#modal_findUser_table tbody').html('');
	$('#dialog_findUserForm').dialog("open");
}

function fn_findUser(){
	let keyword = $('#modal_findUser_keyword').val();
	if(keyword == '') {
		alert("검색어를 입력해주세요.");
		return;
	}
	let url = fn_getContextPath() + '/adm/QnA-mng/search_users';
	let data = { 'keyword' : keyword };
	fn_ajaxAyncPOST(url, data, fn_findUserCallback);
}

function fn_findUserCallback(data) {
	let users = data.users;
	if(users.length < 1) {
		alert("검색조건에 맞는 자료가 없습니다.");
		return;
	}
	let cst_id, cst_nm, comp_code, comp_name, usr_id, usr_name;
	let html = '';
	for (let i = 0; i < users.length; i++) {
		user = users[i];
		cst_id 	  = user.cst_id == null ? '' : user.cst_id;
		cst_nm	  = user.cst_nm == null ? '' : user.cst_nm;
		comp_code = user.comp_code == null ? '' : user.comp_code;
		comp_name = user.comp_name == null ? '' : user.comp_name;
		usr_id 	  = user.usr_id == null ? '' : user.usr_id;
		usr_name  = user.usr_name == null ? '' : user.usr_name;
		html += '<tr class="user_row">';
		html += '	<input type="hidden" class="cst_id" value="' + cst_id + '">';
		html += '	<input type="hidden" class="cst_name" value="' + cst_nm + '">';
		html += '	<input type="hidden" class="comp_code" value="' + comp_code + '">';
		html += '	<input type="hidden" class="comp_name" value="' + comp_name + '">';
		html += '	<input type="hidden" class="usr_id" value="' + usr_id + '">';
		html += '	<input type="hidden" class="usr_name" value="' + usr_name + '">';
		html += '	<td>'+cst_nm+'</td>';
		html += '	<td>'+comp_name+'</td>';
		html += '	<td>'+usr_name+'</td>';
		html += '</tr>';
	}
	$('#modal_findUser_table tbody').html(html);
	$('#modal_findUser_table').css('display', '');
	
	$('.user_row').on('dblclick',function(){
		fn_selectUser(this);
	});
}

function fn_selectUser(element){
	let cst_id 		= $(element).find('.cst_id').val();
	let cst_name 	= $(element).find('.cst_name').val();
	let comp_code = $(element).find('.comp_code').val();
	let comp_name = $(element).find('.comp_name').val();
	let usr_id 		= $(element).find('.usr_id').val();
	let usr_name 	= $(element).find('.usr_name').val();
	
	$('#direct_cst_id').val(cst_id);
	$('#direct_comp_code').val(comp_code);
	$('#direct_cust_id').val(usr_id);
	$('#cst_name').val(cst_name);		// 고객사
	$('#comp_name').val(comp_name);		// 사업장
	$('#cust_name').val(usr_name);		// 사용자
	
	fn_modalClose('dialog_findUserForm');
}


/**
 * 취소
 */
function fn_cancel() {
	location.href = fn_getContextPath() + '/adm/QnA-mng';
}

function fn_initProcessor(){
	document.getElementsByName('wrk_cat')[0].checked = true;
	document.getElementsByName('req_cat')[0].checked = true;
	document.getElementsByName('lst_sts')[0].checked = true;
}

</script>


</head>
<%@ include file="/WEB-INF/jsp/common/modalMessage.jsp" %>
<body class="yeartaxHelp_main">
	<div class="mainWrap">
		<!-- Header -->
		<div class="header">
			<div class="userFr">
				<div class="userArea">${sessionScope.userDataVO.usr_id }(${sessionScope.userDataVO.usr_name })</div>
				<div class="userInfoArea">
					<div class="userInfo" onclick="fn_modifyUserData();">회원정보변경</div>
					<div class="userInfo" onclick="fn_logout();">로그아웃</div>
				</div>
			</div>
		</div>
		<!-- Content -->
		<div class="contentsWrap">
			<%@ include file="/WEB-INF/jsp/common/left_menu.jsp" %>
			
			<div class="contents">
				<div class="cntHeader bgImg6">
					<div class="title">Q&amp;A</div>
					<!-- Button Group -->
					<div class="tblBtnArea writeForm">
						<div class="btnWriteBasic saveBtn" onclick="fn_save();">저장</div>
						<div class="btnWriteBasic cancelBtn" onclick="fn_cancel();">취소</div>
					</div>
				</div>
				<div class="cntBody">
				  <form id="boardEditForm" name="boardEditForm" enctype="multipart/form-data">
				      <input type="hidden" name="brd_code" value="${result.brdMst.brd_code }">
				      <input id="brd_idx" type="hidden" name="brd_idx" value="${detail.question.brd_idx eq null ? 0 : detail.question.brd_idx}">
				      <input type="hidden" name="ent_uno" value="${userDataVO.usr_id }">
				      <input id="direct_cst_id" 	name="cst_id" 		type="hidden" value="${detail.question.cst_id }">
				      <input id="direct_comp_code" 	name="comp_code" 	type="hidden" value="${detail.question.comp_code }">
				      <input id="direct_cust_id" 	name="cust_id" 		type="hidden" value="${detail.question.cust_id }">
					<!-- Question -->
					<div class="tblWrap">
						<table class="tbl_write qna">
							<tr>
								<th>업무구분</th>
								<td>
									<div id="wrk_cat">
                                        <c:forEach items="${result.c001 }" var="code" varStatus="i">
										  <input name="wrk_cat" type="radio" value="${code.cd }" ${detail.question.wrk_cat eq code.cd ? 'checked="checked"' : '' } >${code.cd_nm }
                                        </c:forEach>
									</div>
								</td>
								<th>질문구분</th>
								<td>
                                    <select name="qst_cat" id="qst_cat">
                                        <c:forEach items="${result.c002 }" var="code">
										<option value="${code.cd }" ${detail.question.qst_cat eq code.cd ? 'selected="selected"' : '' } >${code.cd_nm }</option>
                                        </c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th>정산년도</th>
								<td>
									<select name="sac_yy" id="sac_yy">
                                        <c:forEach items="${result.c007 }" var="code">
										  <option value="${code.cd }" ${detail.question.sac_yy eq code.cd ? 'selected="selected"' : '' } >${code.cd_nm }</option>
                                        </c:forEach>
									</select>
								</td>
								<th>문의방법</th>
								<td>
									<div id="req_cat">
                                        <c:forEach var="code" items="${result.c003 }">
										  <input name="req_cat" type="radio" value="${code.cd }" ${detail.question.req_cat eq code.cd ? 'checked="checked"' : '' } >${code.cd_nm }
                                        </c:forEach>
									</div>
								</td>
							</tr>
							<tr>
								<th>진행상태</th>
								<td>
									<div id="lst_sts">
<c:forEach var="code" items="${result.c004 }">
										<input name="lst_sts" type="radio" value="${code.cd }" ${detail.question.lst_sts eq code.cd ? 'checked="checked"' : '' } >${code.cd_nm }
</c:forEach>
									</div>
								</td>
								<th>질문자</th>
								<td>
									<input type="text" name="cust_name" id="cust_name" value="${detail.question.cust_name }" />
									<a class="searchIcon" onclick="fn_openModalForm();"></a>
								</td>
							</tr>
							<tr>
								<th>고객사</th>
								<td>
									<input type="text" name="cst_name" id="cst_name" value="${detail.question.cst_name }" readonly="readonly" />
									<a class="searchIcon" onclick="fn_openModalForm();"></a>
								</td>
								<th>사업장</th>
								<td>
									<input type="text" name="comp_name" id="comp_name" value="${detail.question.comp_name }" readonly="readonly" />
									<a class="searchIcon" onclick="fn_openModalForm();"></a>
								</td>
							</tr>
							<tr>
								<th>제목</th>
								<td colspan="3">
									<input type="text" name="subject" id="subject" class="form_write" value="${detail.question.subject }"
										   required="required" title="제목" onchange="$('#answer_title').text('RE : ' + $('#subject').val());" />
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td colspan="3" class="textarea">
									<textarea name="question" id="contentBox" class="write_textarea" required="required" title="내용">${detail.question.question }</textarea>
                                        <script type="text/javascript">
                                        var oEditors = [];
                                        nhn.husky.EZCreator.createInIFrame({
                                        oAppRef: oEditors,
                                        elPlaceHolder: "contentBox",
                                        sSkinURI: fn_getContextPath()+"/resources/js/dist/SmartEditor2Skin.html",
                                        fCreator: "createSEditor2"
                                        });
                                        </script>
								</td>
							</tr>
							 <c:if test="${result.answerFiles ne null and fn:length(result.answerFiles) > 0 }">
							  <tr>
								<th>첨부</th>
								<td colspan="6">
                                    <c:forEach items="${result.answerFiles }" var="attachFile">
										<div class="filename">
											<a href="/brd/download?brd_code=${attachFile.brd_code}&brd_idx=${attachFile.brd_idx}&file_idx=${attachFile.file_idx }">${attachFile.org_name }</a>
										</div>
                                    </c:forEach>
								</td>
						      </tr>
                            </c:if>
							  <tr>
								<th>첨부</th>
								<td colspan="6" class="inFileCase">
		<!-- 업로드한 파일 부분 -->
									<div class="savedFileList">
                                        <c:forEach var="file" items="${result.files }">
								          <div class="filename">
									        <div class="fl">
										       ${file.orgName }
									        </div>
									        <div class="del_savedFile" onclick="fn_fileDelete('${file.brdCode}', '${file.brdIdx }', '${file.fileIdx }');">
									     	삭제
									        </div></div>
                                        </c:forEach>
									</div>
		
		<!-- 업로드 부분 -->
									<div class="fileBox">
										<input type="file" name="attachFiles" class="" />
		<!-- 								<div class="btnFileDel">삭제</div> -->
										<button type="button" class="btnFileDel">삭제</button>
									</div>
									<div class="fileBox">
										<div class="memo">
											첨부한 파일의 전체 크기는 10Mbyte 미만이어야 합니다.<br>
											용량이 초과될 경우, 문의 접수가 원활하게 진행되지 않을 수 있습니다.<br>
											파일첨부는 JPG, GIF, PSD, TIF, MS Office 파일, 아래한글, PDF만 가능합니다.
										</div>
									</div>
								</td>
							</tr>
						</table>
					</div>
					
					
					<!-- Answer -->
					<div class="tblWrap answerWrap">
						<div class="answerHead">Answer</div>
						<!-- Button Group -->
						<div class="tblBtnArea writeForm">
							<div class="btnWriteBasic saveBtn2" onclick="fn_save();">저장</div>
							<div class="btnWriteBasic cancelBtn2" onclick="fn_cancel();">취소</div>
						</div>
						<table class="tbl_write qna">
							<tr>
								<th>제목</th>
								<td id="answer_title" colspan="3">
									RE : ${detail.question.subject }
								</td>
							</tr>
							<tr>
								<th>답변</th>
								<td colspan="3" class="textarea">
								${result.detail.question.answer }
								${result.detail.question.question }
									<textarea name="answer" id="contentBox2"  class="write_textarea" required="required" >${detail.question.answer }</textarea>
<script type="text/javascript">
	var oEditors2 = [];
	nhn.husky.EZCreator.createInIFrame({
	    	oAppRef: oEditors,
	        	elPlaceHolder: "contentBox2",
	            	sSkinURI: "${contextPath}/resources/js/dist/SmartEditor2Skin.html",
	                	fCreator: "createSEditor2"
	                        });
</script>
								</td>
							</tr>
                           
						</table>
					</div>
				  </form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
