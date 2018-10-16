<%-- 
    Document   : ApproveLeave
    Created on : Dec 22, 2017, 8:59:59 PM
    Author     : iamarshrx
--%>

<%@page import="Srcs.PoolManager"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="ORM.Staffleave"%>
<%@page import="org.hibernate.Session"%>

<%@page import="Singleton.PageTitleSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%

    if (session.getAttribute("userName") == null) {

        response.sendRedirect("/newlogin.jsp");

    }

    try {
        if (!session.getAttribute("UserType").toString().equals("Manager")) {

            response.sendRedirect("/CMC/errorPage/401Unauthorized.html");

        }
    } catch (Exception e) {
    }

    PageTitleSet.getTitle().setPAGE_TITLE("Leave Aprovals");%> 
<jsp:include page="/header.jsp"/>



<%
    if (request.getParameter("accept") != null) {
%>

<!--<div class="alert alert-success">
    <strong>Success!</strong> you have Approved a loan Cancellation request
</div>-->
<script>

    swal("Success!", "you have Approved a Leave request", "success");


</script>


<%
    }


%> 
<%    if (request.getParameter("reject") != null) {
%>

<!--<div class="alert alert-success">
    <strong>Success!</strong> you have Approved a loan Cancellation request
</div>-->
<script>


    swal("Success!", "you have Rejected a Leave request", "success");


</script>


<%
    }


%> 





<!--<div class="card">
    <div class="card-block">-->



        <table class="table">
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
            <tbody>

                <%                    Session sess = PoolManager.getSessionFactory().openSession();
                    Criteria cr = sess.createCriteria(Staffleave.class);
                    cr.add(Restrictions.eq("isAprove", "Pending"));
                    cr.add(Restrictions.eq("isActive", "Active"));
                    List<Staffleave> l = cr.list();

                    for (Staffleave sl : l) {%>


                <tr>
                    <td>1</td>
                    <td><%=sl.getStaff().getName()%></td>
                    <td><%=sl.getStaff().getNic()%></td>
                    <td><%=sl.getRequestedDate()%></td>
                    <td><%=sl.getStartDate()%></td>
                    <td><%=sl.getEndDate()%></td>
                    <td><%=sl.getTotalDays()%></td>
                    <td><%=sl.getIsAprove()%></td>
                    <td><a myat="<% out.print(sl.getIdstaffLeave());   %>" class="btn btn-success btn-sm cls">View</a></td>





                </tr>

                <%

                    }
                    sess.close();

                %>











            </tbody>
        </table>  







<!--    </div>
</div>-->




















<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="mymodal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">View Leave </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="formGroupExampleInput">From Date</label>
                    <input type="text" class="form-control" id="fromdate" placeholder="Example input">
                </div>
                <div class="form-group">
                    <label for="formGroupExampleInput">To Date</label>
                    <input type="text" class="form-control" id="todate" placeholder="Example input">
                </div>
                <div class="form-group">
                    <label for="formGroupExampleInput">Leave Type</label>
                    <input type="text" class="form-control" id="leaetype" placeholder="Example input">
                </div>
                <div class="form-group">
                    <label for="formGroupExampleInput">Total Days</label>
                    <input type="text" class="form-control" id="Tdays" placeholder="Example input">
                </div>
                <div class="form-group">
                    <label for="formGroupExampleInput">reason</label>
                    <input type="text" class="form-control" id="reason" placeholder="Example input">
                </div>
            </div>
            <div class="modal-footer">
                <form action="../LeaveAproveServlet" method="POST"> 
                    <input type="text" id="lid" class="lid" name="lid" hidden>
                    <input type="submit" value="Approve" name="aprove" class="btn btn-success">


                </form>


                <form action="../RejectLeave">
                    <input type="submit" value="Reject" name="reject" class="btn btn-alert">
                    <input type="text" id="lid" class="lid"   name="lid" hidden></form>
            </div>
        </div>
    </div>
</div>









<script>



    $(".cls").click(function () {

        var id = $(this).attr("myat");
        $('.lid').val(id);
        $('#li2').attr('value', id);


        $.ajax({
            url: '../ViewaproveleaveAjax',
            data: {ID: id},
            success: function (responseText) {




//
                var ja = JSON.parse(responseText);
//
//
//
//
//
//
                for (var i = 0; i < ja.length; i++) {
//
//////                    var name = ja[i].name;
//////                    var username = ja[i].username;
                    var from = ja[i].from;
                    var to = ja[i].to;
                    var type = ja[i].type;
                    var reason = ja[i].reason;
                    var total = ja[i].total;






                }
                $("#fromdate").attr('value', from);
                $("#todate").attr('value', to);
                $("#leaetype").attr('value', type);
                $("#Tdays").attr('value', total);
                $("#reason").attr('value', reason);

            }


        });


        $('#mymodal').modal('show');






    });






</script>






<jsp:include page="/footer.jsp"/>
