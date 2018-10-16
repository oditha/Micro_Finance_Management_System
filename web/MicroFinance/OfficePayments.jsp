
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
    PageTitleSet.getTitle().setPAGE_TITLE("View Office Payments");

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

            <div class="row">

                <div class="col-md-12">

              
                        <p>Filter by date</p>
                    
                    <div class="card-body">
                        <form class="form-inline">

                            <div class="form-group">
                                <label for="inlineFormInputGroup" class="sr-only">Select Date</label>
                                <input placeholder="Select Date" class="mr-3 form-control form-control" type="date" id="getdate">
                            </div>
                            <div class="form-group">
                                <input value="Submit" id="filter" class="mr-3 btn btn-primary" type="button">
                            </div>
                        </form>
                    </div>

                </div>

            </div>

            <div class="row">

                <div class="col-md-12">

                    <table class="table table-striped" id="tableLoan">
                        <thead>
                            <tr>
                                <th>Member No</th>
                                <th>Member Name</th>

                                <th>Receipt No</th>

                                <th>Payment Date</th>
                                <th>Paid Amount</th>                    
                                <th>Center</th>                    


                            </tr>
                        </thead>
                        <tbody>

                        </tbody>
                         <tfoot>
                        <tr>
                            <th colspan="4" style="text-align:right">Total:</th>
                            <th colspan="2"></th>

                        </tr>
                    </tfoot>
                    </table>

                </div>



            </div>



        </div>
<!--    </div>

</div>-->


<script>

//    $(document).ready(function () {
////        $('#tableCenters').DataTable();
//        $('#tableLoan').DataTable({
//            dom: 'Bfrtip',
//            buttons: [
//                'copy', 'excel', 'pdf', 'print', 'colvis'
//            ],
//            "order": [[4, "desc"]]
//
//        });
//
//    });

    //--------------------Request Modal------------



    $("#filter").click(function () {

        // var type = $("#MemFilter").find(":selected").text();
        var date = $("#getdate").val();

        $.ajax({
            method: "post",
            url: "../RepaymentOfficeFilter",
            data: {date: date},
            success: function (res) {


                if (res !== "error") {

                    var json = JSON.parse(res);

                    if ($.fn.dataTable.isDataTable('#tableLoan')) {
                        table = $('#tableLoan').DataTable();
                        table.destroy();
                    }


                    $("#tableLoan").DataTable({
                        buttons: [
                            'copy', 'excel', 'pdf', 'print', 'colvis'
                        ],
                        data: json,
                        columns: [
                            {data: 'memno'},
                            {data: 'memname'},
                            {data: 'receipt'},
                            {data: 'date'},
                            {data: 'paidamount'},
                            {data: 'center'},
                        ],
                        "order": [[2, "asc"]],
                        "columnDefs": [

                            {className: "text-right", "targets": [4]},
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

                } else {

                    swal("Error!", "Something went wrong. Try again later !", "error");

                }

            }

        });
//




    });








</script>


<jsp:include page="/Modals.jsp"/>
<jsp:include page="/footer.jsp"/>
