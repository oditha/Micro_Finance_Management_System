
<%@page import="ORM.Repayment"%>
<%@page import="ORM.CenterHasStaff"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="ORM.Loancancellation"%>
<%@page import="java.util.Iterator"%>
<%@page import="Srcs.PoolManager"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="Singleton.decimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="ORM.Loan"%>
<%@page import="org.hibernate.Criteria"%>

<%@page import="org.hibernate.Session"%>
<%@page import="Singleton.PageTitleSet"%>
<%
    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }
    PageTitleSet.getTitle().setPAGE_TITLE("View Loan");

    try {
        if (!session.getAttribute("UserType").toString().equals("Manager")) {

            response.sendRedirect("/CMC/errorPage/401Unauthorized.html");

        }
    } catch (Exception e) {
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/header.jsp"/>



<!--<style>
    form .container{
        padding-top: 30px;
    }
    .btn-primary{
        color: white;
    }


</style>-->
<script>
    $('#collapseOne').collapse("hide");


</script>
<!--<div style="height: 10px"></div>-->

<!--Alerts Section-->

<%    if (request.getParameter("save") != null) {

        if (request.getParameter("save").equals("done")) {

            out.print("<div class=\"alert alert-success\" role=\"alert\"><strong>Success!</strong> Data has been saved successfully.</div>");

        } else if (request.getParameter("save").equals("error")) {

            out.print("<div class=\"alert alert-danger\" role=\"alert\"><strong>Error!</strong> A problem has been occurred while submitting your data.</div>");

        } else if (request.getParameter("save").equals("delete")) {

            out.print("<div class=\"alert alert-warning\" role=\"alert\"><strong>Success!</strong> A record has been deleted.</div>");

        }

    }

%>
<!--<div style="height: 10px"></div>-->




<!--Table Section-->
<!--<div style="height: 10px;"></div>-->
<!--<div class="card">

    <div class="card-block">-->
<!--<div class="container-fluid">-->

<table class="table table-responsive " id="tableLoan">
    <thead>
        <tr>
            <th>Contract No</th>
            <th>Member No</th>
            <th>Member Name</th>
            <th>Center</th>
            <th>Loan Amount</th>
            <th>Interest</th>   
            <th>Issued Date</th>
            <th>Paid Amount</th>
            <th>Balance</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%                    try {

                Session ss = PoolManager.getSessionFactory().openSession();
                Criteria createCriteria = ss.createCriteria(Loan.class);
                createCriteria.add(Restrictions.eq("isActive", "Active"));
                createCriteria.add(Restrictions.eq("isAprove", "Approve"));
                createCriteria.addOrder(Order.desc("idLoan"));
                List<Loan> list = createCriteria.list();
                for (Loan loan : list) {

                    Double paymets = 0.00;

                    Iterator<Repayment> itt = loan.getRepayments().iterator();
                    while (itt.hasNext()) {
                        Repayment elem = itt.next();

                        if (elem.getIsActive().equals("Active") && elem.getIsAproved().equals("Approve")) {
                            paymets += elem.getPaidAmount();

                        }

                    }

                    if (loan.getStatus().equals("Unpaid")) {

                        out.write("<tr class=\"text-danger\">");

                    } else {

                        out.write("<tr>");
                    }

        %>


        <!--<tr class="text-success">-->
    <td><%= loan.getContractNo()%></td>
    <td><%= loan.getMembers().getMemberNo()%></td>
    <td><%= loan.getMembers().getNameWithInitials()%></td>
    <td><%= loan.getMembers().getCenter().getCenterName()%></td>
    <td class="text-right"><%= loan.getLoanAmount()%></td>
    <td class="text-right"><%= loan.getLoanInterest()%></td>
    <td><%=  loan.getIssueDate()%></td>
    <td class="text-right"><%= paymets%></td>
    <td class="text-right"><%= (loan.getLoanAmount() + loan.getLoanInterest()) - paymets%></td>


    <td> <div class="dropdown">
            <button type="button" class="btn btn-primary btn-sm dropdown-toggle men" data-toggle="dropdown" idloan = <%= loan.getIdLoan()%>>
                Action
            </button>
            <div class="dropdown-menu "  >
                <button class="dropdown-item viewDetails btn"  idloan = <%= loan.getIdLoan()%>>View Details</button>
                <button class="dropdown-item cancel btn" memna =" <%= loan.getMembers().getNameWithInitials()%>" cno ="<%= loan.getContractNo()%>"  idloan = "<%= loan.getIdLoan()%>" >Request Cancellation</button>
                <button class="dropdown-item req " memna =" <%= loan.getMembers().getNameWithInitials()%>" cno ="<%= loan.getContractNo()%>"  idloan = "<%= loan.getIdLoan()%>" > <i>Cancellation Already Requested</i></button>
                <button class="dropdown-item payment-History btn"  idloan = <%= loan.getIdLoan()%>>View Payment History </button>

            </div>
        </div> </td>

</tr>

<%
        }

        ss.close();

    } catch (Exception e) {

    }


%>



</tbody>
<tfoot>
    <tr>
        <th colspan="4" style="text-align:right">Total:</th>
        <th colspan="4"></th>

    </tr>
</tfoot>  
</table>

<!--</div>-->
<!--    </div>

</div>-->

<div class="modal Payment-Historymod" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">View Payment History</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">


                <table class="table " id="table-re">
                    <thead>
                        <tr>
                            <th>Reciept No</th>
                            <th>Paid date </th>
                            <th>Amount</th>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>




            </div>
            <div class="modal-footer">
                <div class="form-group">
                    <!--    <label for="formGroupExampleInput">Example label</label>
                        <input type="text" class="form-control" id="formGroupExampleInput" placeholder="Example input">-->
                </div>
            </div>
        </div>
    </div>
</div>               





<script>
    $(document).ready(function () {
//        $('#tableCenters').DataTable();
        $('#tableLoan').DataTable({
            dom: 'Bfrtip',
            buttons: [
                'copy', 'excel', 'pdf', 'print', 'colvis'
            ],

            "footerCallback": function (row, data, start, end, display) {
                var api = this.api(), data;

                // Remove the formatting to get integer data for summation
                var intVal = function (i) {
                    return typeof i === 'string' ?
                            i.replace(/[\$,]/g, '') * 1 :
                            typeof i === 'number' ?
                            i : 0;
                };



                // Total over all pages
                total = api
                        .column(4)
                        .data()
                        .reduce(function (a, b) {
                            return intVal(a) + intVal(b);
                        }, 0);

                // Total over this page
                pageTotal = api
                        .column(4, {page: 'current'})
                        .data()
                        .reduce(function (a, b) {
                            return intVal(a) + intVal(b);
                        }, 0);

                // Update footer
                $(api.column(4).footer()).html(
                        'Rs ' + pageTotal + ' ( Rs ' + total + ' total)'
                        );
            }

        });


    });


    //--------------------View Loan Details-------------------

    $('.viewDetails').click(function () {


        var loanID = $(this).attr('idloan');


        $.ajax({
            url: '../ViewLoanRecordsServlet',
            data: {loanID: loanID},
            success: function (responseText) {

                if (responseText === "error") {

                    $(document).ready(function () {
                        $(".viewDetails").click(function () {
                            $("#wentWrong").modal();
                        });
                    });

                } else {

                    var ja = JSON.parse(responseText);
                    for (var i = 0; i < ja.length; i++) {

                        var ContractNO = ja[i].ContractNO;
                        var loanIndex = ja[i].loanIndex;
                        var loanAmount = ja[i].loanAmount;
                        var loanInterset = ja[i].loanInterset;
                        var loanPeriod = ja[i].loanPeriod;
                        var loanInstallment = ja[i].loanInstallment;
                        var loanIssueDate = ja[i].loanIssueDate;
                        var loanRepaymentDay = ja[i].loanRepaymentDay;
                        var gur1 = ja[i].gur1;
                        var gur2 = ja[i].gur2;
                        var Status = ja[i].Status;
                        var CreateBy = ja[i].CreateBy;



                    }


                    $('#ContractNO').attr('value', ContractNO);
                    $('#loanIndex').attr('value', loanIndex);
                    $('#loanAmount').attr('value', loanAmount);
                    $('#loanInterset').attr('value', loanInterset);
                    $('#loanPeriodAll Centers').attr('value', loanPeriod);
                    $('#loanInstallment').attr('value', loanInstallment);
                    $("#loanIssueDate").val(loanIssueDate);
                    $("#loanRepaymentDay").val(loanRepaymentDay);
                    $("#gur1").val(gur1);
                    $("#gur2").val(gur2);
                    $("#Status").val(Status);
                    $("#CreateBy").val(CreateBy);

                    $(document).ready(function () {
                        $(".viewDetails").click(function () {
                            $("#viewLoanRec").modal();
                        });
                    });

                }



            }


        });


    });

    //--------------------Request Modal------------

//    $(document).ready(function () {

    $(".cancel").click(function () {

        var loanid = $(this).attr("idloan");
        var contract = $(this).attr("cno");
        var name = $(this).attr("memna");

        $("#idlo").val(loanid);
        $("#conno").val(contract);
        $("#mname").val(name);


        $("#requestCancel").modal();

    });

//    });



//    $(document).ready(function () {

    $(".men").click(function () {

        var loanid = $(this).attr("idloan");

        $.ajax({
            url: "../LoanCancelRequestCheckAjax",
            data: {idloan: loanid},
            success: function (response) {
//alert(response);
                if (false) {
                    $(".cancel").attr("hidden", "true");
                    $(".req").removeAttr("hidden");
                    // $("#exampleFormControlTextarea1re").val("");
                    // $("#requestDone").modal();

                } else {

                    $(".cancel").removeAttr("hidden");

                    $(".req").attr("hidden", "true");
                    // $("#wentWrong").modal();

                }

            }


        });



    });

//    });
//    $(document).ready(function () {

    $(".payment-History").click(function () {

        var loanID = $(this).attr('idloan');

        //alert(loanID);

        //$('.Payment-Historymod').modal();
        $.ajax({
            url: '../RepaymentHistory',
            data: {loanID: loanID},
            success: function (responseText) {



                if ($.fn.dataTable.isDataTable('#table-re')) {
                    table = $('#table-re').DataTable();
                    table.destroy();
                }


                $("#table-re").DataTable({
                    dom: 'Bfrtip',
                    buttons: [
                        'excel', 'pdf', 'print', 'colvis'
                    ],
                    data: JSON.parse(responseText),
                    columns: [

                        {data: 'Reciptno'},
                        {data: 'PaidDate'},
                        {data: 'amount'}



                    ]

                });

                $('.Payment-Historymod').modal();




            }


        });

    });

//    });

//----------------------Request Canecel---------------------------
    $(document).ready(function () {


        $("#requestbtn").click(function () {


            var idloan = $("#idlo").val();
            var reason = $("#exampleFormControlTextarea1re").val();
            //  alert(reason);

            $.ajax({
                url: "../RequestLoanCancellation",
                data: {idloan: idloan, reason: reason},
                success: function (response) {

                    if (response === "OK") {
                        $("#requestCancel").modal('toggle');
                        $("#exampleFormControlTextarea1re").val("");
                        $("#requestDone").modal();


                        var loanid = $(this).attr("idloan");

                        $.ajax({
                            url: "../LoanCancelRequestCheckAjax",
                            data: {idloan: loanid},
                            success: function (response) {
//alert(response);
                                if (false) {
                                    $(".cancel").attr("hidden", "true");
                                    $(".req").removeAttr("hidden");
                                    // $("#exampleFormControlTextarea1re").val("");
                                    // $("#requestDone").modal();

                                } else {
                                    $(".cancel").removeAttr("hidden");

                                    $(".req").attr("hidden", "true");
                                    // $("#wentWrong").modal();

                                }

                            }


                        });


                    } else {

                        $("#wentWrong").modal();

                    }

                }


            });


        });
    });

</script>


<jsp:include page="/Modals.jsp"/>
<jsp:include page="/footer.jsp"/>
