/**
 * 조회
 */
function fn_search(page_num) {
  document.searchForm.page_num.value = page_num;
  let url = fn_getContextPath()+'/adm/brd-mng';
  let data = $('#searchForm').serializeObject();
  fn_ajaxPOST(url, data, fn_searchCallback);
}


/**
 * 사용여부 업데이트
 */
function fn_updateUseYn(brd_code, value) {
  let beforeValue = (value == 'Y' ? 'N' : 'Y');
  let confirmMsg = "사용여부를 변경하시겠습니까?("+beforeValue+" --> "+value+")";
  if(confirm(confirmMsg)) {
    var usrId = document.modal_board_form.upd_uno.value;
    let url = fn_getContextPath()+'/adm/brd-use';
    let data = {'brd_code': brd_code, 'use_yn': value, 'usr_id': usrId};
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
 * 게시판 추가/수정 모달
 */
function fn_openModalForm(brd_code) {
  let url = fn_getContextPath()+'/adm/brd-form';
  let data = {'brd_code': brd_code};
  fn_ajaxAyncPOST(url, data, fn_openModalFormCallback); 
}
function fn_openModalFormCallback(data) {
  let c008 = data.c008;
  let board = data.board;

  fn_setCommonCode(c008, '#modal_board_brd_type');
  fn_setBoardData(board);
  
  $('#dialog_boardForm').dialog('open');
}


/**
 * 업데이트 데이터 set
 */
function fn_setBoardData(data) {
  if(data != null) {
    let brdCode = data.brd_code;
    let brdName = data.brd_name;
    let brdType = data.brd_type;
    let pageSize = data.page_size;
    let atcYn = data.atc_yn;
    let atcNum = data.atc_num;
    let url = data.url;
    let inqOrd = data.inq_ord;
    
    $('#modal_board_brd_code').val(brdCode);
    $('#modal_board_brd_name').val(brdName);
    $('#modal_board_brd_type').val(brdType);
    $('#modal_board_page_size').val(pageSize);
    $('#modal_board_atc_yn').val(atcYn);
    $('#modal_board_atc_num').val(atcNum);
    $('#modal_board_url').val(url);
    $('#modal_board_inq_ord').val(inqOrd);
    $('.notModify').prop('disabled', true); // 수정불가항목
    brdUrlDupCheck = true;
    $('.btnCheck_item').hide();
    document.modal_board_form.save_cat.value = 'update';
  } else {
    $('#modal_board_form')[0].reset();
    $('.notModify').prop('disabled', false); // 수정불가항목
    brdUrlDupCheck = false;
    $('.btnCheck_item').show();
    document.modal_board_form.save_cat.value = 'insert';
  }
}


/**
 * 게시판 URL 중복 확인
 */
let brdUrlDupCheck = false;
function fn_brdUrlDupCheck() {
  $('.checking_Result').slideUp();
  var brdUrl = $('#modal_board_url').val();
  if(brdUrl == '') {
    alert("게시판 URL를 입력해주세요.");
    $('#modal_board_url').focus();
    brdUrlDupCheck = false;
    return false;
  }
  let url = fn_getContextPath()+'/adm/brd-dup';
  let data = {'brd_url': brdUrl};
  fn_ajaxAyncPOST(url, data, fn_usrIdDupCheckCallback); 
}
function fn_usrIdDupCheckCallback(data) {
  let retCode = data.retCode;
  if(retCode < 1) {
    $('#modal_board_true').slideDown();
    brdUrlDupCheck = true;
  } else {
    $('#modal_board_false').slideDown();
    brdUrlDupCheck = false;
  }
}


/**
 * 게시판 URL 변경시 중복확인 리셋
 */
function fn_dupCheckReset() {
  brdUrlDupCheck = false;
}


/**
 * submit pre check
 */
function fn_preCheck() {
  let result = fn_requiredCheck('#modal_board_form input, #modal_board_form select');
  if(result) {
    // URL 중복 확인
    if(!brdUrlDupCheck) {
      alert("게시판 URL 중복 확인이 필요합니다.");
      return false;
    }
  }
  return result;
}


/**
 * submit(insert or update)
 */
function fn_boardMngSubmit() {
  if(fn_preCheck()) {
    fn_removeDisabled();
    let url = fn_getContextPath()+'/adm/brd-save';
    let data = $('#modal_board_form').serializeObject();
    fn_ajaxAyncPOST(url, data, fn_boardMngSubmitCallback); 
  }
}
function fn_boardMngSubmitCallback(data) {
  let retCode = data.retCode;
  if(retCode > 0) {
    alert("저장이 완료되었습니다.");
    fn_search(1);
  } else {
    let retMsg = data.retMsg;
    alert(retMsg);
  }
  fn_addDisabled();
}