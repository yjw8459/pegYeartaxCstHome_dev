/**
 * 비밀번호 초기화 모달 폼
 */
function fn_initPasswordForm() {
  $('#modal_initPassword_form')[0].reset();
  $('#dialog_initPassword').dialog({
    autoOpen: true,
    height: 'auto',
    width: 930,
    modal: true
  });
}


/**
 * 이메일 도메인 초기화
 */
function fn_setEmailDoamin(obj) {
  var value = $(obj).val();
  $('#modal_initPwd_usr_email02').val(value).prop('disabled', (value == '' ? false : true));
}


/**
 * 이메일 조합
 */
function fn_setInitPassEmail() {
  let email = '';
  let temp01 = $('#modal_initPwd_usr_email01').val();
  let temp02 = $('#modal_initPwd_usr_email02').val();
  if(temp01 != '' && temp02 != '') {
    email = temp01 + '@' + temp02;
  }
  $('#modal_initPwd_usr_email').val(email);
}


/**
 * validation check
 */
function fn_initPwdPreCheck() {
  var usrName = $('#modal_initPwd_usr_name').val();
  if(usrName == '') {
    alert("이름을 입력해주세요.");
    $('#modal_initPwd_usr_name').focus();
    return false;
  }
  
  fn_setInitPassEmail();
  var usrEmail = $('#modal_initPwd_usr_email').val();
  if(usrEmail == '') {
    alert("이메일을 입력해주세요.");
    $('#modal_initPwd_usr_email01').focus();
    return false;
  } else {
    var valid = fn_emailRegCheck(usrEmail);
    if(!valid) {
      alert("이메일 형식이 올바르지 않습니다.");
      $('#modal_initPwd_usr_email01').focus();
      return false;
    }
  }
  
  return true;
}


/**
 * 비밀번호 초기화 요청
 */
function fn_initPassword() {
  if(fn_initPwdPreCheck()) {
    let url = fn_getContextPath()+'/cmmn/initPwd';
    let data = $('#modal_initPassword_form').serializeObject();
    fn_ajaxPOST(url, data, fn_initPasswordCallback);
  }
}
function fn_initPasswordCallback(data) {
  let retCode = data.retCode;
  if(retCode > 0) {
    alert("비밀번호 초기화가 완료되었습니다.\n변경 된 비밀번호는 이메일로 발송되었습니다.");
    if($('#dialog_initPassword').dialog('isOpen')) $('#dialog_initPassword').dialog('close');
  } else {
    let retMsg = data.retMsg;
    alert(retMsg);
  }
}