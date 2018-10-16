<%@page import="Singleton.PageTitleSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

    PageTitleSet.getTitle().setPAGE_TITLE("DashBoard");

%>

<jsp:include page="header.jsp"/>


<%        try {
            if (session.getAttribute("UserType").toString().equals("Manager")) { %>

<jsp:include page="dashboard/managerDashboard.jsp"/>


<% } else if (session.getAttribute("UserType").toString().equals("Executive")) { %>

<jsp:include page="dashboard/exeDashboard.jsp"/>


<% }else{ %>


<jsp:include page="dashboard/CashierDashboard.jsp"/>


<% }
    } catch (Exception e) {
    }

%>


<jsp:include page="footer.jsp"/>
