
 
<%@page import="Srcs.PoolManager"%>

<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="ORM.Staffleave"%>
<%@page import="org.hibernate.Criteria"%>

<%@page import="org.hibernate.Session"%>
<%@page import="Singleton.dateFormat"%>
<%@page import="Singleton.PageTitleSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    
    
      if (session.getAttribute("userName") == null) {

      response.sendRedirect("../newlogin.jsp");

   }
    
    
    PageTitleSet.getTitle().setPAGE_TITLE("Leave Management");





%>
<jsp:include page="/header.jsp"/>


<!--<div style="height: 10px;"></div>







<div style="height: 10px;"></div>-->
<div class="card">
    <div class="card-header text-right" role="tab" id="headingTwo">

        <a class="collapsed btn btn-primary btn-sm" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo" >
            +Add Leave
        </a>

    </div>
    <div id="collapseTwo" class="collapse" role="tabpanel" aria-labelledby="headingTwo">
        <div class="card-block">

            <div class="container">
                <form action="../AddLeaveServlet?id=<%=session.getAttribute("id").toString() %>" method="POST">
                    <div class="row">

                        <div class="col-md-3">

                            <div class="form-group">
                                <label for="exampleSelect1">Leave Type</label>
                                <select class="form-control" id="exampleSelect1"  name="Leavetype" required >
                                    <option>Select</option>
                                    <option value="fullday">Fullday</option>

                                </select>
                            </div>



                        </div>
                        <div class="col-md-3">

                            <div class="form-group"> 
                                <label for="exampleSelect1">Start Date </label>
                                <!--<div style="height: 6px;"></div>-->
                                <input class="form-control" type="date" value="" id="StartDate" name="StartDate"  min="<%= dateFormat.DateFullCurrent()   %>"   required onchange="cal()" >
                            </div>





                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <!--<div style="height: 6px;"></div>-->
                                <label for="exampleSelect1">End Date  </label>
                                <input class="form-control" type="date" value="" id="EndDate" name="EndDate" required onchange="cal()" min="">
                            </div>
                            
                            <div class="form-group">
                            <label for="exampleSelect1">Total Days  </label>
                            <input class="form-control readonly" type="text" value="" id="Tdays" name="Tdays" readonly>
                        </div>
                            
                            
                        </div>
                        
                    <div class="col-md-3">

                        <div class="form-group">
                            <label for="exampleSelect1">Reason </label>
                            <textarea class="form-control" id="reason" name="reason" required></textarea>


                        </div>
                        <!--<div style="height: 10px;"></div>-->
                        <div class="form-group text-right">

                            <input type="reset" value="Reset" name="reset" class="btn btn-danger">
                            <input type="submit" value="Submit" name="Save" class="btn btn-primary">



                        </div>

                    </div>
                </form>


                    </div>

            </div>
        </div>



    </div>
</div>




<!--<div style="height: 10px;"></div>-->

<div class="card">
    <div class="card-header">
        Featured
    </div>
    <div class="card-block">


       

   






    <div class=" table-responsive ">          
        <table class="table table-stripped">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>NIC</th>


                    <th>Requested Date</th>
                    <th>From Date</th>

                    <th>To Date</th>
                    <th>Total Days</th>
                    



                    <th>Status</th>
                    <th>Options</th>


                </tr>
            </thead>
            <tbody id="tbody">
                
                <%
                
              Session sess= PoolManager.getSessionFactory().openSession();
              
              Criteria cr=sess.createCriteria(Staffleave.class);
              
            //  cr.add(Restrictions.eq("requestedDate", dateFormat.MonthOnly()));
              cr.createAlias("staff", "s");
              cr.add(Restrictions.eq("s.idStaff",Integer.parseInt( session.getAttribute("id").toString())));
              cr.add(Restrictions.eq("isActive", "Active"));
              

              List<Staffleave>l=cr.list();
              

              for (Staffleave sl : l) {%>
                
                  <tr>
                    <td>1</td>
                    <td><%=sl.getStaff().getName()  %></td>
                    <td><%=sl.getStaff().getNic() %></td>
                    <td><%=sl.getRequestedDate() %></td>
                    <td><%=sl.getStartDate() %></td>
                    <td><%=sl.getEndDate() %></td>
                    <td><%=sl.getTotalDays() %></td>
                    <td><%=sl.getIsAprove() %></td>
                    <td><a href="../RemoveLeaveServlet?id=<% out.print(sl.getIdstaffLeave());   %>" class="btn btn-primary">Remove</a></td>
                  




                </tr>
                
                <%
                  }
                      sess.close();
              
              



                
                
                
                %>
                
                
              
            </tbody>
        </table>

 </div>

        <!--<div style="height: 10px;"></div>-->




    </div>



</div>





<script>
    
    
    function GetDays(){
                var dropdt = new Date(document.getElementById("StartDate").value);
                var pickdt = new Date(document.getElementById("EndDate").value);
                return parseInt((pickdt-dropdt) / (24 * 3600 * 1000));
                
        }

        function cal(){
        if(document.getElementById("EndDate")){
            document.getElementById("Tdays").value=GetDays();
            
          
        }  
          if (document.getElementById("Tdays").value==='NaN') {
    document.getElementById("Tdays").value=0;
}


var dat=new Date().getMonth()+"/"+Date.getDay()+"/"+Date.getYear();
    //  alert(dat.toString());  
        
    }
    
    
    
    
</script>




<jsp:include page="/footer.jsp"/>
