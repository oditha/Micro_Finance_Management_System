

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

if (session.getAttribute("userName") != null) {

    } else {

        response.sendRedirect("/CMC/newlogin.jsp");

    }

    if (session.getAttribute("UserType").toString().equals("Executive")) {

    } else {

        response.sendRedirect("/CMC/newlogin.jsp");

    }



%>
<jsp:include page="/Executive/headerExecutive.jsp"/>






<jsp:include page="/Executive/footerExecutive.jsp"/>