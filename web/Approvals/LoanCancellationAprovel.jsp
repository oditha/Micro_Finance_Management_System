<%-- 
    Document   : LoanAprovel
    Created on : Jan 21, 2018, 4:48:22 PM
    Author     : arshak
--%>

<%@page import="ORM.Loancancellation"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="ORM.Loan"%>
<%@page import="org.hibernate.Session"%>
<%@page import="Srcs.PoolManager"%>
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
    PageTitleSet.getTitle().setPAGE_TITLE("Loan Cancellation Approvals");


%>

<jsp:include page="/header.jsp"/>
<%    if (request.getParameter("aprovel") != null) {
%>


<script>

    swal("Success!", "you have Approved a loan Cancellation request", "success");
    var table = $('#table').DataTable();
    table.ajax.reload();

</script>


<%
    }


%> 
<%    if (request.getParameter("reject") != null) {
%>

<!--<div class="alert alert-success">
    <strong>Success!</strong> you have Rejected a loan Cancellation request
</div>-->

<script>


    swal("Successfully Rejected", "you have Successfully Rejected a Loan Cancellation request", "error");
    var table = $('#table').DataTable();
    table.ajax.reload();

</script>
<%
    }


%> 

<!--<div class="card">
    <div class="card-block">-->

        <div class="table-responsive">          
            <table class="table" id="table">
                <thead>
                    <tr>
                        <th>Contract No</th>
                        <th>Member No</th>
                        <th>Member Name</th>
                        <th>Center</th>
                        <th>Loan Amount</th>
                        <th>Executive</th>                    
                        <th>Request Date</th>                    

                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>

<!--    </div>
</div>-->
<!--///////////////////////////////-------------------------------------------------------------------------->


<div class="modal fade bd-example-modal-lg" id="openM" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Loan Cancellation</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <div class="container">

                    <div class="row">

                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="formGroupExampleInput">Contract NO</label>
                                <input type="text" class="form-control" id="conno" name="NIC">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Member Name</label>
                                <input type="text" class="form-control" id="mname" name="NIC">
                            </div>

                            <div class="form-group" hidden="">

                                <input type="text" class="form-control" id="idlo" name="fullname">
                            </div>

                        </div>
                        <div class="col-md-8">
                            <div class="form-group">
                                <label for="exampleFormControlTextarea1">Request Reason</label>
                                <textarea class="form-control" id="exampleFormControlTextarea1re" rows="3"></textarea>
                            </div>

                        </div>

                    </div>

                </div>
                <div class="modal-footer">

                    <form action="../ApproveLoanCancellation"> <input type="text" id="hid" class="hid" name="hid" hidden> <input type="submit" class="btn btn-success"  value="Approve" ></form>  

                    <form action="../RejectLoanCancellation"> <input type="text" id="hid" class="hid" name="hid" hidden> <input type="submit" class="btn btn-danger"  value="Reject" ></form>  

                </div>
            </div>
        </div>
    </div>
</div>

<script>


    $(document).ready(function () {


        $.ajax({

            url: '../LoadLoancancellationtable',

            success: function (responseText) {

//            alert(responseText);
                var jr = JSON.parse(responseText);
                if ($.fn.dataTable.isDataTable('#table')) {
                    table = $('.table').DataTable();
                    table.destroy();
                }


                $("#table").DataTable({
                    dom: 'Bfrtip',
                    buttons: [
                        'excel', 'pdf', 'print', 'colvis'
                    ],
                    data: jr,
                    columns: [

                        {data: 'contractNo'},
                        {data: 'memno'},
                        {data: 'namewidin'},
                        {data: 'center'},
                        {data: 'amount'},
                        {data: 'Aprove'},
                        {data: 'date'},
                        {data: 'btn'}




                    ]

                });

                // $('.Payment-Historymod').modal();




            }


        });



    });

    function clk(sid) {
        $('.hid').val(sid);




        $.ajax({
            url: '../LoanCancellation',
            data: {ID: sid},
            success: function (responseText) {



                //   alert(responseText);

                var ja = JSON.parse(responseText);
//
//
//
//
//
//
                for (var i = 0; i < ja.length; i++) {



//
                    var ContaractNo = ja[i].ContaractNo;
                    var MemberName = ja[i].MemberName;
                    var Reason = ja[i].Reason;







                }

                $("#conno").attr('value', ContaractNo);
                $("#mname").attr('value', MemberName);
                $("#exampleFormControlTextarea1re").val(Reason);
                $('#openM').modal('show');

            }


        });











    }








</script>



<jsp:include page="/footer.jsp"/>
