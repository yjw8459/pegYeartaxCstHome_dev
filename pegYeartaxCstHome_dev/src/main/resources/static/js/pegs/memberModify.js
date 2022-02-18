/**
 * 회원정보변경 폼
 */
function fn_modifyUserData() {
  fn_setMemberModifyData();
  $('#dialog_memberModifyForm').dialog({
    autoOpen: true,
      height: 'auto',
      width: 830,
      modal: true
  });
}


/**
 * 회원정보변경 폼 초기화
 */
function fn_setMemberModifyData() {
    let url = fn_getContextPath()+'/mem/usr-data';
    let data = '';
    fn_ajaxPOST(url, data, fn_setMemberModifyDataCallback);
}
function fn_setMemberModifyDataCallback(data) {
  $('#modal_member_modify_form')[0].reset();
  var user = data.user;
  var usrName = user.usr_name;
  var offTel = user.off_tel;
  var usrTel = user.usr_tel;
  
  $('#modal_member_modify_usr_name').val(usrName);
  $('#modal_member_modify_off_tel').val(offTel);
  $('#modal_member_modify_usr_tel').val(usrTel);
  
  let retArr = fn_setModifyValueToSplit('offTel', offTel);
    $('#modal_member_modify_off_tel01').val(retArr.temp01);
    $('#modal_member_modify_off_tel02').val(retArr.temp02);
    $('#modal_member_modify_off_tel03').val(retArr.temp03);
    
    retArr = fn_setModifyValueToSplit('usrTel', usrTel);
  $('#modal_member_modify_usr_tel01').val(retArr.temp01);
  $('#modal_member_modify_usr_tel02').val(retArr.temp02);
  $('#modal_member_modify_usr_tel03').val(retArr.temp03);
    
  $('#modal_member_modify_usr_pwd').attr('onchange', "fn_pwdValidate(this);");
  $('#modal_member_modify_usr_pwd_recheck').attr('onchange', "fn_passwordkRecheck();");
}


/**
 * 비밀번호 확인
 */
function fn_passwordkRecheck() {
  let org = $('#modal_member_modify_usr_pwd').val();
  if(org != '') {
    let recheck = $('#modal_member_modify_usr_pwd_recheck').val();
    if(org != recheck) {
      alert("비밀번호가 일치하지 않습니다.");
      $('#modal_member_modify_usr_pwd_recheck').val('').focus();
      return false;
    }
    
  } 
  return true;
}


function fn_memberModifySubmitPreCheck() {
  let usrName = $('#modal_member_modify_usr_name').val();
  if(usrName == '') {
    alert("이름을 입력해주세요.");
    return false;
  }
  
    // 사무실 or 휴대전화 둘 중 하나는 필수
    let offTel = $('#modal_member_modify_off_tel').val();
    let usrTel = $('#modal_member_modify_usr_tel').val();
    if(offTel == '' && usrTel == '') {
      alert("전화번호 또는 모바일번호 중 한가지는 필수입력 항목 입니다.");
      return false;
    }
    if(offTel != '') {
      if(!fn_telNoRegCheck(offTel)) {
        alert("전화 번호 형식이 올바르지 않습니다.");
        return false;
      }
    }
    if(usrTel != '') {
      if(!fn_mobileNoRegCheck(usrTel)) {
        alert("모바일 번호 형식이 올바르지 않습니다.");
        return false;
      }
    }
  return true;
}

function fn_memberModifySubmit() {
  if(fn_passwordkRecheck()) {
    if(fn_memberModifySubmitPreCheck()) {
        let url = fn_getContextPath()+'/mem/usr-save';
        let data = $('#modal_member_modify_form').serializeObject();
        fn_ajaxPOST(url, data, fn_memberModifySubmitCallback);
    }
  }
}

function fn_memberModifySubmitCallback(data) {
  let retCode = data.retCode;
  if(retCode > 0) {
    alert("저장이 완료되었습니다.\n변경 된 항목은 다음 로그인부터 적용이 됩니다.");
    if($('#dialog_memberModifyForm').dialog('isOpen')) $('#dialog_memberModifyForm').dialog('close');
  } else {
    let retMsg = data.retMsg;
    alert(retMsg);
  }
}