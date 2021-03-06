const korExp = /[ㄱ-ㅎㅏ-ㅣ가-힣]/g;
const specialExp = /[^가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]/gi;
const mailExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;


const AJAX_UTIL = {
	sendJson : (url, data, type = 'post', callback) => {
		$.ajax({
			url : fn_getContextPath() + url,
			type : type,
			contentType : 'application/json',
			data : JSON.stringify(data),
			success : callback,
			error : (x, e) => { fn_ajaxError(x, e) }
		});
	}
}

/**
 * 팝업창 띄우기
 *
 * @param width
 * @param height
 * @param url
 * @param windowName
 */
function popup(width, height, url, windowName) {
	let left = (screen.width - width) / 2;
	let top = ((screen.height - height) / 2) - 40;
	let attribute = "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top + ",status=yes,toolbar=no,location=no,menubar=no,scrollbars=yes,resizable=no";
	window.open(url, windowName, attribute);
}


function fn_print() {
	window.print();
}


function resizeContent() {
	let $hgtT1 = $(window).height() - 0;
	let $hgtT2 = $(window).height() - 96;
	let $hgtT3 = $(window).height() - 651;	
	$(".mainWrap").height($hgtT1);
	$(".contentsWrap, .leftMenuWrap, .contentsWrap .contents, .mainWrap .contentsWrap").height($hgtT2);
	//$(".contentsWrap ").height($hgtT3);
}


function fixDataOnWheel(val) {
	dataOnScroll(val);
}


function dataOnScroll(val) {
	let $body = $("#" + val.id);
	let $head = $body.siblings("div").children("div");
	let $leftBody = $body.parents().siblings("div").children("div:last-child");
	$head.scrollLeft($body.scrollLeft());
	$leftBody.scrollTop($body.scrollTop());
}










/**
	단순 value 유효성 검사
 */
function fn_basicValidator(value){
	return value ?? '';
}


/*
*		selector로 유효성 검사
		유효성 검사 실패 : true
		정상 값 입력 : false
 */

function fn_elementValidator(selectors){
	let result = false;
	selectors.forEach( (item) => {
		result = ! document.querySelector(item).value;
		if( result )	return ;  
	});
	return result;
}



function fn_replaceEditorValue(value){
	return value.replaceAll('<p>', '')
							.replaceAll('</p>', '')
							.replaceAll('&nbsp;', '')
							.replaceAll('<br>', '')
							.replaceAll(' ', '')
							.replaceAll('             ','');
}













function fn_getContextPath() {
	return $('#contextPath').val();
}


function fn_logout() {
	if(confirm("로그아웃 하시겠습니까?")) {
		location.href = fn_getContextPath()+'/cmmn/logout';
	}
}


function fn_browserCheck() {
	//익스플로러 체크
	var agent = navigator.userAgent.toLowerCase();
	if((navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1)) {
		return "ie";
	} else if(agent.indexOf("chrome") != -1) {
		return "chrome";
	} else if(agent.indexOf("safari") != -1) {
		return "safari";
	} else if(agent.indexOf("firefox") != -1) {
		return "firefox";
	}
}

// object의 tag를 리턴
function fn_htmlTagCheck(obj) {
	return $(obj).get(0).tagName.toLowerCase();
}

//메세지 출력 
function fn_messageConfirm(message){
	return confirm('게시물을 ' + message + '하시겠습니까?');
}


// paging 처리
function fn_setPagingNavigation(data) {
	let paging = data.paging;
	let pageNum = paging.pageNum;
	let totalCount = paging.totalCount;
	let firstPageNum = paging.firstPageNum;
	let prevPageNum = paging.prevPageNum;
	let nextPageNum = paging.nextPageNum;
	let finalPageNum = paging.finalPageNum;
	let startPageNum = paging.startPageNum;
	let endPageNum = paging.endPageNum;
	let html = '';
	if(totalCount > 0) {
		html +=	'<div class="page_Container">';
		html +=	'	<div class="paginate">';
		html += '		<a href="javascript:fn_pageMove('+firstPageNum+');" class="prevEnd"></a>';
		html += '		<a href="javascript:javascript:fn_pageMove('+prevPageNum+');" class="prev"></a>';
for(var i=startPageNum; i<=endPageNum; i++) {
		html += '		<a href="javascript:fn_pageMove('+i+');" class="'+(pageNum == i ? 'num_current' : 'num')+'">'+i+'</a>';
}
		html += '		<a href="javascript:javascript:fn_pageMove('+nextPageNum+');" class="next"></a>';
		html += '		<a href="javascript:javascript:fn_pageMove('+finalPageNum+');" class="nextEnd"></a>';
		html += '	</div>';
		html += '</div>';
	}
	$('#pageNavigation').html(html);
}


/**
 * 필수입력 체크
 */
function fn_requiredCheck(target) {
	let result = true;
	$(target).each(function() {
		if(result) {
			let isRequired = $(this).prop('required');
			if(isRequired) {
				let value = $(this).val();
				if(value == '') {
					var title = $(this).attr('title');
					alert(title + '은 필수입력 항목 입니다.');
					$(this).focus();
					result = false;
				}
			}
		}
	});
	return result;	
}


/**
 * 비밀번호 형식 체크
 */
function fn_pwdValidate(obj) {
	 let pw = obj.value;
   if(pw != '') {
		 let eng = pw.search(/[a-z]/ig);
		 let num = pw.search(/[0-9]/g);
		 let spe = pw.search(/[`~!@@#$%^&*()|₩₩₩'₩";:₩/?]/gi);
	
		 if(pw.length < 7 || pw.length > 20) {
			 alert("비밀번호는 7자리 ~ 20자리 이내로 입력해주세요.");
			 obj.value = '';
			 return false;
		 }
	
		 if(pw.search(/₩s/) != -1) {
			 alert("비밀번호는 공백없이 입력해주세요.");
			 obj.value = '';
			 return false;
		 }
     
     let count = 0;
     if(eng >= 0) count++;  // 영문
     if(num >= 0) count++;  // 숫자
     if(spe >= 0) count++;  // 특수문자
     if(count < 2) {
			 alert("비밀번호는 영문, 숫자, 특수문자를 혼합하여 입력해주세요.");
			 obj.value = '';
			 return false;
		 }
  }
  return true;
}


/**
 * 이메일 유효성 검사
 * @param value
 * @returns
 */
function fn_emailRegCheck(value) {
	var regExp = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	return regExp.test(value);
}


/**
 * 모바일 전화 번호 유효성 검사
 * @param value
 * @returns
 */
function fn_mobileNoRegCheck(value) {
	var regExp = /^\d{3}\d{3,4}\d{4}$/;
	return regExp.test(value);
}


/**
 * 일반 전화번호 유효성 검사
 * @param value
 * @returns
 */
function fn_telNoRegCheck(value) {
	var regExp = /^\d{2,3}\d{3,4}\d{4}$/;
	return regExp.test(value);
}


/**
 * 날짜형식 검사(년월일) 
 * @param value
 * @returns
 */
function fn_dateFormatCheck(date) {
	date = fn_setOnlyNumber(date);
	var regexp = /(19[0-9]{2}|2[0-9]{3})(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])/;
	return regexp.test(date);
}


/**
 * 숫자만 남기고 모두 제거
 */
function fn_setOnlyNumber(value) {
  return value.replace(/[^0-9]/g, "");
}


/* form submit전 disabled 제거 */
var formArray = new Array();
function fn_removeDisabled() {
  $('input, select, textarea').each(function() {
    if($(this).is(':disabled')) {
      $(this).prop('disabled', false);
      formArray.push($(this).attr('id'));
    }
  });
}


/* form submit후 disabled 추가 */
function fn_addDisabled() {
  for(var i=0; i<formArray.length; i++) {
    var id = formArray[i];
    $('#' + id).prop('disabled', true);
  }
}


/**
 * 공통코드 set
 */
function fn_setCommonCode(data, div) {
  let html = '<option value=""> 코드 선택 </option>';
  for(let i=0; i<data.length; i++) {
    let code = data[i];
    let cd = code.cd;
    let cdNm = code.cd_nm;
    html += '<option value="'+cd+'">'+cdNm+'</option>';
  }
  $(div).html(html);
}


/**
 * 숫자만 입력
 * onkeyup="fn_setInputOnlyNumber(this);"
 */
function fn_setInputOnlyNumber(obj) {
  var regexp = /[^0-9]/g;
  var value = $(obj).val().replace(regexp,"");
  $(obj).val(value);
}


/**
 * 연락처 set
 */
function fn_setModifyValueToSplit(gubun, value) {
  let result = new Array();
  if(value != null && value != '') {
    if(gubun == 'email') {
      if(fn_emailRegCheck(value)) {
        let email = value.split('@');
        let temp01 = email[0];
        let temp02 = email[1];
        result = {temp01, temp02};
      } else {
        alert("이메일 형식이 올바르지 않습니다.");
      }
    } else if(gubun == 'offTel') {
      if(fn_telNoRegCheck(value)) {
            let temp01, temp02, temp03;
            let size = value.length;
            if(size > 10) {
              // 11자리
              temp01 = value.substring(0, 3);
              temp02 = value.substring(3, 7);
              temp03 = value.substring(7, size);
            } else {
              // 10자리
              let prefix = value.substring(0, 2);
              if(prefix == '02') {
                temp01 = prefix;
                temp02 = value.substring(2, size-4);
                temp03 = value.substring(size-4, size);
              } else {
                temp01 = value.substring(0, 3);
                temp02 = value.substring(3, 6);
                temp03 = value.substring(6, size);
              }
            }
            result = {temp01, temp02, temp03};
      } else {
        alert("연락처(사무실) 형식이 올바르지 않습니다.");
      }
    } else if(gubun == 'usrTel') {
      if(fn_mobileNoRegCheck(value)) {
        let temp01, temp02, temp03;
        let size = value.length;
        if(size > 10) {
              // 11자리
          temp01 = value.substring(0, 3);
          temp02 = value.substring(3, 7);
          temp03 = value.substring(7, size);
        } else {
          temp01 = value.substring(0, 3);
          temp02 = value.substring(3, 6);
          temp03 = value.substring(6, size);
        }
        result = {temp01, temp02, temp03};
      } else { 
        alert("연락처(휴대전화) 형식이 올바르지 않습니다.");
      }
    }
  }
  return result;
}









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

/*
	datepicker active
*/

function fn_daterangepicker(selector){
	$(selector).daterangepicker({
		singleDatePicker: true,
		showDropdowns: true,
		locale:	{
			format:	'YYYY/MM/DD'
		}
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


/**
 * 전화번호 입력시 포커스 이동 
 */
function fn_setTelNumFocus(obj, target) {
  var lengthA = $(obj).attr("maxlength");
  var lengthB = $(obj).val().length;
  if(lengthA == lengthB) $(target).focus();
}










/*
 *	숫자가 아닌 값이 있을 경우 true 반환
 */ 
function fn_chkOnlyNumber(value){
	let chkStyle = /[^0-9]$/g;
	return chkStyle.test(value);
}

/*
 *	숫자가 아닌 값이 있을 경우 true 반환
 */ 
function fn_chkOnlyKor(value){
	let chkStyle = korExp;
	return chkStyle.test(value);
}




/*
 *	메일형식이 아닐경우 true
 */ 
function fn_chkMail(value){
	let chkStyle = mailExp;
	return !chkStyle.test(value);
}

/*
 *	특수문자가 있을 경우 true
 */
function fn_chkSpecialChar(value){
	let chkStyle = specialExp;
	return chkStyle.test(value);
}

function fn_checkedDetecting(_this,selector){
	if( _this.checked )	$(selector).val('Y');
	else								$(selector).val('N'); 
}
