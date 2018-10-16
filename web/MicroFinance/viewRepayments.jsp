
<%@page import="ORM.Staff"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="Srcs.PoolManager"%>
<%@page import="ORM.Repayment"%>
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
    PageTitleSet.getTitle().setPAGE_TITLE("View Repayment");

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
        <div class="container">

            <div class="row" style="padding-bottom: 20px;">
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="formGroupExampleInput">Filter by Executive</label>
                        <select class="form-control" id="executive" name="executive">
                            <option>Select</option>

                            <%                                try {

                                    Session sess = PoolManager.getSessionFactory().openSession();
                                    Criteria cr = sess.createCriteria(Staff.class);
                                    cr.add(Restrictions.eq("isActive", "Active"));
                                    //cr.add(Restrictions.eq("position", "Executive"));

                                    List<Staff> list = cr.list();

                                    for (Staff stf : list) {

                            %>


                            <option value="<%=stf.getIdStaff()%>"><%=stf.getNameWithinitials()%></option>


                            <%

                                    }

                                    sess.close();

                                } catch (Exception e) {
                                    e.printStackTrace();

                                }

                            %>
                        </select>
                    </div>

                </div>
                <div class="col-md-3"></div>
                <div class="col-md-3"></div>
            </div>



            <table class="table table-responsive table-sm" id="tableLoan">
                <thead>
                    <tr>
                        <th>Member No</th>
                        <th>Member Name</th>
                        <th>Contract No</th>
                        <th>Receipt No</th>
                        <th>Loan Amount</th>
                        <th>Payment Date</th>
                        <th>Paid Amount</th>                    
                        <th>Center</th>                    

                        <th>Action</th>
                    </tr>
                </thead>

                <%                    try {
                        Session ss = PoolManager.getSessionFactory().openSession();
                        Criteria createCriteria = ss.createCriteria(Repayment.class);
                        createCriteria.add(Restrictions.eq("isActive", "Active"));
//                        createCriteria.add(Restrictions.eq("isAprove", "Approve"));
                        createCriteria.addOrder(Order.desc("date"));
                        List<Repayment> list = createCriteria.list();
                        for (Repayment loan : list) {
                
                        if (loan.getLoan().getStatus().equals("Unpaid")) {
                                
                            
                
                
                %>
                <tr>

                    <td><%= loan.getLoan().getMembers().getMemberNo()%></td>
                    <td><%= loan.getLoan().getMembers().getNameWithInitials()%></td>
                    <td><%= loan.getLoan().getContractNo()%></td>
                    <td><%= loan.getRecieptNo() %></td>
                    <td><%= loan.getLoan().getLoanAmount()%></td>
                    <td><%= loan.getDate()%></td>
                    <td><%= loan.getPaidAmount()%></td>
                    <td><%= loan.getLoan().getMembers().getCenter().getCenterName()%></td>

                    <td> 

                        <button class="dropdown-item cancel" memna =" <%= loan.getLoan().getMembers().getNameWithInitials()%>" cno ="<%= loan.getLoan().getContractNo()%>"  idrepay = "<%= loan.getIdRePayment()%>" >Request Cancellation</button>
                        <button class="dropdown-item cancelREP" memna =" <%= loan.getLoan().getMembers().getNameWithInitials()%>" cno ="<%= loan.getLoan().getContractNo()%>"  idrepay = "<%= loan.getIdRePayment()%>" hidden="">Reprint Reciept</button>


                    </td>

                </tr>
                <% }}
                        ss.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }


                %>

                <tbody>

                </tbody>
                <tfoot>
                  
                </tfoot>
            </table>

        </div>
<!--    </div>

</div>-->


<script>







    $(document).ready(function () {
//        $('#tableCenters').DataTable();
        $('#tableLoan').DataTable({
            dom: 'Bfrtip',
            buttons: [
                'copy', 'excel', 'pdf', 'print', 'colvis'
            ],
            "order": [[4, "desc"]]

        });








    });

    //--------------------Request Modal------------

    $(document).ready(function () {

        $("#executive").change(function () {

            // var type = $("#MemFilter").find(":selected").text();
            var IDCenter = $("#executive").val();
            var table2 = $('#tableLoan').DataTable();
            table2
                    .clear()
                    .draw();



//
            $.ajax({
                method: "post",
                url: "../RepaymentExecutivefilter",
                data: {idCenter: IDCenter},
                success: function (res) {

//                   


                    if (res !== "error") {

                        var json = JSON.parse(res);

                        if ($.fn.dataTable.isDataTable('#tableLoan')) {
                            table = $('#tableLoan').DataTable();
                            table.destroy();
                        }


                        $("#tableLoan").DataTable({
                            data: json,
                            columns: [
                                {data: 'memno'},
                                {data: 'memname'},
                                {data: 'ContractNo'},
                                {data: 'ReceiptNo'},
                                {data: 'Loanamount'},
                                {data: 'date'},
                                {data: 'paidamount'},
                                {data: 'center'},
                                {data: 'btn'}
                            ]

                        });


                        $(".cancel").click(function () {

                            var loanid = $(this).attr("idrepay");
                            var contract = $(this).attr("cno");
                            var name = $(this).attr("memna");

                            $("#idlore").val(loanid);
                            $("#connore").val(contract);
                            $("#mnamere").val(name);


                            $("#requestCancelPayment").modal();

                        });
                        $("#requestbtnre").click(function () {


                            var idloan = $("#idlore").val();
                            var reason = $("#exampleFormControlTextarea1").val();


                            $.ajax({

                                url: "../RequestPaymentCancellation",
                                data: {idloan: idloan, reason: reason},
                                success: function (response) {

                                    if (response === "OK") {
                                        $("#requestCancelPayment").modal('toggle');

                                        swal("Sucess!", "Your Request Waiting for Approval !", "success");

                                    } else {

                                        $("#requestCancelPayment").modal('toggle');
                                        swal("Error!", "Something went wrong. Try again later !", "error");


                                    }

                                }


                            });


                        });

                    } else {

                       swal("Error!", "Something went wrong. Try again later !", "error");

                    }

                }

            });
//




        });

    });



    $(".cancel").click(function () {


        var loanid = $(this).attr("idrepay");
        var contract = $(this).attr("cno");
        var name = $(this).attr("memna");

        $("#idlore").val(loanid);
        $("#connore").val(contract);
        $("#mnamere").val(name);

 $(document).ready(function () {



        $("#requestCancelPayment").modal();


    });


    });
   


//----------------------Request Canecel---------------------------
    $(document).ready(function () {


        $("#requestbtnre").click(function () {


            var idloan = $("#idlore").val();
            var reason = $("#exampleFormControlTextarea1").val();


            $.ajax({

                url: "../RequestPaymentCancellation",
                data: {idloan: idloan, reason: reason},
                success: function (response) {

                    if (response === "OK") {
                        $("#requestCancelPayment").modal('toggle');

                        swal("Sucess!", "Your Request Waiting for Approval !", "success");

                    } else {

                        $("#requestCancelPayment").modal('toggle');
                        swal("Error!", "Something went wrong. Try again later !", "error");


                    }

                }


            });


        });
    });






</script>


<jsp:include page="/Modals.jsp"/>
<jsp:include page="/footer.jsp"/>
