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
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/board_common.js"></script>
<title>PEGSYSTEM</title>
<script type="text/javascript">
$(document).ready(function() {
	// window resize
	resizeContent();
	$(window).resize(function() { resizeContent(); });
	fn_search(1);
});


function fn_boardListToggle() {
	// FAQ
	$(".btn_faq").on("click", function(){
		var $faq_item = $(this).parent(".faq_item");
		$faq_item.siblings(".faq_item").removeClass("on");
		$faq_item.addClass("on");
		
		// 닫기버튼 클릭 
		$(".faq_item.on .faq_view .bg_cs_close").on("click", function(){
			if ( $faq_item.hasClass("on") ){
				$faq_item.removeClass("on");
			}
		});
	});
}


function fn_searchCallback(data) {
	let list = data.list;
	let length = list.length;
	if(length < 1) alert('데이터가 존재하지 않습니다.');
	
	var usr_cat = $('#usr_cat').val();
	let html = '';
	for (var i=0; i<length; i++) {
		let board = list[i];
		let wrkCatName = board.wrk_cat_name;
		let subject = board.subject;
		let content = board.content;
		let brdCode = board.brd_code; 
		let brdIdx = board.brd_idx; 
		html += '<div  class="faq_item">';
		html += '	<div class="btn_faq">';
		html += '		<div class="txt_cat">[' + wrkCatName + ']</div>';
		html += '		<div class="faq_TitleBox">' + subject + '</div>';
		html += '		<div class="bg_cs_open" title="펼치기"></div>';
		html += '	</div>';
		html += '	<div class="faq_view">';
// 		html += '		<div class="txt_cat">[' + wrkCatName + ']</div>';
		html += '		<div class="tit_faq">[' + wrkCatName + '] ' + subject + '</div>';
		html += '		<div class="bg_cs_close" title="접기"></div>';
		html += '		<div class="desc_faq">' + content + '</div>';
if(usr_cat === '99') {
		html += '		<div class="btnWrap">';
		html += '			<button type="button" onclick="fn_delete(\'' + brdCode + '\',\'' + brdIdx + '\');">삭제</button>';
		html += '			<button type="button" onclick="fn_boardForm(\'' + brdCode + '\',\'' + brdIdx + '\');">수정</button>';
		html += '		</div>';
}
		html += '	</div>';
		html += '</div>';
	}
	$("#faqBoardList").html(html);
	fn_setPagingNavigation(data);
	fn_boardListToggle();
}


function fn_pageMove(page_num) {
	fn_search(page_num);
}


function fn_deleteCallback(data) {
	let retCode = data.retCode;
	if(retCode > 0) {
		alert("삭제가 완료되었습니다.");
	} else {
		var retMsg = data.retMsg;
		alert(retMsg);
	}
	fn_search(1);
}
</script>
</head>
<%@ include file="/WEB-INF/jsp/common/modalMessage.jsp" %>
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

<%@ include file="/WEB-INF/jsp/common/left_menu.jsp" %>
			
			<div class="contents">
			 <div class="topBnr"></div>
				<div class="searchArea">
<form name="searchForm" id="searchForm" onsubmit="return false;">
	<input type="hidden" name="brd_code" value="${result.brdMst.brd_code }" />
	<input type="hidden" name="brd_cat" value="faq" />
	<input type="hidden" name="brd_idx" />
	<input type="hidden" name="page_num" />
	<input type="hidden" id="usr_id" value="${userDataVO.usr_id }" />
	<input type="hidden" id="usr_cat" value="${userDataVO.usr_cat }" />
					<table class="tblSerach">
						<tr>
							<th>업무구분</th>
							<td>
								<select name="wrk_cat" id="wrk_cat">
<c:forEach items="${result.c001 }" var="code" varStatus="i">
	<c:if test="${fn:substring(userDataVO.comp_role, i.index, i.index + 1) eq 'Y' }">
									<option value="${code.cd }">${code.cd_nm }</option>
	</c:if>
</c:forEach>
								</select>
							</td>
							<th>질문구분</th>
							<td>
								<select name="qst_cat" id="qst_cat">
									<option value="">전체</option>
<c:forEach items="${result.c002 }" var="code">
									<option value="${code.cd }">${code.cd_nm }</option>
</c:forEach>
								</select>
							</td>
							<th>제목 및 내용</th>
							<td colspan="3">
								<input type="text" name="keyword" id="keyword" class="keyword" onkeypress="javascript:if(event.keyCode==13) { fn_search(1); }" />
							</td>
						</tr>
					</table>
</form>
					<div class="searchBtnArea">
						<div class="hp_btnSearch" title="검색" onclick="fn_search(1);"></div>
						<div class="hp_btnReset" title="초기화" onclick="fn_searchFormReset();"></div>
					</div>
				</div>

				<div class="cntHeader bgImg1">
					<div class="title">FAQ</div>
				</div>

				<div class="cntBody">
					<div class="faqWrap" id="faqBoardList"></div>
					<div class="tblBtnArea">
<c:if test="${userDataVO.usr_cat >= 90 }">
						<div class="btnBasic" onclick="fn_boardForm('${result.brdMst.brd_code }', 0);">등록하기</div>
</c:if>
					</div>
				</div>
				
				<div id="pageNavigation"></div>
				
				
				
			</div>
		</div>
		
	</div>


</body>
</html>


