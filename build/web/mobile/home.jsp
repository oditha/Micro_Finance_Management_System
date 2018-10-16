<%@page import="Srcs.PoolManager"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="ORM.Center"%>

<%@page import="org.hibernate.Criteria"%>
<%@page import="Singleton.PageTitleSet"%>
<%

    PageTitleSet.getTitle().setPAGE_TITLE("Login");

    try {

        if (session.getAttribute("Name") == null) {

            response.sendRedirect("newlogin.jsp");

        }

    } catch (Exception e) {
    }

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp"/>
<div style="height: 20px"></div>

<div class="card">
    <div class="card-header text-right">

        <div class=""><a class="btn btn-danger btn-sm" href="../MobileLogoutServlet">
                Logout
            </a></div> 



    </div>
    <div class="card-body">
        <div class="container">

            <%                try {

                    Criteria c = PoolManager.getSessionFactory().openSession().createCriteria(Center.class);
                    Criteria cr = c.createCriteria("centerHasStaffs");
                    Criteria cr2 = cr.createCriteria("staff");
                    cr2.add(Restrictions.eq("idStaff", Integer.parseInt(session.getAttribute("id").toString())));
                    c.add(Restrictions.eq("isActive", "Active"));
                    c.add(Restrictions.eq("isApprove", "Approve"));

                    List<Center> list = c.list();
                    for (Center cen : list) {%>

            <div class="">
                <a class="btn btn-outline-secondary btn-block" href="addRepaymentBulk.jsp?cid=<%= cen.getIdCenter()%>">
                    <%= cen.getCenterName()%>
                </a>
            </div>  

            <% }
                    PoolManager.getSessionFactory().openSession().close();
                } catch (Exception e) {

                    out.print(e);

                }


            %>

        </div>
    </div>

</div>

<jsp:include page="/Modals.jsp"/>
<jsp:include page="/footer.jsp"/>
