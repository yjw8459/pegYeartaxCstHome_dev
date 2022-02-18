/**
 * 조회
 */
function fn_search(page_num) {
  document.searchForm.page_num.value = page_num;
  let url = fn_getContextPath()+'/adm/mem-mng';
  let data = $('#searchForm').serializeObject();
  fn_ajaxPOST(url, data, fn_searchCallback);
}


/**
 * 사용여부 업데이트
 */
function fn_updateUseYn(cst_id, comp_code, usr_id, value) {
  let beforeValue = (value == 'Y' ? 'N' : 'Y');
  let confirmMsg = "사용여부를 변경하시겠습니까?("+beforeValue+" --> "+value+")";
  if(confirm(confirmMsg)) {
    let url = fn_getContextPath()+'/adm/mem-use';
    let data = {'cst_id': cst_id, 'comp_code': comp_code, 'usr_id': usr_id, 'use_yn': value};
    fn_ajaxPOST(url, data, fn_updateUseYnCallback);
  }
}
function fn_updateUseYnCallback(data) {
  let retCode = data.retCode;
  if(retCode > 0) {
    alert("변경이 완료되었습니다.");
  } else {
    let retMsg = data.retMsg;
    alert(retMsg);
    fn_search(1);    
  }
}


/**
 * 사용자 추가/수정 모달
 */
function fn_openModalForm(cst_id, comp_code, usr_id) {
  let url = fn_getContextPath()+'/adm/mem-form';
  let data = {'cst_id': cst_id, 'comp_code': comp_code, 'usr_id': usr_id};
  fn_ajaxAyncPOST(url, data, fn_openModalFormCallback); 
}
function fn_openModalFormCallback(data) {
  let c005 = data.c005;
  let c006 = data.c006;
  let cstList = data.cstList;
  let member = data.member;

  fn_setCommonCode(c006, '#modal_member_usr_cat');
  fn_setCommonCode(c005, '#modal_member_usr_dept');
  fn_setCstId(cstList);
  fn_setMemberData(member);
  fn_setDateFormat();
  
  $('#dialog_memberForm').dialog('open');
}


/**
 *고객사 set
 */
function fn_setCstId(data) {
  let html = '<option value=""> 코드 선택 </option>';
  for(let i=0; i<data.length; i++) {
    let cst = data[i];
    let cstId = cst.cst_id;
    let cstNm = cst.cst_nm;
    html += '<option value="'+cstId+'">'+cstNm+'</option>';
  }
  $('#modal_member_cst_id').html(html);
}


/**
 * 고객사에 맞는 사업장 set
 */
function fn_setCompCode(cst_id) {
  let url = fn_getContextPath()+'/adm/comp-code';
  let data = {'cst_id': cst_id};
  fn_ajaxAyncPOST(url, data, fn_setCompCodeCallback); 
}
function fn_setCompCodeCallback(data) {
  var compList = data.compList;
  let html = '<option value=""> 코드 선택 </option>';
  for(let i=0; i<compList.length; i++) {
    let comp = compList[i];
    let compCode = comp.comp_code;
    let compNm = comp.comp_nm;
    html += '<option value="'+compCode+'">'+compNm+'</option>';
  }
  $('#modal_member_comp_code').html(html);
}


/**
 * 사업장 이름 set
 */
function fn_setCompName(value) {
  let compName = '';
  if(value != '') {
    compName = $("#modal_member_comp_code option:checked").text()
  }
  $('#modal_member_comp_name').val(compName);
}


/**
 * 업데이트 데이터 set
 */
function fn_setMemberData(data) {
  if(data != null) {
    let cstId = data.cst_id;
    let compCode = data.comp_code;
    let compName = data.comp_name;
    let usrId = data.usr_id;
    let usrName = data.usr_name;
    let usrCat = data.usr_cat;
    let usrEmail = data.usr_email;
    let offTel = data.off_tel;
    let usrTel = data.usr_tel;
    let usrDept = data.usr_dept;
    let strDt = data.str_dt;
    let endDt = data.end_dt;
    
    fn_setCompCode(cstId);
    
    let retArr;
    retArr = fn_setModifyValueToSplit('email', usrEmail);
    $('#modal_member_email_temp01').val(retArr.temp01);
    $('#modal_member_email_temp02').val(retArr.temp02);
    $('#modal_member_email_domain').val('').prop('disabled', false);
    
    retArr = fn_setModifyValueToSplit('offTel', offTel);
    $('#modal_member_off_tel01').val(retArr.temp01);
    $('#modal_member_off_tel02').val(retArr.temp02);
    $('#modal_member_off_tel03').val(retArr.temp03);   
    
    retArr = fn_setModifyValueToSplit('usrTel', usrTel);
	  $('#modal_member_usr_tel01').val(retArr.temp01);
	  $('#modal_member_usr_tel02').val(retArr.temp02);
	  $('#modal_member_usr_tel03').val(retArr.temp03);    
    
    $('#modal_member_cst_id').val(cstId);
    $('#modal_member_comp_code').val(compCode);
    $('#modal_member_comp_name').val(compName);
    $('#modal_member_usr_id').val(usrId);
    $('#modal_member_usr_email').val(usrEmail);
    $('#modal_member_usr_name').val(usrName);
    $('#modal_member_usr_cat').val(usrCat);
    $('#modal_member_off_tel').val(offTel);
    $('#modal_member_usr_tel').val(usrTel);
    $('#modal_member_usr_dept').val(usrDept);
    $('#modal_member_str_dt').val(strDt);
    $('#modal_member_end_dt').val(endDt);
    $('.notModify').prop('disabled', true); // 수정불가항목
    memberDupCheck = true;
    $('.btnCheck_item').hide();
    document.modal_member_form.save_cat.value = 'update';
  } else {
    $('#modal_member_form')[0].reset();
  $('#modal_member_usr_cat').val('01');
//  $('#modal_member_usr_cat').val('01').prop('selected', true);
    $('.notModify').prop('disabled', false); // 수정불가항목
    memberDupCheck = false;
    $('.btnCheck_item').show();
    document.modal_member_form.save_cat.value = 'insert';
  }
}


/**
 * 이메일 도메인 초기화
 */
function fn_setMemberEmail(obj) {
  var value = $(obj).val();
  $('#modal_member_email_temp02').val(value).prop('disabled', (value == '' ? false : true));
}


/**
 * 이메일/전화번호 문자 조합
 */
function fn_setFullValue() {
  let fullEmail = '';
  let email01 = $('#modal_member_email_temp01').val();
  let email02 = $('#modal_member_email_temp02').val();
  if(email01 != '' && email02 != '') {
	  fullEmail = email01 + '@' + email02;
  }
  $('#modal_member_usr_email').val(fullEmail);
  $('#modal_member_usr_id').val(fullEmail);
  
  let offTel01 = $('#modal_member_off_tel01').val();
  let offTel02 = $('#modal_member_off_tel02').val();
  let offTel03 = $('#modal_member_off_tel03').val();
  let fullOffTel = offTel01 + offTel02 + offTel03;
  $('#modal_member_off_tel').val(fullOffTel);
  
  let usrTel01 = $('#modal_member_usr_tel01').val();
  let usrTel02 = $('#modal_member_usr_tel02').val();
  let usrTel03 = $('#modal_member_usr_tel03').val();
  let fullUsrTel = usrTel01 + usrTel02 + usrTel03;
  $('#modal_member_usr_tel').val(fullUsrTel);
}


/**
 * 아이디 중복 확인
 */
let memberDupCheck = false;
function fn_usrIdDupCheck() {
  fn_setFullValue();
  $('.checking_Result').slideUp();
  var usrId = $('#modal_member_usr_id').val();
  if(usrId == '') {
    alert("아이디를 입력해주세요.");
    memberDupCheck = false;
    return false;
  }
  let url = fn_getContextPath()+'/adm/usr-dup';
  let data = {'usr_id': usrId};
  fn_ajaxAyncPOST(url, data, fn_usrIdDupCheckCallback); 
}
function fn_usrIdDupCheckCallback(data) {
  let retCode = data.retCode;
  if(retCode < 1) {
    $('#modal_member_true').slideDown();
    memberDupCheck = true;
  } else {
    $('#modal_member_false').slideDown();
    memberDupCheck = false;
  }
}


/**
 * 아이디 변경시 중복확인 리셋
 */
function fn_dupCheckReset() {
  memberDupCheck = false;
}


/**
 * submit pre check
 */
function fn_preCheck() {
  let result = fn_requiredCheck('#modal_member_form input, #modal_member_form select');
  if(result) {
    // 아이디 중복 확인
    if(!memberDupCheck) {
      alert("아이디 중복 확인이 필요합니다.");
      return false;
    }
    // 이메일 유효성 확인
    let email = $('#modal_member_usr_email').val();
    if(!fn_emailRegCheck(email)) {
      alert("이메일 형식이 올바르지 않습니다.");
      return false;
    }
    // 사무실 or 휴대전화 둘 중 하나는 필수
    let offTel = $('#modal_member_off_tel').val();
    let usrTel = $('#modal_member_usr_tel').val();
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
    // 사용기한 체크
    let strDt = $('#modal_member_str_dt').val();
    let endDt = $('#modal_member_end_dt').val();
    if(!fn_dateFormatCheck(strDt) || !fn_dateFormatCheck(endDt)) {
      alert("날짜형식이 올바르지 않습니다.");
      return false;
    }
    if(strDt > endDt) {
      alert('사용 시작 일자가 종료 일자보다 클 수 없습니다.');
      return false;
    }
    // CST_ID 확인    
    var usrCat = $('#modal_member_usr_cat').val();
    if(usrCat == '99') {
      var cstId = $('#modal_member_cst_id').val();
      if(cstId != 'ADJUST2') {
        alert("관리자로 선택할 수 없는 사업장 입니다.");
        return false;
      }
    }
  }
  return result;
}


/**
 * submit(insert or update)
 */
function fn_memberMngSubmit() {
  fn_setFullValue();
  if(fn_preCheck()) {
    // 날짜 포멧 제거
    fn_removeDateFormat();
    fn_removeDisabled();
    let url = fn_getContextPath()+'/adm/mem-save';
    let data = $('#modal_member_form').serializeObject();
    fn_ajaxAyncPOST(url, data, fn_memberMngSubmitCallback); 
  }
}
function fn_memberMngSubmitCallback(data) {
  let retCode = data.retCode;
  if(retCode > 0) {
    alert("작업이 완료되었습니다.");
    fn_search(1);
  } else {
    let retMsg = data.retMsg;
    alert(retMsg);
  }
  fn_setDateFormat();
  fn_addDisabled();
  
  if($('#dialog_memberForm').dialog('isOpen')) $('#dialog_memberForm').dialog('close');
}


/**
 * 날짜 포멧 추가
 */
function fn_setDateFormat() {
  $('.mask_date').mask('9999/99/99');
}


/**
 * 날짜 포멧 제거
 */
function fn_removeDateFormat() {
  $('.mask_date').unmask().each(function() {
    var value = $(this).val();
    $(this).val(fn_setOnlyNumber(value));
  });
}



function fn_setUsrCat(obj) {
  var usrCat = $(obj).val();
  if(usrCat == '99') {
    if(!confirm("이 사용자를 관리자로 지정 하시겠습니까?")) {
      $(obj).val('01');
    }
  }
}
