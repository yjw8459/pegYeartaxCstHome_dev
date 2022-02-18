<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script type="text/javascript" src="${contextPath }/resources/js/pegs/admin/QnAMng.js"></script>
<script type="text/javascript">

$(function(){
	// window resize
	resizeContent();
	$(window).resize(function() { resizeContent(); });
})

function fn_list(){
	let f = document.conditionForm;
	f.action = fn_getContextPath() + '/adm/QnA-mng';
	f.submit();
}

/**
 * 진행상태 구분 없이 수정 페이지 이동 시 
 */
function fn_adminQnA_editForm(brd_code, brd_idx, lst_sts, ent_uno){
	location.href = fn_getContextPath() + '/adm/QnA-mng/direct?brd_code=' + brd_code + '&brd_idx=' + brd_idx;
}

/**
 * 진행상태에 따른 수정 기능 사용 시 
 */
function fn_confirmSts(brd_code, brd_idx, lst_sts, ent_uno){
	if ( lst_sts == '01' ) {
		msg = '선택한 문의를 접수 신청 하시겠습니까?';
		lst_sts = '11';
	}
	else if (lst_sts == '11'){
		msg = '선택한 문의를 접수 취소 하시겠습니까?';
		lst_sts = '01';
	}
 	else if ( lst_sts == '21' ) {
		msg = '등록한 답변을 수정하시겠습니까?';
		lst_sts = '11';
	} 
	let data = {
			'brd_code' : brd_code,
			'brd_idx' : brd_idx,
			'lst_sts' : lst_sts,
			'ent_uno' : ent_uno
	};
	let result = confirm(msg);
	if ( result )	fn_updateSts(data, fn_confirmStsCallback); 
	
}

function fn_confirmStsCallback(data){
	let retCode = data.retCode;
	let retMsg = data.retMsg
	alert(retMsg);
	location.reload();
}


function fn_delete( division, msg ){
	const result = confirm( msg + '을 삭제하시겠습니까?');
	if ( ! result ) 	return false;
	
	const callback = (result) => {
		if ( result.retCode > 0 ) {
			alert('삭제되었습니다.');
			history.back();
		}
	}
	
	let url = fn_getContextPath() + '/adm/QnA-mng/delete';
	let data = { 'ent_uno' : '${result.question.ent_uno}',
				 'brd_idx' : '${result.question.brd_idx}',
				 'state' : division
	};
	fn_ajaxPOST(url, data, callback);
}

function fn_clipCopy(){
	let dummy = document.createElement("textarea");
	document.body.appendChild(dummy);
	const url = window.document.location.href;
	dummy.value = url;
	dummy.select();
	document.execCommand("copy");
	document.body.removeChild(dummy);
	alert('URL이 복사되었습니다.');
}

/**
 * 답변 저장 
 */
function fn_answerSave(){
	oEditors.getById["contentBox2"].exec("UPDATE_CONTENTS_FIELD", []);
	const value = document.querySelector('#contentBox2').value;
	if ( fn_replaceEditorValue(value) === '' ) {
		alert('답변이 비어있습니다.');
		return false;
	}
	const data = {
			'brd_code'	: document.querySelector('#brd_code').value,
			'brd_idx' 	: document.querySelector('#brd_idx').value,
			'answer' 		: document.querySelector('#contentBox2').value,
			'usr_name' 	: document.querySelector('#usr_name').value,
			'ent_uno' 		: document.querySelector('#usr_id').value
		};
	
	const callback = (data) => {
		if ( data.result === 'success') 
			location.reload();
	}
	AJAX_UTIL.sendJson('/adm/QnA-mng/save', data, 'PUT', callback);
}

</script>
</head>
<body class="yeartaxHelp_main">

<!--Hidden Field  -->
<input type="hidden" id="brd_code" 	value="${result.question.brd_code }">
<input type="hidden" id="brd_idx" 	value="${result.question.brd_idx }">
<input type="hidden" id="usr_name" 	value="${sessionScope.userDataVO.usr_name}">
<input type="hidden" id="usr_id" 		value="${sessionScope.userDataVO.usr_id}">
<!--Hidden Field  -->

	<div class="mainWrap">
	
		<div class="header">`
			<div class="userFr">
				<div class="userArea">${sessionScope.userDataVO.usr_id }(${sessionScope.userDataVO.usr_name })</div>
				<div class="userInfoArea">
					<div class="userInfo" onclick="fn_modifyUserData();">회원정보변경</div>
					<div class="userInfo" onclick="fn_logout();">로그아웃</div>
				</div>
			</div>
		</div>
		<div class="contentsWrap">

<%@ include file="/WEB-INF/jsp/common/left_menu.jsp" %>
<div class="contents">
 <div class="topBnr4"></div>

	<div class="cntHeader bgImg4">
		<div class="title">Q&amp;A</div>
		<div class="btnWrap">
			<div class="btn05" title="목록보기" onclick="fn_list();" ></div>
			<div class="btn01" title="수정하기" onclick="fn_adminQnA_editForm('${result.question.brd_code}','${result.question.brd_idx }',21,'${result.question.ent_uno }');"></div>
			<div class="btn02" title="주소복사" onclick="fn_clipCopy();"></div>
		</div>
	</div>
	<div class="cntBody">
		<div class="tblWrap">
			<table class="tbl_view qna question">
				<tr>
					<td colspan="6" class="title">
						${result.question.subject }
					</td>
				</tr>
				<tr>
					<th>업무구분</th>
					<td>${result.question.wrk_cat_name }</td>
					<th>정산년도</th>
					<td>${result.question.sac_yy }</td>
					<th></th>
					<td></td>
				</tr>
				<tr>
					<th>상세구분</th>
					<td>${result.question.qst_cat_name }</td>
					<th>문의방법</th>
					<td>${result.question.req_cat_name}</td>
					<th></th>
					<td></td>
				</tr>
				<tr>
					<th>질문자</th>
					<td>${result.question.cust_name }</td>
					<th>사업장</th>
					<td>${result.question.comp_name }</td>
					<th>공유여부</th>
					<td>
						${result.question.shr_yn_name }
					</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${result.question.usr_name }</td>
					<th>작성일시</th>
					<td colspan="3">
						<fmt:parseDate value="${result.question.ent_dtm }" pattern="yyyyMMddHHmmss" var="qDate" />
						<fmt:formatDate value="${qDate }" pattern="yyyy년MM월dd일 HH:mm:ss"/>
					</td>
				</tr>
				<tr>
					<th>답변자</th>
					<td>${result.question.answer_name }</td>
					<th>답변일시</th>
					<td colspan="3">
						<fmt:parseDate value="${result.question.answer_dtm }" pattern="yyyyMMddHHmmss" var="aDate" />
						<fmt:formatDate value="${aDate }" pattern="yyyy년MM월dd일 HH:mm:ss"/>
					</td>
				</tr>
				<tr>
					<th>질문</th>
					<td class="textarea" colspan="6">
						${result.question.question }
					</td>
				</tr>
                <c:if test="${result.questionFiles ne null and fn:length(result.questionFiles) > 0 }">
				  <tr>
					<th>첨부</th>
					<td colspan="6">
	                    <c:forEach items="${result.questionFiles }" var="attachFile">
						  <div class="filename">
							<a href="/brd/download?brd_code=${attachFile.brd_code}&brd_idx=${attachFile.brd_idx}&file_idx=${attachFile.file_idx }">${attachFile.org_name }</a>
						  </div>
	                    </c:forEach>
					</td>
				 </tr>
               </c:if>
			</table>
			<div class="btnWrap2">
				<div class="btn04" title="게시글삭제" onclick="fn_delete('ALL', '게시글');"></div>
			</div>
		</div>
<c:choose>		

	<c:when test="${result.question.lst_sts eq '01' || result.question.lst_sts eq '11' }">
<!-- 답변 수정 폼  -->
					<!-- Answer -->
					<div class="tblWrap answerWrap">
						<div class="answerHead">Answer</div>
						<!-- Button Group -->
						<div class="tblBtnArea writeForm">
							<div class="btnWriteBasic saveBtn2" onclick="fn_answerSave();">저장</div>
							<!-- <div class="btnWriteBasic cancelBtn2" onclick="fn_cancel();">취소</div> -->
						</div>
						<table class="tbl_write qna">
							<tr>
								<th>제목</th>
								<td id="answer_title" colspan="3">
									RE : ${result.question.subject }
								</td>
							</tr>
							<tr>
								<th>답변</th>
								<td colspan="3" class="textarea">
									<textarea name="answer" id="contentBox2"  class="write_textarea" required="required" >${detail.question.answer }</textarea>
<script type="text/javascript">
	var oEditors = [];
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
	</c:when>
	<c:otherwise>
<!-- 답변 뷰 -->
		    <div class="tblWrap">
		    	
			  <table class="tbl_view qna reply">
				   <tr>
					 <td colspan="4" class="title">
						RE : ${result.question.subject }
					 </td>
				   </tr>				
				   <tr>
					   <th class="th_A">답변</th>
					   <td colspan="6" class="textarea">
						${result.question.answer }
					   </td>
				   </tr>
                   <c:if test="${result.answerFiles ne null and fn:length(result.answerFiles) > 0 }">
					<tr class="th_a_line">
						<th class="th_a_bg">첨부</th>
						<td colspan="6">
	                         <c:forEach items="${result.answerFiles }" var="attachFile">
							    <div class="filename">
									<a href="/brd/download?brd_code=${attachFile.brd_code}&brd_idx=${attachFile.brd_idx}&file_idx=${attachFile.file_idx }">${attachFile.org_name }</a>
								</div>
	                         </c:forEach>
						</td>
					 </tr>
                 </c:if>
			  </table>
			  <div class="btnWrap3">
				
				<div class="btn03" title="답변삭제" onclick="fn_delete('A', '답변');"></div>
			</div>
		   </div>
	</c:otherwise>
</c:choose>

        <form name="conditionForm">
			   <!-- 검색 조건 유지  -->
			   <input type="hidden" name="sac_yy" 	 value="${condition.sac_yy }">
			   <input type="hidden" name="wrk_cat" 	 value="${condition.wrk_cat }">
			   <input type="hidden" name="qst_cat" 	 value="${condition.qst_cat }">
		   	   <input type="hidden" name="lst_sts" 	 value="${condition.lst_sts }">
			   <input type="hidden" name="keyword" 	 value="${condition.keyword }">
			   <input type="hidden" name="from" 	 value="${condition.from }">
	           <input type="hidden" name="to" 		 value="${condition.to }">
		       <input type="hidden" name="comp_name" value="${condition.comp_name }">
			   <input type="hidden" name="page_num"  value="${condition.page_num }">
			   <!-- 검색 조건 유지  -->
        </form>
	</div>
</div>
</div>
</div>
</body>
</html>
