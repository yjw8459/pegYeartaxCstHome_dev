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
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/qna_common.js"></script>
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

function fn_save(){
	let result = confirm("문의 접수신청 하시겠습니까?");
	if (result) {
		oEditors.getById["contentBox"].exec("UPDATE_CONTENTS_FIELD", []);
		result = fn_preProcessing();
		console.log(result);
		if ( result ) {
			//fn_initShrValue();
			let f = document.boardEditForm;
			f.action = '/qna/save';
			f.method = 'POST';
			f.submit();
		}
	} 
}

function fn_saveCallback(data){
	let retCode = data.retCode;
	if ( retCode > 0 ) {
		let f = document.conditionForm;
		f.action = fn_getContextPath() + '/qna/list';
		f.submit();
	}
					
}

//DEL_YN
function fn_deleteFile(brd_code, brd_idx, file_idx){
	let url = fn_getContextPath() + '/cmmn/file_del';
	let data = {
			'brd_code' : brd_code,
			'brd_idx' : brd_idx,
			'file_idx' : file_idx
	};
	fn_ajaxPOST(url, data, fn_callBack);
	
	function fn_callBack(data){
		let retCode = data.retCode;
		if ( retCode > 0 ) 	{
			alert('삭제되었습니다.');
			location.reload();
		}
		else 				alert(data.retMsg);
		
	}
}

function fn_list(brd_cat){
	let f = document.conditionForm;
	f.action = fn_getContextPath() + '/qna/list';
	f.submit();
}

function fn_cancelFile(idx){
	$('#attachFileInput_' + idx).val('');
}

function fn_preProcessing(){
	let subject = $('#subject').val();
	let content = $('#contentBox').val();
	if ( '' == subject ) 
	{
		alert('문의 제목을 입력해주세요.');
		$('#subject').focus();
		return false;
	}
/* 	else if ( '' == content ) {
		alert('내용을 입력해주세요.');
		$('#contentBox').focus();
		return false;
	} */
	return true;	
}


</script>
</head>
<body class="yeartaxHelp_main">

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
				
				<div class="cntHeader bgImg2">
					<div class="title">${brdMst.brd_name }</div>
					
					<div class="tblBtnTop">
						<div class="btnBasic list" onclick="fn_list('${result.brdMst.url }');">목록보기</div>
					</div>
				</div>
				
				<div class="cntBody">
					<div class="tblWrap">
<form name="conditionForm">
	<input type="hidden" name="brd_cat" value="${result.brdMst.url }">
	<!-- 검색 조건 유지  -->
	<input type="hidden" name="sac_yy" value="${condition.sac_yy }">
	<input type="hidden" name="wrk_cat" value="${condition.wrk_cat }">
	<input type="hidden" name="qst_cat" value="${condition.qst_cat }">
	<input type="hidden" name="lst_sts" value="${condition.lst_sts }">
	<input type="hidden" name="shr_yn" value="${condition.shr_yn }">
	<input type="hidden" name="keyword" value="${condition.keyword }">
	<input type="hidden" name="page_num" value="${condition.page_num }">
	<!-- 검색 조건 유지  -->
</form>
<form name="boardEditForm" id="boardEditForm" enctype="multipart/form-data">
	<input type="hidden" name="brd_cat" 	value="${result.brdMst.url }">
	<input type="hidden" name="brd_code" 	value="${result.brdMst.brd_code }">
	<input type="hidden" name="brd_idx" 	value="${result.brdIdx }">
	<input type="hidden" name="ent_uno" 	value="${userDataVO.usr_id }">
	<input type="hidden" name="upd_uno" 	value="${userDataVO.usr_id }">
	<input type="hidden" name="cust_id" 	value="${userDataVO.usr_id }">
	<input type="hidden" name="comp_code" value="${userDataVO.comp_code }">
	<input type="hidden" name="cst_id" 		value="${userDataVO.cst_id }">
					
						<table class="tbl_write qna">
							<tr>
								<th>업무구분</th>
								<td>
									<div id="wrk_cat">
                                        <c:forEach items="${result.c001 }" var="code" varStatus="i">
										  <input name="wrk_cat" type="radio" value="${code.cd }" ${ i.index == 0 ? 'checked="checked"' : ''} >${code.cd_nm }
                                        </c:forEach>
									</div>
								</td>
								<th>질문구분</th>
								<td>
                                    <select name="qst_cat" id="qst_cat">
                                        <c:forEach items="${result.c002 }" var="code">
										<option value="${code.cd }" >${code.cd_nm }</option>
                                        </c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th>정산년도</th>
								<td>
									<select name="sac_yy" id="sac_yy">
                                        <c:forEach items="${result.c007 }" var="code">
										  <option value="${code.cd }" >${code.cd_nm }</option>
                                        </c:forEach>
									</select>
								</td>
								<th>질문자</th>
								<td>
									<input type="text" name="cust_name" id="cust_name" value="${userDataVO.usr_name }" />
									<a class="searchIcon" onclick="fn_openModalForm();"></a>
								</td>
							</tr>
							<tr>
								<th>고객사</th>
								<td>
									<input type="text" name="cst_name" id="cst_name" value="${userDataVO.cst_name }" readonly="readonly" />
									<a class="searchIcon" onclick="fn_openModalForm();"></a>
								</td>
								<th>사업장</th>
								<td>
									<input type="text" name="comp_name" id="comp_name" value="${userDataVO.comp_name }" readonly="readonly" />
									<a class="searchIcon" onclick="fn_openModalForm();"></a>
								</td>
							</tr>
							<tr>
								<th>공유여부</th>
								<td>
									<input type="checkbox" value="Y" class="onlyMyBrd" onchange="fn_checkedDetecting(this, '#shr_yn')" >
									<input id="shr_yn" name="shr_yn" type="hidden" value="N" >
								</td>
							</tr>
							<tr>
								<th>제목</th>
								<td colspan="3">
									<input type="text" name="subject" id="subject" class="form_write" value="" required="required" title="제목" />
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td colspan="3" class="textarea">
									<textarea name="question" id="contentBox" class="write_textarea" required="required" title="내용"></textarea>
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
<c:if test="${result.brdMst.atc_yn eq 'Y' }">
							<tr>
								<th>첨부파일</th>
								<td colspan="3" class="inFileCase">
	<c:choose>
	
		<c:when test="${result.attachFiles eq null or fn:length(result.attachFiles) < 1 }">
									<div id="attachFilesArea">
			<c:forEach begin="1" end="${result.brdMst.atc_num }" varStatus="i">
										<div class="fileBox">
											<input type="file" name="attachFiles" id="attachFileInput_${i.count }" />
											<button type="button" class="btnFileDel" onclick="fn_cancelFile(${i.count });">삭제</button>
										</div>
			</c:forEach>
									</div>
		</c:when>
		<c:otherwise>
										<div id="" class="savedFileList">
			<c:forEach items="${result.attachFiles }" var="attachFile" varStatus="i">
										
											<div id="" class="filename">
												<div class="fl">${attachFile.org_name }</div>
												<button type="button" class="del_savedFile" onclick="fn_deleteFile('${attachFile.brd_code }', '${attachFile.brd_idx }', '${attachFile.file_idx }');">X</button>
											</div>
										
			</c:forEach>
										</div>
			<c:forEach begin="1" end="${result.brdMst.atc_num - fn:length(result.attachFiles) }" varStatus="i">
										<div class="fileBox">
											<input type="file" name="attachFiles" id="attachFileInput_${i.count }" />
											<button type="button" class="btnFileDel" onclick="fn_cancelFile(${i.count });">X</button>
										</div>
			</c:forEach>
		</c:otherwise>
	</c:choose>
									
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