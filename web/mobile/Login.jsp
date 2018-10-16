<%@page import="Singleton.PageTitleSet"%>
<%

    PageTitleSet.getTitle().setPAGE_TITLE("Login");
    
    try{
        
        if(session.getAttribute("Name") != null){
        
            response.sendRedirect("home.jsp");
            
        }
        
    }catch(Exception e){}
    
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="header.jsp"/>
<div style="height: 20px"></div>
<%    if (request.getParameter("stat") != null) {

        if (request.getParameter("stat").equals("done")) {

            out.print("<div class=\"alert alert-success\" role=\"alert\"><strong>Success!</strong> Data has been saved successfully.</div>");

        } else if (request.getParameter("stat").equals("err")) {

            out.print("<div class=\"alert alert-danger\" role=\"alert\"><strong>Error!</strong> A problem has been occurred while submitting your data.</div>");

        } else if (request.getParameter("stat").equals("delete")) {

            out.print("<div class=\"alert alert-warning\" role=\"alert\"><strong>Success!</strong> A record has been deleted.</div>");

        }

    }

%>
<div style="height: 20px"></div>
<div class="card">
    <div class="card-body">
        <form action="../MobileLoginServlet" method="post">
            <div class="form-group">
                <label for="exampleInputEmail1">Username</label>
                <input type="text" class="form-control" name="UserName" placeholder="Enter Username">
                
            </div>
            <div class="form-group">
                <label for="exampleInputPassword1">Password</label>
                <input type="password" class="form-control" id="exampleInputPassword1" name="Password" placeholder="Password">
            </div>
           <button type="submit" class="btn btn-primary text-center">Login</button>
        </form>
    </div>
</div>


<jsp:include page="/Modals.jsp"/>
<jsp:include page="/footer.jsp"/>
