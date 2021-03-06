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
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/jquery.mask.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/common.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/ajaxUtil.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/messageUtil.js"></script>
<script type="text/javascript" src="${contextPath }/resources/js/pegs/admin/QnAMng.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/admin/common.js"></script>
<script type="text/javascript">
$(function(){
	fn_alertMsg();
	// window resize
	resizeContent();
	$(window).resize(function() { resizeContent(); });
	//게시물 조회
	let pageNum = '${condition.page_num}';
	if ( pageNum == '' ) 		pageNum = 1;
	fn_search(pageNum);
	
	//dialog 기초설정
	$( "#dialog_stsForm" ).dialog({
		autoOpen: false,
		height: "auto",
		width: 1000,
		modal: true
	});
	
 	$('#from').mask('0000.00.00');
	$('#to').mask('0000.00.00'); 
	
})

function movePage(pageNum){
	fn_search(pageNum);
}

function setPageNum(pageNum){
	let page = document.querySelector('#pageNum').value; //현재 페이지 Number
	if ( 0 > pageNum )  	page = (+page - 1);
	else 					page = (+page + 1);
	movePage(page);
}  


//접수
function fn_confirmSts(brd_idx, lst_sts){
	let brd_code = document.querySelector('#QnA_code').value;
	let ent_uno = document.querySelector('#user_id').value;
	
	let data = {
			'brd_idx' : brd_idx,
			'lst_sts' : lst_sts,
			'brd_code' : brd_code,
			'ent_uno' : ent_uno
	};
	
	if ( lst_sts == '11' ) 		msg = '선택한 문의를 접수 신청 하시겠습니까?';
	else if (lst_sts == '01')	msg = '선택한 문의를 접수 취소 하시겠습니까?';
	
	let result = confirm(msg);
	
	if ( result )	fn_updateSts(data, fn_confirmStsCallback); 
}

function fn_confirmStsCallback(data){
	let retCode = data.retCode;
	let retMsg = data.retMsg
	alert(retMsg);
	let pageNum = $('#page_num').val();
	fn_search(pageNum);
}

function fn_conditionSearch(){
	let f = document.searchForm;
	f.page_num.value = 1;
	f.action = fn_getContextPath() + '/adm/QnA-mng';
	f.submit();
}

function fn_alertMsg(){
	switch ('${msgCode}') {
		case '1': alert('저장되었습니다.');	return ;
	}
	
} 

$(function() {
    $(".btBasic_search").on("click", function() {
      $("#searchArea").slideToggle(500);
    });
  });




</script>
</head>
<c:choose>
	<c:when test="${condition.from eq null || condition.to eq null }">
		<c:set var="from" value="${result.defaultDate.from }" />
		<c:set var="to" value="${result.defaultDate.to }" />
	</c:when>
	<c:otherwise>
		<c:set var="from" value="${condition.from }" />
		<c:set var="to" value="${condition.to }" />
	</c:otherwise>
</c:choose>
<%@ include file="/WEB-INF/jsp/common/modalMessage.jsp" %>
<body class="yeartaxHelp_main">

	<div class="mainWrap">
	
		<div class="header">
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
	<div class="searchBtnn"></div>
	<div id="searchArea">
		<form id="searchForm" name="searchForm" action="">
		<input id="page_num" type="hidden" name="page_num">
		<input type="hidden" name="brd_idx" value="0">
		<input type="hidden" name="brd_code" value="${result.brdMst.brd_code }">
		<input type="hidden" name="req_cat" value="">

	
		<table class="tblSerach">
			<tr>
				<th>기간</th>
				<td>
					<input type="text" name="from" id="from" class="date from dateFormat" value="${from }" />
					<div class="wave">~</div>
					<input type="text" name="to" id="to" class="date to dateFormat" value="${to }" />
				</td>
<!-- 업무구분 기본값: ''(전체) -->				
<c:set value="${condition.wrk_cat eq null ? '' : condition.wrk_cat }" var="wrk_cat" />
				<th>업무구분</th>
				<td>
					<select name="wrk_cat">
						<option value="">전체</option>
<c:forEach var="code" items="${result.c001 }">
						<option value="${code.cd }" <c:if test="${wrk_cat eq code.cd }"> selected="selected"</c:if>  >${code.cd_nm }</option>
</c:forEach>
					</select>
				</td>
				<th>질문구분</th>
				<td>
					<select name="qst_cat" >
						<option value="">전체</option>
<c:forEach var="code" items="${result.c002 }">
						<option value="${code.cd }" <c:if test="${condition.qst_cat eq code.cd }"> selected="selected"</c:if> >${code.cd_nm }</option>
</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>정산년도</th>
				<td>
					<select name="sac_yy" >
						<option value="">전체</option>
<c:forEach var="code" items="${result.c007 }">
						<option value="${code.cd }" <c:if test="${condition.sac_yy eq code.cd }"> selected="selected"</c:if> >${code.cd_nm }</option>
</c:forEach>
					</select>
				</td>
				<th>진행상태</th>
				<td>
					<select name="lst_sts" >
						<option value="">전체</option>
						<option value="12" <c:if test="${condition.lst_sts eq '12' || condition.lst_sts eq null }"> selected="selected"</c:if>  >접수대기중 및 접수</option>
<c:forEach var="code" items="${result.c004 }">
						<option value="${code.cd }" <c:if test="${condition.lst_sts eq code.cd }"> selected="selected"</c:if> >${code.cd_nm }</option>
</c:forEach>
					</select>
				</td>
				<th>고객사</th>
				<td><input type="text" name="comp_name"  class="keyword" value="${condition.comp_name }" onkeyup="javascript:if(event.keyCode == 13) { fn_conditionSearch();}" /></td>
			</tr>
			<tr>
				<th>제목 및 내용</th>
				<td colspan="3">
					<input type="text" name="keyword" class="keyword" style="width:587px" value="${condition.keyword }" />
				</td>
				<th>삭제된 게시물만 보기</th>
				<td colspan="2">
					<input type="checkbox" value="" <c:if test="${condition.del_yn eq 'Y' }">checked="checked"</c:if> onchange="fn_checkedDetecting(this, '#del_yn');">
					<input type="hidden" id="del_yn" name="del_yn" value="${condition.del_yn eq null ? 'N' : condition.del_yn }">
				</td>
			</tr>
		</table>
		</form>
		<div class="searchBtnArea">
			<div class="hp_btnSearch" onclick="fn_conditionSearch();" title="검색"></div>
			<div class="hp_btnReset" title="초기화" onclick="fn_searchFormReset();"></div>
		</div>
	</div>
	
	<div class="cntHeader bgImg4" >
		<div class="title">Q＆A 관리</div>
		<div class="tblBtnTop">
			<div class="btBasic_search">검색하기</div>
			<div class="btnBasic1 btnPosition" onclick="location.href=fn_getContextPath() + '/adm/QnA-mng/direct'">등록하기</div>
		</div>
	</div>
	
	<div class="cntBody">
		<div class="tblWrap">
			<table id="QnA_main_table" class="tbl_list mng">
				<thead>
					<tr>
						<th class="col_1">No.</th>
						<th class="col_2">정산년도</th>
						<th class="col_3">업무구분</th>
						<th class="col_4">질문 구분</th>
						<th class="col_5">제목</th>
						<th class="col_6">고객사</th>
						<th class="col_7">질문자</th>
						<th class="col_8">질문일시</th>
						<th class="col_9">문의방법</th>
						<!-- <th class="col_10">작성자</th> -->
						<th class="col_7">답변자</th>
						<th class="col_8">답변일시</th>
						<th class="col_11">진행상태</th>
						<th class="col_11"></th>
					</tr>
				</thead>
				
				<tbody>
					<!-- QnA 게시물 구간  -->
				</tbody>
				
				<tfoot>
				</tfoot>
			</table>
		</div>
		
		
		
		
		<!-- PAGINATE -->
		<div id="pageNavigation" class="page_Container">

		</div>
	</div>
	<input id="QnA_code" type="hidden" value="${result.brdMst.brd_code }">
	<input id="user_id" type="hidden" value="${sessionScope.userDataVO.usr_id }">
</div>
</div>
</div>
</body>
</html>