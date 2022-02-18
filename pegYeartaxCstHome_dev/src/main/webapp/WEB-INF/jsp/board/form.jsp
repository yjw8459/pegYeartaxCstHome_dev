<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstl.jsp" %>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<link type="text/css" rel="stylesheet" href="${contextPath }/resources/css/basic.css" />
<link type="text/css" rel="stylesheet" href="${contextPath }/resources/css/yeartaxhelp.css" />
<link type="text/css" rel="stylesheet" href="${contextPath }/resources/css/jquery-ui.css" />
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/jquery-ui.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/common.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/ajaxUtil.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/messageUtil.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/dist/js/service/HuskyEZCreator.js"></script>
<title>PEGSYSTEM</title>
<script type="text/javascript">
$(document).ready(function() {
	// window resize
	resizeContent();
	$(window).resize(function() { resizeContent(); });
	
	
    $("#boardEditForm").on("submit", function() {
        $(window).off("beforeunload");
    });
});


function fn_cancelFile(idx) {
	let type = fn_browserCheck();
	if(type == 'ie') {
		$('#attachFileInput_'+idx).replaceWith( $('#attachFileInput_'+idx).clone(true) );
	} else {
		$('#attachFileInput_'+idx).val('');
	}
}


function fn_deleteFile(brd_code, brd_idx, file_idx) {
}


function fn_preCheck(target) {
	let result = true;
	$(target).each(function() {
		if(result) {
			let isRequired = $(this).prop('required');
			if(isRequired) {
				var tagName = fn_htmlTagCheck(this);
				if(tagName == 'textarea') {
					oEditors.getById["contentBox"].exec("UPDATE_CONTENTS_FIELD", []);
					let value = $(this).val();
			        if(value == null || value == '' || value == '&nbsp;' || value == '<p>&nbsp;</p>' || value == '<p><br></p>')  {
			             alert("내용을 입력하세요.");
			             oEditors.getById["contentBox"].exec("FOCUS"); //포커싱
			             result = false;
			        }
				} else {
					let value = $(this).val();
					if(value == '') {
						var title = $(this).attr('title');
						alert(title + '은 필수입력 항목 입니다.');
						$(this).focus();
						result = false;
					}
				}
			}
		}
	})
	return result;
}


function fn_save() {
	if(fn_preCheck('#boardEditForm input, #boardEditForm textarea')) {
		oEditors.getById["contentBox"].exec("UPDATE_CONTENTS_FIELD", []);
		let f = document.boardEditForm;
		let idx = f.brd_idx.value;
		if ( idx == '' ) 	f.brd_idx.value = 0;
		f.method = 'post';
		f.action = fn_getContextPath() + '/brd/save';
		f.submit();
	}
}


function fn_cancel() {
	if(confirm("작성을 취소하시겠습니까?")) {
		history.back();
	}
}
</script>
</head>
<body class="yeartaxHelp_main">


<c:set value="${result.brdMst }" var="brdMst" />		
<c:set value="${result.data }" var="data" />
<c:set value="${result.orderInfo }" var="orderInfo" />








	<div class="mainWrap">
	
		<div class="header">
			<div class="userFr">
				<div class="userArea">${userDataVO.usr_id }(${userDataVO.usr_name })</div>
				<div class="userInfoArea">
					<div class="userInfo" onclick="fn_modifyUserData();">회원정보변경</div>
					<div class="userInfo" onclick="fn_logout();">로그아웃</div>
				</div>
			</div>
		</div>
		<div class="contentsWrap">

			
			<div class="contents">
				
				<div class="cntHeader">
					<div class="title">${brdMst.brd_name }</div>
				</div>
				
				<div class="cntBody">
					<div class="tblWrap">
<form name="boardEditForm" id="boardEditForm" enctype="multipart/form-data">
	<input type="hidden" name="save_cat" value="${data.brd_code eq null ? 'insert' : 'update' }" />
	<input type="hidden" name="brd_code" value="${brdMst.brd_code }">
	<input type="hidden" name="brd_idx" value="${data.brd_idx }">
	<input type="hidden" name="brd_group" value="${data.brd_group }" />
	<input type="hidden" name="brd_step" value="${data.brd_step }" />
	<input type="hidden" name="brd_lvl" value="${data.brd_level }" />
	<input type="hidden" name="ent_uno" value="${userDataVO.usr_id }">
	<input type="hidden" name="upd_uno" value="${userDataVO.usr_id }">
	<input type="hidden" name="brd_cat" value="${brdMst.url }" />
	<input type="hidden" name="parent_no" value="${result.parentNo }" />
						<table class="tbl_write qna">
							<tr>
								<th>업무구분</th>
								<td>
									<select name="wrk_cat" id="wrk_cat">
<c:forEach items="${result.c001 }" var="code" varStatus="i">
	<c:if test="${fn:substring(userDataVO.comp_role, i.index, i.index + 1) eq 'Y' }">
										<option value="${code.cd }" <c:if test="${data.wrk_cat eq code.cd }">selected="selected"</c:if>>${code.cd_nm }</option>
	</c:if>
</c:forEach>
									</select>
								</td>
								<th>질문구분</th>
								<td>
									<select name="qst_cat" id="qst_cat">
<c:forEach items="${result.c002 }" var="code">
										<option value="${code.cd }" <c:if test="${data.qst_cat eq code.cd }">selected="selected"</c:if>>${code.cd_nm }</option>
</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th>정산년도</th>
								<td colspan="3">
									<select name="sac_yy" id="sac_yy">
<c:forEach items="${result.c007 }" var="code">
										<option value="${code.cd }" <c:if test="${data.sac_yy eq code.cd }">selected="selected"</c:if>>${code.cd_nm }</option>
</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th>공지사항</th>
								<td colspan="3">
									<input type="radio" name="ntc_yn" id="nyc_yn_y" value="Y" />
									<label for="ntc_yn_y">예</label>
									<input type="radio" name="ntc_yn" id="ntc_yn_n" value="N" checked="checked" />
									<label for="ntc_yn_n">아니요</label>
								</td>
							</tr>
							<tr>
								<th>제목</th>
								<td colspan="3">
									<input type="text" name="subject" id="subject" class="form_write" value="${data.subject }"
										   required="required" title="제목" />
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td colspan="3" class="textarea">
									<textarea name="content" id="contentBox" class="write_textarea" required="required" title="내용">${data.content }</textarea>
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
<c:if test="${brdMst.atc_yn eq 'Y' }">
							<tr>
								<th>첨부파일</th>
								<td colspan="3" class="inFileCase">



									
	<c:choose>
		<c:when test="${result.attachFiles eq null or fn:length(result.attachFiles) < 1 }">
									<div id="attachFilesArea">
			<c:forEach begin="1" end="${brdMst.atc_num }" varStatus="i">
										<div class="fileBox">
											<input type="file" name="attachFiles" id="attachFileInput_${i.count }" />
											<button type="button" class="btnFileDel" onclick="fn_cancelFile(${i.count });">삭제</button>
										</div>
			</c:forEach>
									</div>
		</c:when>
		<c:otherwise>
									<div class="savedFileList">
			<c:forEach items="${result.attachFiles }" var="attachFile" varStatus="i">									
										<div id="" class="filename">
											<div class="fl">${attachFile.org_name }</div>
											<button type="button" class="del_savedFile" onclick="fn_deleteFile('${attachFile.brd_code }', '${attachFile.brd_idx }', '${attachFile.file_idx }');">삭제</button>
										</div>
			</c:forEach>
									</div>
		</c:otherwise>
	</c:choose>
									
	
	
	
<%-- 	<c:forEach begin="1" end="${brdMst.atc_num }" varStatus="i"> --%>
<%-- 									<input type="file" name="attachFiles" id="attachFileInput_${i.count }" /> --%>
<%-- 									<button type="button" onclick="fn_cancelFile(${i.count });">X</button> --%>
<%-- 	</c:forEach> --%>
								</td>
							</tr>
</c:if>
						</table>
</form>
					</div>
					<div class="tblBtnArea writeForm">
						<div class="btnWriteBasic" onclick="fn_save();">저장</div>
						<div class="btnWriteBasic" onclick="fn_cancel();">취소</div>
					</div>
				</div>
				
				
			</div>
		</div>
		
	</div>


</body>
</html>