<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page import="pegsystem.util.StringUtil"%>

<html>
<script type="text/javascript" src="<c:url value='/resources/js/pegs/messageUtil.js' />" ></script>
<%
    Map<String, Object> msgInfo = (HashMap<String, Object>)request.getAttribute("MSGINFO") ;
    String mode = (String)msgInfo.get("MODE") ;
    String message = (String)msgInfo.get("MSG") ;
    String uri = (String)msgInfo.get("URI");
    Map<String, String> param = (HashMap<String, String>)msgInfo.get("PARAM");
    String script = (String)msgInfo.get("SCRIPT");
    String width = (String)msgInfo.get("WIDTH");
    String height = (String)msgInfo.get("HEIGHT");

    String[] temp = null ;
    if( mode.equals("script")) {
        
        out.println("<script language=\"javascript\">" ) ;

        out.println(message);
        out.println("</script>") ;
        return ;
    }

    if("action".equals(mode)) {

        out.println("<script language=\"javascript\"> \n" ) ;
        out.println( "function DOC_LOAD() { \n");
        
        if(!"".equals(StringUtil.isNull(message)))
            out.println( message +"\n");

        out.println( "frmMain.method= \"post\" ; \n");
        out.println( "frmMain.action= \""+uri+"\" ;\n");
        out.println( "frmMain.submit(); \n");
        out.println("}\n");
        out.println("</script>") ;
        out.println("<body onLoad = 'DOC_LOAD();'>") ;
        out.println("<form name = \"frmMain\"  >\n");
        Enumeration  pnames  = request.getParameterNames() ;

        String key = "" ;
        Object value = "" ;
        while (pnames.hasMoreElements()) {
            key = (String) pnames.nextElement();
            value = request.getParameter(key);
            out.println("<input type = 'hidden' name = '"+key+"' value = '"+value+"'>\n");

        }
        Set set = null ;
        Iterator iter = null; 
        if(param != null ) {
            set =  param.keySet();
            iter = set.iterator();

         
            for(;iter.hasNext();){
                key = (String)iter.next();
                value = (String)param.get(key) ;
                out.println("<input type = 'hidden' name = '"+key+"' value = '"+value+"'>\n");
            }
        }
        out.println("</form>\n");
        out.println("</body>") ;
        return ;
    }

    if( "load".equals(mode)) {
        out.println("<script language=\"javascript\"> \n" ) ;
        out.println( "function DOC_LOAD() { \n");
        out.println( message +"\n");
        out.println("}\n");
        out.println("</script>") ;
        out.println("<body onLoad = 'DOC_LOAD();'>") ;
        out.println(script);
        out.println("</body>") ;
        return ;
    }

    if( "html".equals(mode)) {
        out.println(message) ;
        return ;
    }
    
    if( "popup".equals(mode)) {
        out.println("<script language=\"javascript\"> \n" ) ;
        out.println( "function DOC_LOAD() { \n");
        //out.println( "    alert('test'); \n");
        out.println( "  window.open('"+uri+"', 'popCmmMessage', 'width=" + width + "', 'height=" + height +"' , 'scrollbars=1', 'resizable=1');" ); 
        out.println( "  self.close(); \n");
        out.println("}\n");
        out.println("</script>\n") ;
        out.println("<body onLoad = 'DOC_LOAD();'>\n") ;
        out.println("</body>") ;
        return ;
    }

%>
    </html>