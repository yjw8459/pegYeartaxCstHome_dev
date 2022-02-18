//게시판 관리 & 회원 관리 modalSubmit 
function fn_modalSubmit(formDiv){
	
	let result = fn_modalValidator();
	if( !result ) return;
	
	//member일 경우 submit 전처리 funciton 호출
	if( formDiv == 'member' )	
		if( !fn_submitPreproc_member() )	return false;
	
	let formName = 'modal_' + formDiv + '_form';
	let form = document.querySelector('#'+formName);
	let formData = new FormData(form);	
	
	$.ajax({
		url : '/' + formDiv + '/service/save',
		type : 'POST',
		data : formData,
		contentType : false,
		processData : false,
		success : function(data){
			if( data > 0 )				alert('저장되었습니다.')
			$( "#dialog_" + formDiv + "Form" ).dialog('close');
			fn_search();
		},
		error : function(){
			alert('저장 실패.');
		}
	})
	
}


function fn_dateFormat(value){
	return moment(value).format('YYYY/MM/DD');
}

/*
*	name으로 체크 여부 true / false
 */
function fn_isCheckedByName(name){
	let result = false;
	document.getElementsByName(name).forEach( (item) => {
		if( item.checked )		result = true;  
	} )
	return result;
}
