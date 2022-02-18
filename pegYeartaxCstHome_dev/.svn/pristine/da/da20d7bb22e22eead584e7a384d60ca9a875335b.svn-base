
function fn_preCheck() {
	let user_id = $('#loginForm #user_id').val();
	if(user_id == '') {
		alert("아이디를 입력해주세요.");
		$('#loginForm #user_id').focus();
		return false;
	}
	let user_pwd = $('#loginForm #user_pwd').val(); 
	if(user_pwd == '') {
		alert("비밀번호를 입력해주세요.");
		$('#loginForm #user_pwd').focus();
		return false;
	}
	return true;
}


function fn_loginActionCallback(data) {
	let retCode = data.retCode;
	if(retCode < 0) {
		let retMsg = data.retMsg;
		alert(retMsg);
	} else {
		fn_cookieProc();
		location.href = fn_getContextPath()+'/cmmn/loginCallback';
	}
}


function fn_cookieProc(){
	let checked = $('#save_id').is(':checked');
	const COOKIE_VALIDITY = 60;	//쿠키 유효기간
	if( checked )
	{
		let user_id = $('#user_id').val();
		setCookie("peg_cst_user_id", user_id, COOKIE_VALIDITY);
		setCookie("peg_cst_login_saveId_yn", "Y", COOKIE_VALIDITY);
	}
	else
	{
		deleteCookie("peg_cst_user_id");
		deleteCookie("peg_cst_login_saveId_yn");
	}
}

function setCookie(key, value, COOKIE_VALIDITY){
	let date = new Date();
	date.setDate(date.getDate() + COOKIE_VALIDITY);
	let cookieValue = escape(value) + ((COOKIE_VALIDITY == null) ? "" : "; expires" + date.toGMTString());
	document.cookie = key + "=" + cookieValue;
}

function deleteCookie(cookieName){
	let date = new Date();
	date.setDate(date.getDate() -1 );
	document.cookie = cookieName + "= " + "; expires=" + date.toGMTString();
}

function getCookie(cookieName){
	let x, y;
	let cookieDataArr = document.cookie.split(';');
	
	for(let i = 0; i < cookieDataArr.length; i++){
		let cookieData = cookieDataArr[i];
		x = cookieData.substr(0, cookieData.indexOf('='));
		y = cookieData.substr(cookieData.indexOf('=') + 1);
		x = x.replace(/^\s+|\s+$/g, '');
		
		if( x == cookieName ){
			return unescape(y);
		}
	}
}






// 이메일 중복 체크
let modal_signUp_overlap = false;
let modal_signUp_key_check = false;

/*
*	회원가입 신청
*	유효성 체크 
*	1. 특수문자 체크 
*	2. required 클래스 빈 값 체크 
*	3. 이메일 중복검사
*/
function fn_signUp(){
	
	let result = true;
	let usrEmail = '';
	let usrDept = $('#modal_signUp_usrDept').val();
	
	//특수문자 체크
	$('#modal_signUp_form').find('.validate_1').each(function(i){
		let value = $(this).val();
		let specialChk = fn_chkSpecialChar(value);
		if ( specialChk ) 
		{
			alert('특수문자를 사용할 수 없습니다.');
			result = false;
			$(this).focus();
			return false;
		}
	});	
	
	if ( !result ) 		return result;
	
	//required 클래스 빈 값 체크 
	$('#modal_signUp_form').find('.required').each(function(i){
		let value = $(this).val();
		if ( value.trim() == '' ) {
			alert('항목을 입력해주세요.');
			$(this).focus();
			result = false;
			return result;
		}
	});
	
	if ( !result ) 		return result;
	
	//연락처 유효성 검사
	result = fn_telChk();		 
	
	
	
	if ( result ) 
	{
		//이메일 중복검사 여부
//		let overlap = $('#modal_signUp_overlap').val();		
		if (!modal_signUp_overlap) 
		{
			alert('이메일 중복검사를 완료해주세요.');
			$('#modal_signUp_chkBtn').focus();
			return false;
		}
		else 
		{
			usrEmail = 	$('#modal_signUp_usrEmail1').val(); 
			usrEmail +=	'@' 
			usrEmail += $('#modal_signUp_usrEmail2').val();
		}
		
		//부서 구분 값
		if ( 'N' == usrDept ) 
		{
			alert('항목을 선택해주세요');
			$('#modal_signUp_usrDept').focus();
			return false;
		}
	}
	
	if ( !result ) 		return result;
	
  if(modal_signUp_key_check) {
		let url = fn_getContextPath() + '/cmmn/signUp';
		let f = document.signUpForm;
		f.usr_email.value = usrEmail;
		let data = $('#modal_signUp_form').serializeObject();
		fn_ajaxPOST(url, data, fn_signUpCallback);
  } else {
    alert("이메일 인증이 완료되지 않았습니다.");
    return false;
  }
}


function fn_signUpCallback(data){
  var retCode = data.retCode;
  if(retCode > 0) {
    alert("회원가입 신청이 완료되었습니다.\n사용자 계정 정보는 관리자 확인 후 이메일로 발송됩니다.");
  } else {
    var retMsg = data.retMsg;
		alert(retMsg);
  }
	$( "#dialog_signUpForm" ).dialog( "close" );
} 


/* 
*	연락처 유효성 검사 function
*	1. offTel, usrTel 중 입력 값이 있는 것만 유효성 검사
*	2. 둘 중 하나가 입력되어있는지 검사 
*	3. 유효성의 문제가 없는 경우 return true
*/
function fn_telChk(){
	let chkResult = true;
	let usrTel = '';
	let offTel = '';
	
	$('.usrTel').each(function(i){
		let idx = i+1;
		usrTel += $('#modal_signUp_usrTel' + idx).val();
	});
	$('.offTel').each(function(i){
		let idx = i+1;
		offTel += $('#modal_signUp_offTel' + idx).val();
	});
	if ( '' == offTel.trim() && '' == usrTel.trim() ) 
	{
		alert('사무실, 휴대전화 중 하나의 연락처를 입력해야 합니다.');
		chkResult = false;
	}
	else if ( '' == offTel.trim() ) 
	{
		$('#modal_signUp_usrTel').value = '';
		$('.usrTel').each(function(i){
			let value = $(this).val();
			let result = fn_chkOnlyNumber(value);
			if ( result ) 
			{
				alert('형식이 올바르지 않습니다.');
				chkResult = false;
				return false;
			}
			else document.querySelector('#modal_signUp_usrTel').value =  usrTel;
		});
	}
	else if ( '' == usrTel.trim() ) 
	{
		$('#modal_signUp_offTel').value = '';
		$('.offTel').each(function(){
			let value = $(this).val();
			let result = fn_chkOnlyNumber(value);
			if ( result ) 
			{
				alert('형식이 올바르지 않습니다.');
				chkResult = false;
				return false;
			}
			else document.querySelector('#modal_signUp_offTel').value =  offTel;
		});
	}
	else 
	{
		$('.num').each(function(i){
			let value = $(this).val();
			let result = fn_chkOnlyNumber(value);
			if ( result ) 
			{
				alert('형식이 올바르지 않습니다.');
				chkResult = false;
				return false;
			}
			else 
			{
				if ( $(this).hasClass('offTel') ) 
					document.querySelector('#modal_signUp_offTel').value =  offTel;
				else
					document.querySelector('#modal_signUp_usrTel').value =  usrTel;
			}
		});
	}
	return chkResult;
}


/* 
*	이메일 중복검사 function
*
*/
function fn_mailChk(){
	let mail = $('#modal_signUp_usrEmail1').val() + '@' + $('#modal_signUp_usrEmail2').val();
	if ( fn_chkMail(mail) ) {
		alert('형식이 올바르지 않습니다.');
		$('#modal_signUp_usrEmail1').focus();
		return false;
	}
	let url = fn_getContextPath() + '/cmmn/mailChk';
	let data = { 'mail' :  mail };
	fn_ajaxPOST(url, data, fn_mailChkCallback);
	
	
	function fn_mailChkCallback(data){
		let retCode = data.retCode;
		if(retCode > 1) {
      //중복 이메일이 있을경우
      fn_setEmailAuthBtn('N');
      modal_signUp_overlap = false;
		} else if(retCode > 0) {
      //사용 가능한 이메일일 경우
      fn_setEmailAuthBtn('Y');
      modal_signUp_overlap = true;
		} else {
      fn_setEmailAuthBtn('N');
			let retMsg = data.retMsg;
			alert(retMsg)
      modal_signUp_overlap = false;
		}
	}
}



/**
 * 이메일 입력값이 변경되면 관련항목 초기화
 */
function fn_initEmailCheck() {
  modal_signUp_overlap = false;
  fn_setEmailAuthBtn('I');
}


/**
 * 이메일 도메인 초기화
 */
function fn_changeEmailOpt(obj) {
  var value = $(obj).val();
  $('#modal_signUp_usrEmail2').val(value).prop('disabled', (value == '' ? false : true));
  fn_initEmailCheck();
}


/**
 * 이메일 중복확인 후 버튼 처리 
 */
function fn_setEmailAuthBtn(kind) {
  $('.checking_Result').slideUp();
  if(kind == 'N') {
    // 이메일 중복
    $('#modal_signUp_false').slideDown();
    $('#modal_signUp_chkBtn').show();
    $('#modal_signUp_email_auth').hide();
    $('#modal_signUp_key_submit').hide();
  } else if(kind == 'Y') {
    // 이메일 중복x
    $('#modal_signUp_true').slideDown();
    $('#modal_signUp_chkBtn').hide();
    $('#modal_signUp_email_auth').show();
    $('#modal_signUp_key_submit').hide();
  } else if(kind == 'I') {
    // 초기화
    modal_signUp_overlap = false;
    modal_signUp_key_check = false;
    $('#modal_signUp_chkBtn').show();
    $('#modal_signUp_email_auth').hide();
    $('#modal_signUp_key_submit').hide();
  }
}


/**
 * 이메일 인증 키 발송
 */
function fn_emailAuthCheck() {
  if(modal_signUp_overlap) {
    let email = $('#modal_signUp_usrEmail1').val() + '@' + $('#modal_signUp_usrEmail2').val(); 
    let url = fn_getContextPath()+'/cmmn/email-key';
    let data = {'email': email}
    fn_ajaxPOST(url, data, fn_emailAuthCheckCallback);
  } else {
    alert("이메일 중복확인이 완료되지 않았습니다.");
    fn_initEmailCheck();
  }
}
function fn_emailAuthCheckCallback(data) {
  let retCode = data.retCode;
  if(retCode > 0) {
    alert("인증키가 발송되었습니다.");
    $('#modal_signUp_email_auth').hide();
    $('#modal_signUp_key_submit').show();
//    $('#modal_signUp_email_auth_key').show();				input 대신에 tr.emailAuthKey를 엽니다.
	$('#emailAuthKey').show();
	
    
    $('#modal_signUp_usrEmail1').prop('disabled', true);
    $('#modal_signUp_usrEmail2').prop('disabled', true);
    $('#modal_signUp_usrEmail_Opt').prop('disabled', true);
  } else {
    let retMsg = data.retMsg;
    alert(retMsg);
  }
}


/**
 * 이메일 인증 키 비교
 */
function fn_compareEmailAuthKey() {
  if(modal_signUp_overlap) {
    let url = fn_getContextPath()+'/cmmn/email-key-auth';
    let data = {'key': $('#modal_signUp_email_auth_key').val()}
    fn_ajaxPOST(url, data, fn_compareEmailAuthKeyCallback);
  } else {
    alert("이메일 중복확인이 완료되지 않았습니다.");
    fn_initEmailCheck();
  }
}
function fn_compareEmailAuthKeyCallback(data) {
  let retCode = data.retCode;
  if(retCode > 0) {
    alert("인증이 완료되었습니다.");
    $('#modal_signUp_key_submit').hide();
//    $('#modal_signUp_email_auth_key').hide();				input 대신에 tr.emailAuthKey를 숨겨요.
	$('#emailAuthKey').hide();
    modal_signUp_key_check = true;
  } else {
    let retMsg = data.retMsg;
    alert(retMsg);
  }
}



//이벤트 function

/*
*	회원가입 신청 버튼 클릭 이벤트
*	부서 구분 조회 : C005
*/
function fn_signUp_openModal(){
	$('#modal_signUp_form')[0].reset();
  fn_setEmailAuthBtn('I');
  
	let url = fn_getContextPath() + '/cmmn/commonCode';
	let data = { 'cdId' : 'C005' };
	fn_ajaxPOST(url, data, initSignUpCallback);
	
	function initSignUpCallback(data) 
	{
		if ( data.length > 0 ) 
		{
			let html = '<option value="N">-선택-</option>';
			for (let i = 0; i < data.length; i++) 
			{
				let C005 = data[i];
				html += '<option value="' + C005.cd + '">' + C005.cd_nm + '</option>';
			}
			$('#modal_signUp_usrDept').html(html);
		}
	}
	
	//모달 Show
	$( "#dialog_signUpForm" ).dialog( "open" );
}


/*  
 *	연락처 항목에 숫자만 입력
	크롬에서  preventDefault 한글 적용 X, IE = O
 */	
function fn_numberKeydown(e){
	if 		( !( e.which < 48 || e.which > 57 ) ) 		e.returnValue;		// 키보드 상단 숫자 키 
	else if	( !( e.which < 96 || e.which > 105 ) )		e.returnValue;		// 숫자패드 숫자 키
	else if	( !( e.which < 8 || e.which > 9 ) )			e.returnValue;		// 탭 혹은 백스페이스 
	else{
		e.preventDefault();		 
	}													
}

/*  
 *	한글 방지를 위한 별도의 keyUp 이벤트 
 */	
function fn_numberKeyUp(e){
	let value = e.target.value;
	if( fn_chkOnlyKor(value) )	
		e.target.value = e.target.value.replace(korExp, "");
	else if ( fn_chkSpecialChar(value) )	
		e.target.value = e.target.value.replace(specialExp, "");	
}


