<%-- 
    Document   : BlockedUsers
    Created on : Dec 21, 2017, 11:41:20 AM
    Author     : iamarshrx
--%>

<%@page import="Srcs.PoolManager"%>
<%@page import="java.util.List"%>
<%@page import="ORM.Login"%>
<%@page import="org.hibernate.criterion.Restrictions"%>

<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page import="Singleton.PageTitleSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>



 <%
     
    
     if (session.getAttribute("userName") != null) {


   }else{
      
      response.sendRedirect("/CMC/newlogin.jsp");
      
      
      }
    
    
    
    
    
    
    PageTitleSet.getTitle().setPAGE_TITLE("Resignarion");%>
<jsp:include page="/header.jsp"/>





<div class="card">
  <div class="card-block">
    
        <div class="table-responsive">          
            <table class="table" id="vtable">
    <thead>
      <tr>
        <th>#</th>
        <th>Name</th>
        <th>Nic</th>
        <th>Username</th>
        <th>Status</th>
        <th>Unblock</th>
      </tr>
    </thead>
    <tbody>
     <%
     
      Session sess=PoolManager.getSessionFactory().openSession();
            Criteria cr = sess.createCriteria(Login.class);
            
            cr.add(Restrictions.eq("loginBlock", "blocked"));
            
            int i=0;
            List<Login> list = cr.list();
     
     
     for (Login l : list) {
             %>
     
        
        
        
        
        
        
        
        <%
         }
     
     sess.close();
     
     
     
     %>
    </tbody>
  </table>
  </div>
      
      
      
      
      
      
      
      
      
      
      
      
      
  </div>
</div>


<script>
    
//    
//    $(document).ready(function() {
//      $.ajax({
//                    type: 'POST',
//                    url: '../LoadAllBlockedServlet',
//
//                    
//                    success: function (responseText) {
//
//
//                        var json = JSON.parse(responseText);
//
//                        if ($.fn.dataTable.isDataTable('#vtable')) {
//                            table = $('#vtable').DataTable();
//                            table.destroy();
//                        }
//
//
//                        $("#vtable").DataTable({
//                            data: json,
//                            columns: [
//                                {data: 'id'},
//                                {data: 'name'},
//                                {data: 'nic'},
//                                {data: 'username'},
//                                {data: 'status'}
//                              
//                                
//                               
//                                
//
//                            ]
//
//
//
//                        });
//
//
//
//                    }
//
//                });
//    
//});
//    
    
    
    
    
    
</script>








<jsp:include page="/footer.jsp"/>
