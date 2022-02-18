function fn_searchFormReset() {
	$('#searchForm')[0].reset();
}


function fn_search(page_num) {
	document.searchForm.page_num.value = page_num;
	let url = fn_getContextPath()+'/brd/list';
	let data = $('#searchForm').serializeObject();
	fn_ajaxPOST(url, data, fn_searchCallback);
}

function fn_boardForm(brd_code, brd_idx) {
	if ( brd_idx != '0' ) {
		let confirmYn = fn_messageConfirm('수정');
		if ( !confirmYn ) 	return ;
	}
	let f = document.searchForm;
	f.action = fn_getContextPath()+'/brd/form';
	f.method = 'post';
	f.brd_code.value = brd_code;
	f.brd_idx.value = brd_idx;	 
	f.brd_cat.value = '';
	f.submit();
}


function fn_delete(brd_code, brd_idx) {
	let confirmYn = fn_messageConfirm('삭제');
	if ( confirmYn ) {
		let url = fn_getContextPath()+'/brd/delete';
		let usr_id = $('#usr_id').val();
		let data = {
				'brd_code' : brd_code,
				'brd_idx' : brd_idx,
				'usr_id' : usr_id
		}
		fn_ajaxPOST(url, data, fn_deleteCallback);
	}
}