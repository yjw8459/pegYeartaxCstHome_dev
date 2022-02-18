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
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/jquery.maskedinput.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/common.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/ajaxUtil.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/messageUtil.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/admin/boardMng.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	// window resize
	resizeContent();
	$(window).resize(function() { resizeContent(); });
	
	//Dialog
	$("#dialog_boardForm").dialog({
		autoOpen: false,
		height: "auto",
		width: 830,
		modal: true
	});
	
	fn_search(1);
});


function fn_searchCallback(data) {
	let list = data.list;
	let length = list.length;
	if(length < 1) alert('데이터가 존재하지 않습니다.');
	
	// 순번을 만들기 위한 기본값은 페이징 객체를 이용
	let paging = data.paging;
	let totalCount = paging.totalCount;
	let pageNum = paging.pageNum;
	let pageSize = paging.pageSize;
	let html = '';
	for (var i=0; i<length; i++) {
		let idx = totalCount - (((pageNum - 1) * pageSize) + i);	// 순번
		let board = list[i];
		let brdCode = board.brd_code;
		let brdName = board.brd_name;
		let brdType = board.brd_type;
		let brdTypeName = board.brd_type_name;
		let compName = board.comp_name;
		let useYn = board.use_yn;
		
		html += '<tr>';
		html += '	<td>'+idx+'</td>';
		html += '	<td>'+brdName+'</td>';
		html += '	<td>'+brdTypeName+'</td>';
		html += '	<td>';
		html += '		<select onchange="fn_updateUseYn(\''+brdCode+'\', this.value)";>';
		html += '			<option value="Y" '+(useYn == 'Y' ? 'selected=selected' : '')+'>사용</option>';
		html += '			<option value="N" '+(useYn != 'Y' ? 'selected=selected' : '')+'>사용안함</option>';
		html += '		</select>';
		html += '	</td>';
		html += '	<td><div class="mForm_Open btnChecking" onclick="fn_openModalForm(\''+brdCode+'\');">수정</div></td>';
		html += '</tr>';
	}
	$("#boardMngList tbody").html(html);
	fn_setPagingNavigation(data);
}


function fn_pageMove(page_num) {
	fn_search(page_num);
}
</script>


<body class="yeartaxHelp_main">


<%@ include file="/WEB-INF/jsp/common/modalMessage.jsp" %>

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
		
<%@ include file="/WEB-INF/jsp/common/left_menu.jsp" %>

<form name="searchForm" id="searchForm" onsubmit="return false;">
	<input type="hidden" name="page_num" />
	<input type="hidden" name="ent_uno" value="${userDataVO.usr_id }" />
	<input type="hidden" name="upd_uno" value="${userDataVO.usr_id }" />
</form>

			<div class="contents">
			 <div class="topBnr4"></div>
				<div class="cntHeader bgImg7">
					<div class="title">게시판 관리</div>
				</div>

				<div class="cntBody">
					<div class="tblWrap">
						<table class="tbl_list mngBoardList" id="boardMngList">
							<thead>
								<tr>
									<th class="col_1">No.</th>
									<th class="col_2">게시판 이름</th>
									<th class="col_3">게시판 유형</th>
									<th class="col_4">게시판 사용여부</th>
									<th class="col_5"></th>
								</tr>
							</thead>
							<tbody></tbody>
						</table>
					</div>
					
					<div class="tblBtnArea">
						<div class="mForm_Open btnBasic" onclick="fn_openModalForm('');">신규</div>
					</div>
					
					<div id="pageNavigation"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

