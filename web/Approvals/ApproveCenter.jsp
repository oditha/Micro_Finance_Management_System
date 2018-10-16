<%-- 
    Document   : ApproveCenter
    Created on : Jan 22, 2018, 10:25:46 AM
    Author     : arshak
--%>

<%@page import="Srcs.PoolManager"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="ORM.Center"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>

<%@page import="Singleton.PageTitleSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

    PageTitleSet.getTitle().setPAGE_TITLE("Center Approvals");


%> 
<jsp:include page="/header.jsp"/>

<%    if (request.getParameter("Approve") != null) {
%>

<script>

    swal("Success!", "you have Approved a Center", "success");


</script>




<%
    }

    if (request.getParameter("reject") != null) {
%>

<script>

    swal("Success!", "you have Rejected a Center", "success");


</script>





<%
    }


%>


<!--<div class="card">
    <div class="card-block">-->

        <div class="table-responsive">          
            <table class="table">
                <thead>
                    <tr>

                        <th>Center No</th>
                        <th>Center Name</th>
                        <th>Center Day</th>
                        <th>Center Time</th>
                        <th>options</th>
                    </tr>
                </thead>
                <tbody>

                    <%                        Session sess = PoolManager.getSessionFactory().openSession();
                        Criteria cr = sess.createCriteria(Center.class);
                        cr.add(Restrictions.eq("isApprove", "Pending"));
                        cr.add(Restrictions.eq("isActive", "Pending"));
                        List<Center> l = cr.list();

                        for (Center list : l) {


                    %>


                    <tr> 

                        <td> <%=list.getCenterNo()%> </td>
                        <td> <%=list.getCenterName()%> </td>
                        <td> <%=list.getCenterDay()%> </td>

                        <td> <%=list.getCentertime()%> </td>
                        <td><a class="btn btn-success btn-sm"   id="<%=list.getIdCenter()%>" onclick="clk(this.id)">View</a></td>





                    </tr>








                    <%

                        }
                        sess.close();

                    %>






                </tbody>
            </table>
        </div>


<!--    </div>
</div>-->





<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="mymodal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">View Center </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">


                <div class="container">
                    <div class="row">
                        <div class="col-md-6"> 

                            <div class="form-group">
                                <label for="formGroupExampleInput"> Branch</label>
                                <input type="text" class="form-control" id="branch" placeholder="Example input">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput"> Center No</label>
                                <input type="text" class="form-control" id="CenterNo" placeholder="Example input">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput"> Center Name</label>
                                <input type="text" class="form-control" id="CenterName" placeholder="Example input">
                            </div>



                        </div>
                        <div class="col-md-6"> 
                            <div class="form-group">
                                <label for="formGroupExampleInput"> Center Day</label>
                                <input type="text" class="form-control" id="CenterDay" placeholder="Example input">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput"> Center Time</label>
                                <input type="text" class="form-control" id="CenterTime" placeholder="Example input">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput"> Executive</label>
                                <input type="text" class="form-control" id="Executive" placeholder="Example input">
                            </div>


                        </div>

                    </div>
                </div>


                <!--                
                                <form action="../">
                                    <input type="submit" value="Reject" name="reject" class="btn btn-alert">
                                    <input type="text" id="lid" class="lid"   name="lid" hidden></form>-->
            </div>
            <div class="modal-footer">

                <form action="../ApproveCenter"> <input type="text" id="hid" class="hid" name="hid" hidden> <input type="submit" class="btn btn-success"  value="Approve" ></form>  

                <form action="../RejectCenter"> <input type="text" id="hid" class="hid" name="hid" hidden> <input type="submit" class="btn btn-danger"  value="Reject" ></form>  






            </div>
        </div>
    </div>
</div>








<script>

    $(document).ready(function () {
        $('.table').DataTable();
    });

    function clk(sid) {


        $('.hid').val(sid);

        $('.modal').modal('show');


        $.ajax({
            url: '../LoadCenterAprovalAjax',
            data: {ID: sid},
            success: function (responseText) {




//
                var ja = JSON.parse(responseText);


                for (var i = 0; i < ja.length; i++) {
                    var branch = ja[i].branch;
                    var centerNo = ja[i].centerNo;
                    var centerName = ja[i].centerName;
                    var centerDay = ja[i].centerDay;
                    var centertime = ja[i].centertime;
                    var Executive = ja[i].Executive;

                }
                $("#branch").attr('value', branch);
                $("#CenterNo").attr('value', centerNo);
                $("#CenterName").attr('value', centerName);
                $("#CenterDay").attr('value', centerDay);
                $("#CenterTime").attr('value', centertime);
                $("#Executive").attr('value', Executive);

//
//
//
//
//
//


            }


        });

    }

</script>




<jsp:include page="/footer.jsp"/>


