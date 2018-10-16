<%-- 
    Document   : LoanAprovel
    Created on : Jan 21, 2018, 4:48:22 PM
    Author     : arshak
--%>

<%@page import="ORM.Repaymentcancellation"%>
<%@page import="ORM.Loancancellation"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="ORM.Loan"%>
<%@page import="org.hibernate.Session"%>
<%@page import="Srcs.PoolManager"%>
<%@page import="Singleton.PageTitleSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  PageTitleSet.getTitle().setPAGE_TITLE("Repayment Cancellation Approvals"); %>
<jsp:include page="/header.jsp"/>
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

    if (request.getParameter("Aprove") != null) {
%>

<script>

    swal("Success!", "You have Approved a Request", "success");

    reload();
    
</script>


<%
    }


%> 
<%    if (request.getParameter("reject") != null) {
%>
<script>


    swal("Success!", "You have Rejected a Request", "success");
    reload();
</script>

<%
    }


%> 

<!--<div class="card">
    <div class="card-block">-->

        <table id="table" class="table table-striped">
            <thead>

                <tr>
                    <th>Receipt No</th>
                    <th>Member Name</th>
                    <th>Member NO</th>


                    <th>Paid Amount</th>                    
                    <th>Center</th>                    
                    <th>Executive</th>                    
                    <th>Request Date</th>                    

                    <th>Action</th>

                </tr>

            </thead>

            <tbody>

            </tbody>
        </table>


<!--    </div>
</div>-->
<!--///////////////////////////////-------------------------------------------------------------------------->


<div class="modal fade bd-example-modal-lg" id="openM" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Repayment Cancellation</h5>
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
                            <div class="form-group">
                                <label for="formGroupExampleInput">Paid Amount</label>
                                <input type="text" class="form-control" id="PaidAmount" name="NIC">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Paid Date</label>
                                <input type="text" class="form-control" id="PaidDate" name="NIC">
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

                    <form action="../AproveRepaymentCancellation"> <input type="text" id="hid" class="hid" name="hid" hidden> <input type="submit" class="btn btn-success"  value="Approve" ></form>  

                    <form action="../RejectRepaymentCancellation"> <input type="text" id="hid" class="hid" name="hid" hidden> <input type="submit" class="btn btn-danger"  value="Reject" ></form>  


                </div>
            </div>
        </div>
    </div>
</div>

<script>




    $(document).ready(function () {



        $.ajax({
            url: '../LoadRepaymentCancellationServlet',

            success: function (responseText) {


                var jr = JSON.parse(responseText);
                if ($.fn.dataTable.isDataTable('#table')) {
                    table = $('#table').DataTable();
                    table.destroy();
                }


                $("#table").DataTable({
                    dom: 'Bfrtip',
                    buttons: [
                        'excel', 'pdf', 'print', 'colvis'
                    ],
                    data: jr,
                    columns: [

                        {data: 'contarctNo'},
                        {data: 'namwid'},
                        {data: 'nic'},

                        {data: 'paidamount'},
                        {data: 'center'},
                        {data: 'executive'},
                        {data: 'date'},
                        {data: 'btn'}




                    ]

                });






            }


        });



    });

    function reload() {

        $.ajax({
            url: '../LoadRepaymentCancellationServlet',

            success: function (responseText) {


                var jr = JSON.parse(responseText);
                if ($.fn.dataTable.isDataTable('#table')) {
                    table = $('#table').DataTable();
                    table.destroy();
                }


                $("#table").DataTable({
                    dom: 'Bfrtip',
                    buttons: [
                        'excel', 'pdf', 'print', 'colvis'
                    ],
                    data: jr,
                    columns: [

                        {data: 'contarctNo'},
                        {data: 'namwid'},
                        {data: 'nic'},

                        {data: 'paidamount'},
                        {data: 'center'},
                        {data: 'executive'},
                        {data: 'date'},
                        {data: 'btn'}




                    ]

                });






            }


        });

    }


    function clk(sid) {
        $('.hid').val(sid);




        $.ajax({
            url: '../RepaymentCancellation',
            data: {ID: sid},
            success: function (responseText) {



//alert(responseText);

                var ja = JSON.parse(responseText);
                for (var i = 0; i < ja.length; i++) {



//
                    var ContractNo = ja[i].ContractNo;
                    var MemberName = ja[i].MemberName;
                    var Reason = ja[i].Reason;
                    var PaidAmount = ja[i].PaidAmount;
                    var Paiddate = ja[i].Paiddate;


                }


                $("#conno").attr('value', ContractNo);
                $("#mname").attr('value', MemberName);
                $("#exampleFormControlTextarea1re").val(Reason);
                $("#PaidAmount").val(PaidAmount);
                $("#PaidDate").val(Paiddate);


                $(document).ready(function () {
                    $('#openM').modal('show');
                });


            }


        });











    }








</script>



<jsp:include page="/footer.jsp"/>
