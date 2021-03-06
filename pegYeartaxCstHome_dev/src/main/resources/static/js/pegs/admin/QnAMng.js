function fn_search(page_num){
	document.searchForm.page_num.value = page_num;
	let from = document.querySelector("#from").value;
	let to = document.querySelector("#to").value;
	document.querySelector("#from").value = from.replaceAll(".", "");
	document.querySelector("#to").value = to.replaceAll(".", "");
	
	let url = '/adm/QnA-mng/search';
	let data = $("#searchForm").serializeObject();
	document.querySelector("#from").value = from;
	document.querySelector("#to").value = to;
	fn_ajaxPOST(url, data, fn_searchCallback);
}


function fn_searchCallback(data){
	let boardList = data.boardList;
	let page = data.paging;
	let pageNum = page.pageNum;
	let pageSize = page.pageSize;
	let totalCount = page.totalCount;
	//QnA 메인 
	let html = '';
	for(let i = 0; i< boardList.length; i++)
	{
		let board 	 = boardList[i];
		let brd_code = board.brd_code;
		let brd_idx  = board.brd_idx;
		let subject  = board.subject;
		let sac_yy   = board.sac_yy;
		let wrkNm 	 = board.wrk_cat_name;
		let qstNm 	 = board.qst_cat_name;
		let reqNm 	 = board.req_cat_name;
		let loginId  = board.login_id;
		let cstId 	 = board.cst_id;
		let answerId = board.answer_id;
		let lstSts 	 = board.lst_sts;
		let lstNm 	 = board.lst_sts_name;
		let qnaDtm 	 = board.qna_dtm;
		let compName = board.comp_name;
		let ent_uno  = board.ent_uno;
		let custName = board.cust_name;
		let answerName = board.answer_name;
		let answerDate = board.answer_dtm ?? '';
		let del_yn = board.del_yn;
		
		let index = totalCount - (( (pageNum - 1) * pageSize ) + i );
		//let onclick = fn_boardOnClick(board.lstSts, board.brdIdx);
		let eventElement = del_yn === 'Y' ? '<td>삭제</td>' : fn_eventElement(lstSts, brd_idx, brd_code);
		//함수로 lstSts를 보내고 
		html += '<tr>';
		html += '<td>' + index + '</td>';
		html += '<td>' + sac_yy + '</td>';
		html += '<td>' + wrkNm + '</td>';
		html += '<td><div class="ellipsis type3" title="' + qstNm + '">' + qstNm + '</div></td>';
		html += '<td class="subjectData" onclick="fn_detail(' + brd_idx + ');" title="' + subject + '"><div class="subject">' + subject + '</div></td>';
		html += '<td><div class="ellipsis type1" title="' + compName + '">' + compName + '</div></td>';
		html += '<td><div class="ellipsis type2" title="' + custName + '">' + custName + '</div></td>';
		html += '<td class="dateFormat">' + qnaDtm + '</td>';
		html += '<td>' + reqNm + '</td>';
		//html += '<td><div class="ellipsis type2" title="' + ent_uno + '">' + ent_uno + '</div></td>';
		html += '<td><div class="ellipsis type2" title="' + answerName + '">' + answerName + '</div></td>';
		html += '<td class="dateFormat">' + answerDate.substring(0, 8) + '</td>';
		html += '<td class="lstPotinter" onclick="fn_search_sts(' + brd_idx + ',\'' + brd_code + '\')">' + lstNm + '</td>';
		html += eventElement;
		html += '</tr>';
	}
	
	if(  boardList.length < 1 ){
		html += '<tr><td colspan="11">No Data has been found.</td></tr>'
	}
	
	$('#QnA_main_table tbody').html(html);
	
	let startPageNum = page.startPageNum;
	let prevPageNum = page.prevPageNum;
	let endPageNum = page.endPageNum;
	let nextPageNum = page.nextPageNum;
	let finalPageNum = page.finalPageNum;
	
	html = '';
	if(  boardList.length > 0 ){
		html += '<div class="paginate">';
		html += '<a href="javascript:fn_pageMove(' + startPageNum + ');" class="prevEnd"></a>';
		html += '<a href="javascript:fn_pageMove(' + prevPageNum + ');" class="prev"></a>';
		for (var i = startPageNum; i <= endPageNum; i++) {
			let className = i == pageNum ? 'num_current' : 'num';
			html += '<a href="javascript:fn_pageMove(' + i + ');" class="' + className + '">' + i + '</a>';
		}
		html += '<a href="javascript:fn_pageMove(' + nextPageNum + ');" class="next"></a>';
		html += '<a href="javascript:fn_pageMove(' + finalPageNum + ');" class="nextEnd"></a>';
		html += '</div>';
	}
	
	$('#pageNavigation').html(html); 
	$('#pageBox').html(html);
}

function fn_pageMove(page_num) {
	fn_search(page_num);
}

//lstSts 상태 값에 따라 다른 Button 교환
function fn_eventElement(lstSts, idx, brd_code){
	if( lstSts == '01' )
	{
		return '<td><div class="btnChecking" onclick="fn_confirmSts(' + idx + ',\'11\');">접수</div></td>';
	}
	else if( lstSts == '11' )
	{
		return '<td><div class="btnChecking cancel" onclick="fn_confirmSts(' + idx + ',\'01\')" >접수 취소</div></td>';
	}
	
	else if ( lstSts == '21' )
	{
		return '<td></td>';
	}
	else if ( lstSts == '31' )
	{
		return '<td></td>';	
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

function fn_updateSts(data, callBack){
	let url = fn_getContextPath() + '/adm/QnA-mng/confirm';
	fn_ajaxPOST(url, data, callBack);
}


function fn_searchFormReset() {
	location.href = '/adm/QnA-mng/reset';
	//$('#searchForm')[0].reset();
}




//DEL_YN
function fn_deleteFile(brd_code, brd_idx, file_idx){
	let url = fn_getContextPath() + '/cmmn/file_del';
	let data = {
			'brd_code' : brd_code,
			'brd_idx' : brd_idx,
			'file_idx' : file_idx
	};
	fn_ajaxPOST(url, data, fn_callBack);
	
	function fn_callBack(data){
		let retCode = data.retCode;
		if ( retCode > 0 ) 	{
			alert('삭제되었습니다.');
			location.reload();
		}
		else 				alert(data.retMsg);
		
	}
}



//직접등록 회원찾기 
/**
 * 사용자 추가/수정 모달
 */



/*
function fn_openModalForm(cst_id, comp_code, usr_id) {
	$('#modal_findUser_form')[0].reset();
  	let url = fn_getContextPath()+'/adm/mem-form';
  	let data = {'cst_id': cst_id, 'comp_code': comp_code, 'usr_id': usr_id};
  	fn_ajaxAyncPOST(url, data, fn_openModalFormCallback); 
} 

function fn_openModalFormCallback(data){
	let cstList = data.cstList;
	let html = '<option value="">-선택-</option>';
	for( let i = 0; i < cstList.length; i++ ){
		let cst = cstList[i];
		html += '<option value="' + cst.cst_id + '">';
		html += cst.cst_nm;
		html += '</option>';
	}
	$('#modal_findUser_cstName').html(html);
	$('#dialog_findUserForm').dialog("open");
}
*/
/*//고객사 값 변경 시 function
function fn_searchCompCode(){
	let cst_id = $('#modal_findUser_cstName').val();
	if( '' == cst_id )		return ;
	
	let url = fn_getContextPath()+'/adm/comp-code';
  	let data = {'cst_id': cst_id};
  	fn_ajaxAyncPOST(url, data, fn_searchCompCodeCallback); 
}

function fn_searchCompCodeCallback(data){
	let compList = data.compList;
	let html = '<option value="">-선택-</option>';
	
	for(let i = 0; i < compList.length; i++ ){
		let comp = compList[i];
		
		html += '<option value="' + comp.comp_code + '">';
		html += comp.comp_nm;
		html += '</option>';
	}
	$('#modal_findUser_compName').html(html);
	$('#modal_findUser_compName').attr('disabled', false);
}

//사업장 값 변경 시 function
function fn_searchUsers(){
	let cst_id = $('#modal_findUser_cstName').val();
	let comp_code = $('#modal_findUser_compName').val();
	if( '' == comp_code || '' == cst_id )		return ;
	
	let url = fn_getContextPath()+'/adm/comp-usr';
  	let data = { 'cst_id': cst_id, 'comp_code' : comp_code };
  	fn_ajaxAyncPOST(url, data, fn_searchUsersCallback); 
}

function fn_searchUsersCallback(data){
	let usrList = data.usrList;
	let html = '<option value="">-선택-</option>';
	for(let i = 0; i < usrList.length; i++ ){
		let usr = usrList[i];
		
		html += '<option value="' + usr.usr_id + '">';
		html += usr.usr_name;
		html += '</option>';
	}
	if( 1 > usrList.length )	html = '<option value ="">정보없음</option>'
	$('#modal_findUser_usrName').html(html);
	$('#modal_findUser_usrName').attr('disabled', false);
}*/


/*function fn_setComplete(){
	let $cst = $('#modal_findUser_cstName');
	let $comp = $('#modal_findUser_compName');
	let $usr = $('#modal_findUser_usrName');
	let cst_name = $cst.find('option:checked').text();
	let comp_name = $comp.find('option:checked').text();
	let usr_name = $usr.find('option:checked').text();
	
	$('#direct_cst_id').val($cst.val());
	$('#direct_comp_code').val($comp.val());
	$('#direct_ent_uno').val($usr.val());
	$('#cstNameBox').html(cst_name);
	$('#compNameBox').html(comp_name);
	$('#usrNameBox').html(usr_name);
	
	fn_modalClose('dialog_findUserForm');
}*/



//접수 대기중 상태 이벤트 처리 함수 
function fn_detail(brd_idx){
//	location.href =  fn_getContextPath() + '/adm/QnA-mng/form?brd_idx=' + brd_idx;
	let f = document.searchForm;
	f.brd_idx.value = brd_idx;
	f.action = fn_getContextPath() + '/adm/QnA-mng/form';
	f.method = 'GET';
	//f.method = 'POST';
	f.submit();
}

