var _ajax;


function fn_ajaxPOST(url, data, callback){
	if(_ajax) clearTimeout(_ajax);
	_ajax = setTimeout(function(){ fn_ajaxPOST_(url, data, callback); },200);
}


function fn_ajaxPOSTTxt(url, data, callback){
	if(_ajax) clearTimeout(_ajax);
	_ajax = setTimeout(function(){ fn_ajaxPOSTTxt_(url, data, callback); },200);
}


function fn_ajaxPOST_(url, data, callback){
	$.ajax({
	    type: "POST"
	   ,url: url
	   ,data: $.param(data)
	   ,beforeSend:function(){ $('.loading').show(); }
	   ,complete:function(){ $('.loading').hide(); }
	   ,success: callback
	   ,dataType:"json"
	   ,error : function(x, e) { fn_ajaxError(x, e); }
	});
}


function fn_ajaxPOSTTxt_(url, data, callback){
	$.ajax({
	    type: "POST"
	   ,url: url
	   ,data: data
	   ,beforeSend:function(){ $('.loading').show(); }
	   ,complete:function(){ $('.loading').hide(); }
	   ,success: callback
	   ,dataType:"json"
	   ,error : function(x, e) { fn_ajaxError(x, e); }
	});
}


function fn_ajaxGET(url, data, callback){
	$.ajax({
	     type: "GET"
	    ,url: url
	    ,data: $.param(data)
	    ,beforeSend:function(){ $('.loading').show(); }
	    ,complete:function(){ $('.loading').hide(); }
	    ,success: callback
	    ,dataType:"json"
	    ,error : function(x, e) { fn_ajaxError(x, e); }
	});
}


function fn_ajaxAyncPOST(url, data, callback){
	fn_ajaxAyncPOSTTxt_(url, $.param(data), callback);
}


function fn_ajaxAyncPOSTTxt_(url, data, callback){
	$.ajax({
	     type: "POST"
	    ,url: url
	    ,async: false
	    ,data: data
	    ,beforeSend:function(){ $('.loading').show(); }
        ,complete:function(){ $('.loading').hide(); }
	    ,success: callback
	    ,dataType:"json"
	    ,error : function(x, e) { fn_ajaxError(x, e); }
	});
}



/**
 * form to json
 */
$.fn.serializeObject = function() {
    var obj = null;
    try {
        if (this[0].tagName && this[0].tagName.toUpperCase() == "FORM") {
            var arr = this.serializeArray();
            if (arr) {
                obj = {};
                $.each(arr, function() {
                    obj[this.name] = this.value;
                });
            }//if ( arr ) {
        }
    } catch (e) {
        alert(e.message);
    } finally {
    	
    }
    return obj;
};




// ajax error
function fn_ajaxError(x, e) {
	if(x.status == 0) alert('You are offline!!n Please Check Your Network.');
    else if(x.status == 404) alert('Requested URL not found.');
    else if(x.status == 500) alert('Internel Server Error.');
    else if(e == 'parsererror') alert('Parsing JSON Request failed.');
    else if(e == 'timeout') alert('Request Time out.');
    else alert('Unknow Error.n' + x.responseText);
}