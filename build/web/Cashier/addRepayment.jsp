<%-- 
    Document   : regStaff
    Created on : Nov 21, 2017, 10:42:11 PM
    Author     : iamarshrx
--%>
<%@page import="org.hibernate.Session"%>
<%@page import="Srcs.PoolManager"%>
<%@page import="Servlets.MicroFinance.AddRepaymentALLAJAX"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="ORM.Center"%>

<%@page import="org.hibernate.Criteria"%>
<%@page import="Singleton.PageTitleSet"%>
<%
    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }
    PageTitleSet.getTitle().setPAGE_TITLE("Add Repayment");
 
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
    $('#collapseOne').collapse("hide");</script>
<!--<div style="height: 10px"></div>-->

<!--Alerts Section-->

<%    if (request.getParameter("save") != null) {

        if (request.getParameter("save").equals("done")) {

            out.print("<div class=\"alert alert-success\" role=\"alert\"><strong>Success!</strong> Data has been saved successfully.</div>");
%>

<script>

    window.open("../PaymentReceipt.jsp");

</script>



<% } else if (request.getParameter("save").equals("error")) {

            out.print("<div class=\"alert alert-danger\" role=\"alert\"><strong>Error!</strong> A problem has been occurred while submitting your data.</div>");

        } else if (request.getParameter("save").equals("delete")) {

            out.print("<div class=\"alert alert-warning\" role=\"alert\"><strong>Success!</strong> A record has been deleted.</div>");

        }

    }

    if (session.getAttribute("UserType").toString().equals("Cashier")) {

%>

<script>

    $('.drp-acc').attr('hidden', "");
    $('.drp-micro').attr('hidden', "");
    $('.drp-hr').attr('hidden', "");
    $('.drp-app').attr('hidden', "");
    $('.dsh').attr('hidden', "");




</script>


<%    }


%>
<!--<div style="height: 10px"></div>-->




<div id="accordion" role="tablist" aria-multiselectable="true">
    <div class="card">
        <div class="card-header text-right" role="tab" id="headingOne">

            <a class="btn btn-primary btn-sm" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                +Add All
            </a>

        </div>

        <div id="collapseOne" class="collapse " role="tabpanel" aria-labelledby="headingOne">
            <div class="card-block">

                <div class="col-md-3">
                    <div class="form-group">
                        <form action="addRepaymentBulk.jsp" method="POST">
                            <label for="exampleSelect1">Filter By Center</label>
                            <select class="form-control" id="selectCenter" name="selectCenter">
                                <option value="0">Select</option>
                                <%                                    Session sess = PoolManager.getSessionFactory().openSession();

                                    Criteria cr = sess.createCriteria(Center.class);
                                    cr.add(Restrictions.eq("isActive", "Active"));
                                    cr.add(Restrictions.eq("isApprove", "Approve"));

                                    List<Center> l = cr.list();

                                    for (Center c : l) {%>

                                <option value="<%= c.getIdCenter()%>"><%= c.getCenterNo() + " - " + c.getCenterName()%></option>

                                <%    }
                                    PoolManager.getSessionFactory().openSession().close();

                                %>

                            </select>
                            <div class="containerfluid text-right" style="padding-top: 10px;"><input type="submit" value="Filter" name="Search" class="btn btn-primary text-right btn-sm"></div>

                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div><!--

<!--Table Section-->

<!--<div style="height: 20px;"></div>-->
<!--<div class="card">

    <div class="card-block">-->
        <div class="container">
            <form action="../AddRepaymentCashierServlet" id="myForm0">
                <div class="container">
                    <div class="row">

                        <div class="col-md-1"></div>

                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="formGroupExampleInput">Search Member</label>
                                <input type="text" class="form-control" id="memberNo" placeholder="Enter Member ID/NIC" name="memberNo" required="" autofocus="">

                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Member Name</label>
                                <input type="text" style="background-color: white" class="form-control" id="memberName" placeholder="Member Name" name="memberName" readonly="">
                            </div>

                            <div class="form-group">
                                <label for="formGroupExampleInput">Center</label>
                                <input type="text" style="background-color: white" class="form-control" id="Center" placeholder="Center" name="Center" readonly="">
                            </div>


                        </div>
                        <div class="col-md-3">

                            <div class="form-group">
                                <label for="formGroupExampleInput">Contract No</label>
                                <input type="text" style="background-color: white" class="form-control" id="contractNo" placeholder="Contract No" name="contractNo" readonly="">

                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Loan Amount</label>
                                <input type="text" style="background-color: white" readonly="" class="form-control text-right" id="loanamount" placeholder="Loan Amount" name="loanamount">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Arrears</label>
                                <input type="text" style="background-color: white" readonly="" class="form-control text-right" id="Arrears" placeholder="Arrears" name="Arrears">
                            </div>

                            <!----------------hidden--------------->
                            <div class="form-group" hidden="">
                                <label for="formGroupExampleInput">Default Day</label>

                                <input class="form-control" type="text" value="" id="dday" name="dday">

                                <input type="text" class="form-control" id="IdLoan" placeholder="Loan ID" name="IdLoan">
                                <input type="text" class="form-control" id="balance" placeholder="Loan ID" name="balance">

                            </div>



                        </div>
                        <div class="col-md-3">

                            <div class="form-group">
                                <label for="formGroupExampleInput">Installment</label>
                                <input type="text" style="background-color: white" class="form-control font-weight-bold text-primary text-right" id="installment" placeholder="Installment" name="installment" readonly="">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Balance</label>
                                <input type="text" class="form-control font-weight-bold text-right" id="Balance" placeholder="Paid Amount" name="Balance">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Paid Amount</label>
                                <input type="text" class="form-control font-weight-bold text-right" id="Paid" placeholder="Paid Amount" name="Paid">
                            </div>

                            <div class="form-group text-right">

                                <!--<div style="height: 10px;"></div>-->
                                <input type="reset" value="Reset" name="Reset" class="btn btn-danger ">
                                <input type="submit" value="Save" name="submit" class="btn btn-primary" id="save">

                            </div>
                        </div>

                        <div class="col-md-1"></div>
                    </div>
                </div>
            </form>	

        </div>
<!--    </div>

</div>-->


<script>

//    $("#save").click(function() {
//    
//     $("#save").attr("disabled", "disabled");
//    
//});


    //--------------Search member and loan Records

    $('#memberNo').keyup(function (e) {

        var key = e.which;
        if (key === 35) {

            var value = $('#memberNo').val();
            $.ajax({
                method: 'post',
                url: '../SearchRepaymentDataAJAX',
                data: {value: value},
                success: function (response) {

                    if (response === 'SearchError') {


                        $('#adSearch').modal();

                    } else if (response === 'error') {


                        $("#wentWrong").modal();
                        $("#myForm0")[0].reset();
                        $("#memberNo").focus();

                    } else if (response === 'noAny') {


                        swal("Error", "No active loan for this member!", "error");

                        $("#myForm0")[0].reset();
                        $("#memberNo").focus();


                    } else {


                        var json = JSON.parse(response);

                        for (var i = 0; i < json.length; i++) {

                            var memberName = json[i].memberName;
                            var dday = json[i].dday;
                            var loanamount = json[i].loanamount;
                            var IdLoan = json[i].IdLoan;
                            var installment = json[i].installment;
                            var contractNo = json[i].contractNo;
                            var balance = json[i].balance;
                            var center = json[i].center;
                            var Arrears = json[i].Arrears;
                            var balance = json[i].balance;
                        }

                        $('#memberName').val(memberName);
                        $('#dday').val(dday);
                        $('#loanamount').val(loanamount);
                        $('#IdLoan').val(IdLoan);
                        $('#installment').val(installment);
                        $('#contractNo').val(contractNo);
                        $('#balance').val(balance);
                        $('#Center').val(center);
                        $('#Arrears').val(Arrears);
                        $('#Balance').val(balance);

                        $('#Paid').focus();
                    }

                }


            });
        }

    });
//--------------------------------------------Advanced Search-------------------

    $(document).ready(function () {

        $('#advButton').click(function () {

            $.ajax({
                method: 'post',
                url: '../SearchRepaymentAdDataAJAX',
                data: $('#advForm').serialize(),
                success: function (response) {

                    if (response === "SearchError") {

                        $("#adSearch").modal("toggle");
                        $("#searchError").modal();
                        $("#myForm0")[0].reset();
                        $("#memberNo").focus();

                    } else if (response === "error") {

                        $("#adSearch").modal("toggle");
                        $("#wentWrong").modal();
                        $("#myForm0")[0].reset();
                        $("#memberNo").focus();

                    } else if (response === "noAny") {

                        $("#adSearch").modal("toggle");
                        $("#noAny").modal();
                        $("#myForm0")[0].reset();
                        $("#memberNo").focus();


                    } else {

                        var json = JSON.parse(response);
                        for (var i = 0; i < json.length; i++) {

                            var memberName = json[i].memberName;
                            var dday = json[i].dday;
                            var loanamount = json[i].loanamount;
                            var IdLoan = json[i].IdLoan;
                            var installment = json[i].installment;
                            var contractNo = json[i].contractNo;
                            var balance = json[i].balance;
                        }

                        $('#memberName').val(memberName);
                        $('#dday').val(dday);
                        $('#loanamount').val(loanamount);
                        $('#IdLoan').val(IdLoan);
                        $('#installment').val(installment);
                        $('#contractNo').val(contractNo);
                        $('#balance').val(balance);
                        $("#memberNo").val($("#search").val());
                        $("#adSearch").modal("toggle");
                        $('#Paid').focus();

                    }

                }

            });
        });
    });

//--------------------------------------PAID AMOUNT VALIDATION-------------------------

    $("#Paid").keyup(function () {

        var balanceAmount = parseFloat($("#balance").val());
        var PaymentAmount = parseFloat($("#Paid").val());

        if (balanceAmount < PaymentAmount) {

            swal("Oops", "Repayment must not greater than balance amount.!", "error");


            $("#Paid").val("");
            $("#Paid").focus();


        }



    });

//-------------------------------------------LOAD TABLE-------------------------

//    $("#selectCenter").change(function () {
//
//        var center = $("#selectCenter").find(":selected").val();
//
//        if (center !== "Select") {
//            $.ajax({
//
//                method: "POST",
//                url: "../AddRepaymentALLAJAX",
//                data: {idCenter: center},
//
//                success: function (res) {
//
//                    var arr = JSON.parse(res);
//
//                    if (arr.length === 0) {
//
//                        alert("NO ACTIVE LOAN")
//                    } else {
//
//                        alert(res)
//
////                        $("#dataTB").createTable(arr);
////                        $("#repayTable").bootstrapTable({
////                            data: res
////                        });
//
//                        $("#dataTB").mrjsontable({
//                            tableClass: "my-table",
//                            pageSize: 10, //you can change the page size here
//                            columns: [
//                                new $.fn.mrjsontablecolumn({
//                                    heading: "Member No",
//                                    data: "memberNo"
//                                }),
//                                new $.fn.mrjsontablecolumn({
//                                    heading: "Name",
//                                    data: "nameWithInitials"
//                                }),
//                                new $.fn.mrjsontablecolumn({
//                                    heading: "Contract No",
//                                    data: "contractNo"
//                                })
//                            ],
//                            data: res
//                        });
//
//
//
//                    }
//
//
//                }
//
//
//            });
//        }
//
//
//    });



</script>



<jsp:include page="/Modals.jsp"/>
<jsp:include page="/footer.jsp"/>
