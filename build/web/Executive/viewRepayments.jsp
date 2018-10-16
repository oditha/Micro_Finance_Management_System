
<%@page import="ORM.CenterHasStaff"%>
<%@page import="java.util.Iterator"%>
<%@page import="ORM.Staff"%>
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
    PageTitleSet.getTitle().setPAGE_TITLE("View Repayments");

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/header.jsp"/>



<style>
    form .container{
        padding-top: 30px;
    }
    .btn-primary{
        color: white;
    }


</style>
<script>
    $('#collapseOne').collapse("hide");


</script>


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

<!--<div class="card">

    <div class="card-block">-->
        <div class="container">

            <table class="table table-striped table-responsive" id="tableLoan">
                <thead>
                    <tr>
                        <th>Member No</th>
                        <th>Member Name</th>
                        <th>Contract No</th>
                        <th>Receipt No</th>
                        <th>Loan Amount</th>
                        <th>Payment Date</th>
                        <th>Paid Amount</th>                    

                        <th>Action</th>
                    </tr>
                </thead>

                <%                    try {
                        Session ss = PoolManager.getSessionFactory().openSession();

                        Criteria cr = ss.createCriteria(Staff.class);

                        Criteria createCriteria = ss.createCriteria(Repayment.class);
                        createCriteria.add(Restrictions.eq("isActive", "Active"));
//                        createCriteria.add(Restrictions.eq("isAprove", "Approve"));
                        List<Repayment> list = createCriteria.list();
                        for (Repayment loan : list) {

                            if (loan.getLoan().getStatus().equals("Unpaid")) {

                                Iterator it = loan.getLoan().getMembers().getCenter().getCenterHasStaffs().iterator();

                                while (it.hasNext()) {

                                    CenterHasStaff chs = (CenterHasStaff) it.next();

                                    if (chs.getStaff().getNic().equals(session.getAttribute("nic").toString())) {

                %>
                <tr>

                    <td><%= loan.getLoan().getMembers().getMemberNo()%></td>
                    <td><%= loan.getLoan().getMembers().getNameWithInitials()%></td>
                    <td><%= loan.getLoan().getContractNo()%></td>
                    <td><%= loan.getRecieptNo()%></td>
                    <td><%= loan.getLoan().getLoanAmount()%></td>
                    <td><%= loan.getDate()%></td>
                    <td><%= loan.getPaidAmount()%></td>

                    <td> 

                        <button class="dropdown-item cancel" memna =" <%= loan.getLoan().getMembers().getNameWithInitials()%>" cno ="<%= loan.getLoan().getContractNo()%>"  idrepay = "<%= loan.getIdRePayment()%>" >Request Cancellation</button>
                        <button class="dropdown-item cancelrep" memna =" <%= loan.getLoan().getMembers().getNameWithInitials()%>" cno ="<%= loan.getLoan().getContractNo()%>"  idrepay = "<%= loan.getIdRePayment()%>" hidden="">Reprint Reciept</button>


                    </td>

                </tr>
                <%

                                    }

                                }

                            }
                        }
                        ss.close();
                    } catch (Exception e) {

                    }


                %>

                <tbody>

                </tbody>
                <tfoot>
                    <tr>
                        <td><div></div></td>
                        <td><div></div></td>
                        <td><div></div></td>
                        <td><div></div></td>
                        <td><div></div></td>
                        <td  id="repaymenttl" style="color: green"></td>

                    </tr>
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
            ]
        });


        var table = $('#tableLoan').DataTable();
        var sum = table.column(3).data().sum();

        $('#repaymenttl').append(sum);

    });

    //--------------------Request Modal------------



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
//            alert(reason)
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
