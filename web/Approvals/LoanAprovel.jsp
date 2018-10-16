<%-- 
    Document   : LoanAprovel
    Created on : Jan 21, 2018, 4:48:22 PM
    Author     : arshak
--%>

<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="ORM.Loan"%>
<%@page import="org.hibernate.Session"%>
<%@page import="Srcs.PoolManager"%>
<%@page import="Singleton.PageTitleSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%     PageTitleSet.getTitle().setPAGE_TITLE("Loan Approvals"); %>
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

    if (request.getParameter("aprovel") != null) {
%>

<script>

    swal("Success!", "You have Approved a Loan", "success");
    reload();

</script>


<%
    }


%> 
<%    if (request.getParameter("reject") != null) {
%>

<script>


    swal("Success!", "you have Successfully Rejected a Loan", "success");
    reload();
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
                <th>Member ID</th>
                <th>Name</th>
                <th>NIC</th>
                <th>Loan Amount</th>

                <th>Center</th>
                <th>Executive</th>
                <th>Request Date</th>
                <th>Options</th>
            </tr>
        </thead>
        <tbody>









        </tbody>
    </table>
</div>




<!--    </div>
</div>-->
<!--///////////////////////////////-------------------------------------------------------------------------->


<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="openM">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">View Loan Approval</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <div class="container">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="formGroupExampleInput">Member ID</label>
                                <input type="text" class="form-control" id="MemberId" placeholder="Example input">
                            </div>    
                            <div class="form-group">
                                <label for="formGroupExampleInput">Contract No</label>
                                <input type="text" class="form-control" id="ContractNo" placeholder="Example input">
                            </div>    
                            <div class="form-group">
                                <label for="formGroupExampleInput">Loan Interest</label>
                                <input type="text" class="form-control" id="LoanInterest" placeholder="Example input">
                            </div>    

                            <div class="form-group">
                                <label for="formGroupExampleInput">Loan Installment</label>
                                <input type="text" class="form-control" id="LoanInstallment" placeholder="Example input">
                            </div> 

                            <div class="form-group">
                                <label for="formGroupExampleInput">Member Fee</label>
                                <input type="text" class="form-control" id="MemberFee" placeholder="Example input">
                            </div> 
                            <div class="form-group">
                                <label for="formGroupExampleInput">Repayment Day</label>
                                <input type="text" class="form-control rpd" id="rpd " placeholder="Example input">
                            </div> 
                            <div class="form-group">
                                <label for="formGroupExampleInput">Guarantor 2</label>
                                <input type="text" class="form-control" id="Guarantor2" placeholder="Example input">
                            </div> 
                            <div class="form-group">
                                <label for="formGroupExampleInput">Issue Date </label>
                                <input type="date" class="form-control" id="IssueDate" placeholder="Example input">
                            </div> 





                        </div>
                        <div class="col-md-6">

                            <div class="form-group">
                                <label for="formGroupExampleInput">Member Name</label>
                                <input type="text" class="form-control" id="MemberName" placeholder="Example input">
                            </div>   

                            <div class="form-group">
                                <label for="formGroupExampleInput">Loan Index</label>
                                <input type="text" class="form-control" id="LoanIndex" placeholder="Example input">
                            </div>   
                            <div class="form-group">
                                <label for="formGroupExampleInput">Loan Amount</label>
                                <input type="text" class="form-control" id="LoanAmount" placeholder="Example input">
                            </div>   

                            <div class="form-group">
                                <label for="formGroupExampleInput">Loan Period</label>
                                <input type="text" class="form-control" id="LoanPeriod" placeholder="Example input">
                            </div> 
                            <div class="form-group">
                                <label for="formGroupExampleInput">Loan Date</label>
                                <input type="text" class="form-control" id="LoanDate" placeholder="Example input">
                            </div> 
                            <div class="form-group">
                                <label for="formGroupExampleInput">Guarantor 1</label>
                                <input type="text" class="form-control" id="Guarantor1" placeholder="Example input">
                            </div> 
                            <div class="form-group">
                                <label for="formGroupExampleInput">Re-New Amount</label>
                                <input type="text" class="form-control" id="RenewAmount" placeholder="Example input">
                            </div> 
                            <div class="form-group" style="padding-top: 25px">

                                <input ty type="button" class="form-control btn btn-info" id="ledgerrp" value="Open Ledger Report">
                            </div> 



                        </div>
                    </div>
                </div>









            </div>
            <div class="modal-footer">

                <input type="text" id="Approve" class="hid" name="hid" hidden> <input type="submit" class="btn btn-success"  value="Approve" id="subApprove" >

                <input type="text" id="reject" class="hid" name="hid" hidden> <input type="submit" class="btn btn-danger"  value="Reject" id="subReject">






            </div>
        </div>
    </div>
</div>











<script>


    $("#subApprove").click(function () {

        var lid = $("#Approve").val();
        var issued = $("#IssueDate").val();
        $.ajax({

            url: "../ApproveLoan",
            method: "POST",
            data: {hid: lid, issue: issued},
            success: function (res) {

                if (res === 'ok') {
                    $('#openM').modal('toggle');
                    swal("Success!", "You have Approved a Loan", "success");
                    reload();

                } else {

                    swal("Error!", "Something went wrong. try again", "error");
                    reload();

                }

            }


        });
    });

//--------------------reject loan

    $("#subReject").click(function () {

        var lid = $("#reject").val();

        $.ajax({

            url: "../RejectLoan",
            method: "POST",
            data: {hid: lid},
            success: function (res) {

                if (res === 'ok') {
                    $('#openM').modal('toggle');
                    swal("Success!", "You have Rejected a Loan", "success");
                    reload();

                } else {

                    swal("Error!", "Something went wrong. try again", "error");
                    reload();

                }

            }


        });
    });

//----------------load pending records--------------
    $(document).ready(function () {
        $('.table').DataTable();
    });
    $(document).ready(function () {


        $.ajax({
            url: '../LoadLaonAprovaltbl',
            success: function (responseText) {



                if ($.fn.dataTable.isDataTable('.table')) {
                    table = $('.table').DataTable();
                    table.destroy();
                }


                $(".table").DataTable({
                    dom: 'Bfrtip',
                    buttons: [
                        'excel', 'pdf', 'print', 'colvis'
                    ],
                    data: JSON.parse(responseText),
                    columns: [

                        {data: 'memno'},
                        {data: 'name'},
                        {data: 'nic'},
                        {data: 'loanAmount'},
                        {data: 'center'},
                        {data: 'exective'},
                        {data: 'request'},
                        {data: 'btn'}

                    ]

                });

            }


        });
    });

    function reload() {

        $.ajax({
            url: '../LoadLaonAprovaltbl',
            success: function (responseText) {



                if ($.fn.dataTable.isDataTable('.table')) {
                    table = $('.table').DataTable();
                    table.destroy();
                }


                $(".table").DataTable({
                    dom: 'Bfrtip',
                    buttons: [
                        'excel', 'pdf', 'print', 'colvis'
                    ],
                    data: JSON.parse(responseText),
                    columns: [

                        {data: 'memno'},
                        {data: 'name'},
                        {data: 'nic'},
                        {data: 'loanAmount'},
                        {data: 'center'},
                        {data: 'exective'},
                        {data: 'request'},
                        {data: 'btn'}

                    ]

                });

            }


        });

    }

    function clk(sid) {
        $('.hid').val(sid);
        $.ajax({
            url: '../LoadLoanApprovalsAjax',
            data: {ID: sid},
            success: function (responseText) {





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
                    var memberid = ja[i].memberid;
                    var membername = ja[i].membername;
                    var ContractNo = ja[i].ContractNo;
                    var Loanindex = ja[i].Loanindex;
                    var Loaninterest = ja[i].Loaninterest;
                    var Loaninstallment = ja[i].Loaninstallment;
                    var LoanPeriod = ja[i].LoanPeriod;
                    var MemberFee = ja[i].MemberFee;
                    var LoanDate = ja[i].LoanDate;
                    var RepaymentDay = ja[i].RepaymentDay;
                    var Guarantor1 = ja[i].Guarantor1;
                    var Guarantor2 = ja[i].Guarantor2;
                    var renewAmount = ja[i].renewAmount;
                    var issuedate = ja[i].issuedate;
                    var LoanAmount = ja[i].LoanAmount;
//                    var parsestart = moment().format(issuedate);
                    var parse = moment(issuedate, "DD/MM/YYYY").format("YYYY-MM-DD");
//                    alert(parsestart)



                }
                $("input[type=date]").val("");
                $(".rpd").val(RepaymentDay);
                $("#MemberId").attr('value', memberid);
                $("#MemberName").attr('value', membername);
                $("#ContractNo").attr('value', ContractNo);
                $("#LoanIndex").attr('value', Loanindex);
                $("#LoanInterest").attr('value', Loaninterest);
                $("#LoanAmount").attr('value', LoanAmount);
                $("#LoanInstallment").attr('value', Loaninstallment);
                $("#LoanPeriod").attr('value', LoanPeriod);
                $("#MemberFee").attr('value', MemberFee);
                $("#LoanDate").attr('value', LoanDate);
                $("#Guarantor1 ").attr('value', Guarantor1);
                $("#Guarantor2 ").attr('value', Guarantor2);
                $("#RenewAmount ").attr('value', renewAmount);
                $("#IssueDate ").val(parse);
                $("#ledgerrp ").attr('memid', memberid);



            }


        });
        $('#openM').modal('show');
    }




    $("#ledgerrp").click(function () {

        var memid = $("#ledgerrp ").attr('memid');

        window.open("viewLederReport.jsp?memid=" + memid);

    });



</script>



<jsp:include page="/footer.jsp"/>
