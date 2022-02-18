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
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/login.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/initPassword.js"></script>
<title>PEGSYSTEM</title>
<script type="text/javascript">
$(document).ready(function() {
	
	switch ('${msg}') {
		case 'empty' :	alert('로그인 정보가 없습니다.');	break;
	}
	
	// window resize
	resizeContent();
	$(window).resize(function() { resizeContent(); });
	$('#user_id').focus();
	
	
	//dialog 기초설정
	$( "#dialog_signUpForm" ).dialog({
		autoOpen: false,
		height: "auto",
		width: 1010,
		modal: true
	});
	
	
	//이벤트 등록
	$('.num').keydown(fn_numberKeydown);
	$('.num').keyup(fn_numberKeyUp);
	
	//쿠키
	let saveYn = getCookie('peg_cst_login_saveId_yn');
	if ( saveYn == 'Y' ) {
		$('#save_id').prop('checked', true);
		let savedId = getCookie('peg_cst_user_id');
		$('#user_id').val(savedId);
	}
	
	
});

function fn_loginAction() {
	if(fn_preCheck()) {
		let url = fn_getContextPath()+'/cmmn/login';
		let data = $('#loginForm').serializeObject();
		fn_ajaxPOST(url, data, fn_loginActionCallback);
	}
}

</script>
</head>
<%@ include file="modalMessage.jsp" %>
<body class="yeartaxHelp_login">

	<div class="windowWrap">
		<div class="contentWrap">
			<!-- login box -->
			<div class="loginBox">
				<form id="loginForm" action="" method="POST">
					<input type="text" class="hp_id" name="user_id" id="user_id" placeholder="아이디" onkeypress="javascript:if(event.keyCode==13) { fn_loginAction(); }" />
					<input type="password" class="hp_pw" name="user_pwd" id="user_pwd" placeholder="비밀번호" onkeypress="javascript:if(event.keyCode==13) { fn_loginAction(); }" />
					<div class="saveidBox">
						<input id="save_id" type="checkBox"/>
						<label for="save_id">아이디 저장</label>
					</div>
					<div class="hp_btn login" onclick="fn_loginAction();">로그인</div>
					<div class="btw"></div>
					<div class="hp_btn pwReset" onclick="fn_initPasswordForm();">비밀번호 초기화</div>
					<div class="hp_btn joinRequest" onclick="fn_signUp_openModal();">회원가입 신청</div>
				</form>
			</div>
		</div>
	</div>


</body>
