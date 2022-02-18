/*
	QnA 조회
*/
function fn_qna_search(page_num) {
	document.searchForm.page_num.value = page_num;
	fn_initShrValue();
	let url = fn_getContextPath()+'/qna/search';
	let data = $('#searchForm').serializeObject();
	fn_ajaxPOST(url, data, fn_qna_searchCallback);
}


function fn_qnaForm(brd_code, brd_idx){
	if( brd_idx != '0' )
	{
		let result = fn_messageConfirm('수정');
		if( !result )		return false;
	}
	
	let f = document.searchForm;
	f.brd_code.value = brd_code;
	f.brd_idx.value = brd_idx;
	f.action = fn_getContextPath() + '/qna/form';
	f.method = 'POST';
	f.submit();
	
}

function fn_qna_delete(brd_code, brd_idx){
	let result = confirm("접수하신 문의를 삭제하시겠습니까?");
	let usr_id = $('#usr_id').val();
	if(result)
	{
		let url = fn_getContextPath() + '/qna/delete';
		let data = {
			'brd_code' : brd_code,
			'brd_idx' : brd_idx,
			'ent_uno' : usr_id
		};
		fn_ajaxPOST(url, data, fn_deleteCallback);
	}
}






function fn_search_sts(brd_idx, brd_code){
	let url = fn_getContextPath() + '/qna/stsList';
	let data = {
		'brd_code' : brd_code,
		'brd_idx' : brd_idx
	};
	fn_ajaxPOST(url, data, fn_stsCallback);
}


/*
	진행상태 모달 호출
*/
function fn_stsCallback(data){
	let stsList = data.stsList;
	let html = '';
	for( let i = 0; i < stsList.length; i++ ){
		let sts = stsList[i];
		html += '<tr>';
		html += '<th class="col_1">' + (i+1) + '</th>';
		html += '<th class="col_2">상태</th>';
		html += '<td class="col_3">' + sts.brd_sts_name + '</td>';
		html += '<th class="col_2">승인자</th>';
		html += '<td class="col_3">' + sts.ent_uno+ '</td>';
		html += '<th class="col_2">승인일시</th>';
		html += '<td class="col_3">' + sts.ent_dtm+ '</td>';
		html += '</tr>';
	}
	$('#modal_sts_table tbody').html(html);
	$('#dialog_stsForm').dialog("open");
}

function fn_searchFormReset() {
	location.href = '/brd/list/reset?brd_cat=QnA';
	//$('#searchForm')[0].reset();
}


function fn_initShrValue(){
	if( document.querySelector('#shr_yn').checked )		document.querySelector('#shr_yn_hidden').disabled = true;
	else												document.querySelector('#shr_yn_hidden').disabled = false;
}
