<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/jstl.jsp" %>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<link type="text/css" rel="stylesheet" href="${contextPath }/resources/css/basic.css" />
<link type="text/css" rel="stylesheet" href="${contextPath }/resources/css/yeartaxhelp.css" />
<link type="text/css" rel="stylesheet" href="${contextPath }/resources/css/jquery-ui.css" />
<link type="text/css" rel="stylesheet" href="${contextPath }/resources/css/daterangepicker.css" />
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/moment.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/daterangepicker.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/jquery-ui.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/jquery.mask.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/common.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/ajaxUtil.js"></script>
<script type="text/javascript" charset="utf-8" src="${contextPath }/resources/js/pegs/messageUtil.js"></script>
<script type="text/javascript" src="${contextPath }/resources/js/pegs/admin/QnAMng.js"></script>
<script type="text/javascript">
let tabIndex = 0;

$(function(){
	fn_distInit();
	fn_distList();
});

function fn_distList(){
	
	const callback = (result) => {
		const list = result.list;
		let html = '';
		
		list.forEach((item) => {
			html += '<tr class="distRow">';
			html += '	<td><input type="text" class="inputBox" value="' + fn_basicValidator(item.cst_id) + '"></td>';
			html += '	<td><input type="text" class="inputBox" value="' + fn_basicValidator(item.cst_nm) + '"></td>';
			html += '	<td><input type="text" class="inputBox" value="' + fn_basicValidator(item.new_yn) + '"></td>';
			html += '	<td><input type="text" class="inputBox dateTarget" value="' + fn_basicValidator(item.cm001)  + '"></td>';
			html += '	<td><input type="text" class="inputBox dateTarget" value="' + fn_basicValidator(item.cm002)  + '"></td>';
			html += '	<td><input type="text" class="inputBox dateTarget" value="' + fn_basicValidator(item.cm004)  + '"></td>';
			html += '	<td><input type="text" class="inputBox dateTarget" value="' + fn_basicValidator(item.cm003)  + '"></td>';
			html += '	<td><input type="checkbox"' + ( item.md001 === 'Y' ? 'checked="checked"' : '' )   + '></td>';
			html += '	<td><input type="checkbox"' + ( item.md002 === 'Y' ? 'checked="checked"' : '' )   + '></td>';
			html += '	<td><input type="checkbox"' + ( item.md003 === 'Y' ? 'checked="checked"' : '' )   + '></td>';
			html += '	<td><input type="checkbox"' + ( item.md004 === 'Y' ? 'checked="checked"' : '' )   + '></td>';
			html += '	<td><input type="checkbox"' + ( item.md005 === 'Y' ? 'checked="checked"' : '' )   + '></td>';
			html += '</tr>'; 
		});
		
		if ( list.length < 1 ) html += '<tr><td colspan="12">????????? ????????? ????????????.</td></tr>';
		
		$('#distTable tbody').html(html);
		const distRows = document.querySelectorAll('.distRow');
		distRows.forEach( distRow => {
			distRow.addEventListener('change', (event) => { 
				event.target.parentNode.parentNode.classList.add('update'); 
			});
		});
		//fn_daterangepicker('.dateTarget'); daterangepicker ????????? ???
	}
	
	const url = fn_getContextPath() + '/adm/dist';
	const data = $('#distForm').serializeObject();
	fn_ajaxPOST(url, data, callback);
}


function fn_distInit(){
	document.querySelectorAll('.tablinks')[tabIndex].click();
}


function openCity(evt, cityName) {
	var i, tabcontent, tablinks;
	tabcontent = document.getElementsByClassName("tabcontent");
	for (i = 0; i < tabcontent.length; i++) {
	  tabcontent[i].style.display = "none";
	}
	tablinks = document.getElementsByClassName("tablinks");
	for (i = 0; i < tablinks.length; i++) {
	  tablinks[i].className = tablinks[i].className.replace(" active", "");
	}
	document.getElementById(cityName).style.display = "block";
	evt.currentTarget.className += " active";
}

function fn_distSave(){
	
}

</script>
<style>
/* Style the tab */
.tab {
  overflow: hidden;
  border: 1px solid #ccc;
  background-color: #f1f1f1;
  clear:both;
}

/* Style the buttons inside the tab */
.tab button {
  background-color: inherit;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  transition: 0.3s;
  font-size: 16px;
  
}

/* Change background color of buttons on hover */.
.tab button:hover {
  background-color: #ddd;
}

/* Create an active/current tablink class */
.tab button.active {
  background-color: #508CF7;
  color:#fff;
}

/* Style the tab content */
.tabcontent {
  display: none;
  padding: 6px 12px;
  border: 1px solid #ccc;
  border-top: none;
}
.tabcontent table{width:100%;}

.year{height:25px; margin-bottom:20px; float:left;}
.year input {display:inline-block; float:left;}
.ttx{font-size:16px; line-height:40px;}
.btnn2{float:right; width:60px; height:40px; cursor:pointer; display:inline-block; margin-right:1%; line-height:40px; text-align:center; background:#508CF7; border:1px solid #508CF7; box-shadow:1px 2px 0 #eee; border-radius:5px;}
.btnn1{float:right; width:60px; height:40px; cursor:pointer; display:inline-block; margin-right:1%; line-height:40px; text-align:center; background:#efefef; border:1px solid #ccc; box-shadow:1px 2px 0 #eee; border-radius:5px;}
.btnn2 a{width:60px; height:40px; text-decoration:none; color:#fff; font-size:16px; font-weight:bold;}
.btnn1 a{width:60px; height:40px; text-decoration:none; color:#181818; font-size:16px; font-weight:bold;}
.btnn a:hover {opacity:0.8;}

.tabcontent table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}
.tabcontent td, th {
  /*width:8.33%;*/
  border: 1px solid #dddddd;
  text-align: center;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #dddddd;
}

.inputBox{width:90%; margin:1% auto; height:25px; font-size:12px;}

</style>
</head>
<%@ include file="/WEB-INF/jsp/common/modalMessage.jsp" %>
<body class="yeartaxHelp_main">
 
	<div class="mainWrap">
		<div class="header">
			<div class="userFr">
				<div class="userArea">${sessionScope.userDataVO.usr_id }(${sessionScope.userDataVO.usr_name })</div>
				<div class="userInfoArea">
					<div class="userInfo" onclick="fn_modifyUserData();">??????????????????</div>
					<div class="userInfo" onclick="fn_logout();">????????????</div>
				</div>
			</div>
		</div>
		<div class="contentsWrap" >
<%@ include file="/WEB-INF/jsp/common/left_menu.jsp" %>
			<div class="contents">
				<form id="distForm">
					<div class="topBnr4"></div>
						<label class="ttx">????????????</label>
					<div class="year">
						<input type="text" name="sac_yy" value="${sac_yy}">
					</div>
					<div class="btnn btnn1">
						<a href="#">??????</a>
					</div>
					<div class="btnn btnn2">
						<a href="#" onclick="fn_distList();">??????</a>
					</div>
				</form>
				<div class="tab">
 					 <button class="tablinks" onclick="openCity(event, 'tab01')">????????????</button>
 					 <button class="tablinks" onclick="openCity(event, 'tab02')">????????????</button>
 					 <button class="tablinks" onclick="openCity(event, 'tab03')">??????????????????</button>
 					 <button class="tablinks" onclick="openCity(event, 'tab04')">????????????</button>
				</div>

				<div id="tab01" class="tabcontent active" title="????????????">
  					<table id="distTable">
  						<thead>
  						<tr>
  							<th>???????????????</th>
  							<th>????????????</th>
  							<th>????????????</th>
  							<th>????????????????????????</th>
  							<th>?????????PG????????????</th>
  							<th>DB AGENT<br>????????????</th>
  							<th>???????????????</th>
  							<th>????????????<br>??????</th>
  							<th>??????<br>????????????<br>??????</th>
  							<th>????????????<br>??????</th>
  							<th>????????????<br>??????</th>
  							<th>??????<br>?????????<br>??????</th>
  						</tr>
  						</thead>
  						<tbody>
  						<tr>
  							<td colspan="12">????????? ????????? ????????????.</td>
  						</tr>
  						</tbody>
  					</table>
				</div>

				<div id="tab02" class="tabcontent" title="????????????">
 					 <table>
  						<thead>
  						<tr>
  							<th>???????????????</th>
  							<th>????????????</th>
  							<th>????????????</th>
  							<th>DB??????<br>????????????</th>
  							<th>Web??????<br>????????????</th>
  							<th>???????????????<br>????????????</th>
  							<th>Payinfo<br>?????????</th>
  						</tr>
  						</thead>
  						<tbody>
  						<tr>
  							<td><input type="text" id="inputBox"></td>
  							<td><input type="text" id="inputBox"></td>
  							<td><input type="text" id="inputBox"></td>
  							<td><input type="text" id="inputBox"></td>
  							<td><input type="text" id="inputBox"></td>
  							<td><input type="text" id="inputBox"></td>
  							<td><input type="text" id="inputBox"></td>
  						</tr>
  						</tbody>
  					</table>
				</div>

				<div id="tab03" class="tabcontent" title="??????????????????">
 					 <p>Tokyo is the capital of Japan.</p>
				</div>
				
				<div id="tab04" class="tabcontent" title="????????????">
 					 <p>Tokyo is the capital of Japan.</p>
				</div>
				
			</div>
		</div>

	</div> 
<table>

</table>
</body>
</html>

