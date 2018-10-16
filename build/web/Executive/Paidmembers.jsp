<%-- 
    Document   : Paidmembers
    Created on : Mar 31, 2018, 8:04:21 PM
    Author     : arshak
--%>

<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="ORM.Staff"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="Srcs.PoolManager"%>
<%@page import="org.hibernate.Session"%>
<%@page import="Singleton.PageTitleSet"%>
<%
    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }
    PageTitleSet.getTitle().setPAGE_TITLE("Payment Summery");

 
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/header.jsp"/>


<div class="container">
    <div class="row">
        <div class="col-md-3">

            <div class="form-group">
                <label for="exampleFormControlInput1">Select Date</label>
                <input type="date" class="form-control" id="date" >
            </div>



        </div>

        <div class="col-md-3">

            <div class="form-group">
                <label for="exampleFormControlSelect1"> Select Member Type</label>
                <select class="form-control" id="membrcombo">
                    <option>Select</option>
                    <option>N/P Collection</option>
                    <option>Center Collection</option>
                    <option>Not Paid Members</option>
                    <option>Under Paid Members</option>
                    <option>Over Paid Members</option>

                </select>
            </div>



        </div>
        <div class="col-md-3">


            <div class="form-group">
                <label for="formGroupExampleInput">Filter by Executive</label>
                <select class="form-control" id="executive" name="executive">
                    <option>Select</option>

                    <%                                try {

                            Session sess = PoolManager.getSessionFactory().openSession();
                            Criteria cr = sess.createCriteria(Staff.class);
                            cr.add(Restrictions.eq("isActive", "Active"));
                              cr.add(Restrictions.eq("idStaff", Integer.parseInt(session.getAttribute("id").toString())));

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

        <div class="col-md-1">
            <br> <a class="btn btn-primary btn-filter" id=" btn-filter">Filter</a></div>
    </div>


</div>



<table class="table table-striped" id="tableLoan">
    <thead>
        <tr>

            <th>Member No</th>
            <th>Member Name</th>
            <th>Center</th>
            <th>Loan Amount</th>
            <th>Paid amount</th>
        </tr>
    </thead>
    <tbody>
    </tbody>

    <tfoot>
        <tr>
            <th colspan="4" style="text-align:right">Total:</th>
            <th></th>

        </tr>
    </tfoot>

</table>



<script>








    $(document).ready(function () {


        $(".btn-filter").click(function () {


            if ($('#date').val() !== "") {

                var exeid = $('#executive').val();

                if (document.getElementById("membrcombo").selectedIndex === 1) {


                    var date = $('#date').val();

                    $.ajax({
                        method: "POST",
                        url: "../viewNpaidMembersajax",
                        data: {date: date, exeid: exeid},
                        success: function (data) {



                            if ($.fn.dataTable.isDataTable('#tableLoan')) {
                                table = $('#tableLoan').DataTable();
                                table.destroy();
                            }


                            $("#tableLoan").DataTable({
                                dom: 'Bfrtip',
                                buttons: [
                                    'excel', 'pdf', 'print', 'colvis'
                                ],
                                data: JSON.parse(data),
                                columns: [

                                    {data: 'memberNo'},
                                    {data: 'memberName'},
                                    {data: 'centerName'},
                                    {data: 'LoanAmount'},
                                    {data: 'paidAmount'}


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

//                                    api.columns('.sum', {page: 'current'}).every(function () {
//                                        var sum = this
//                                                .data()
//                                                .reduce(function (a, b) {
//                                                    return intVal(a) + intVal(b);
//                                                }, 0);
//
//                                        this.footer().innerHTML = sum;
//                                    });


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


                        }



                    });


                } else if (document.getElementById("membrcombo").selectedIndex === 4) {

                    var exeid = $('#executive').val();
                    var date = $('#date').val();

                    $.ajax({
                        method: "POST",
                        url: "../viewunderpaidMembersajax",
                        data: {date: date, exeid: exeid},
                        success: function (data) {



                            if ($.fn.dataTable.isDataTable('#tableLoan')) {
                                table = $('#tableLoan').DataTable();
                                table.destroy();
                            }


                            $("#tableLoan").DataTable({
                                dom: 'Bfrtip',
                                buttons: [
                                    'excel', 'pdf', 'print', 'colvis'
                                ],
                                data: JSON.parse(data),
                                columns: [

                                    {data: 'memberNo'},
                                    {data: 'memberName'},
                                    {data: 'centerName'},
                                    {data: 'LoanAmount'},
                                    {data: 'paidAmount'}


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

//                                    api.columns('.sum', {page: 'current'}).every(function () {
//                                        var sum = this
//                                                .data()
//                                                .reduce(function (a, b) {
//                                                    return intVal(a) + intVal(b);
//                                                }, 0);
//
//                                        this.footer().innerHTML = sum;
//                                    });


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


                        }



                    });

                } else if (document.getElementById("membrcombo").selectedIndex === 5) {

                    var date = $('#date').val();

                    $.ajax({
                        method: "POST",
                        url: "../viewoverpaidMembersajax",
                        data: {date: date, exeid: exeid},
                        success: function (data) {



                            if ($.fn.dataTable.isDataTable('#tableLoan')) {
                                table = $('#tableLoan').DataTable();
                                table.destroy();
                            }


                            $("#tableLoan").DataTable({
                                dom: 'Bfrtip',
                                buttons: [
                                    'excel', 'pdf', 'print', 'colvis'
                                ],
                                data: JSON.parse(data),
                                columns: [

                                    {data: 'memberNo'},
                                    {data: 'memberName'},
                                    {data: 'centerName'},
                                    {data: 'LoanAmount'},
                                    {data: 'paidAmount'}


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

//                                    api.columns('.sum', {page: 'current'}).every(function () {
//                                        var sum = this
//                                                .data()
//                                                .reduce(function (a, b) {
//                                                    return intVal(a) + intVal(b);
//                                                }, 0);
//
//                                        this.footer().innerHTML = sum;
//                                    });


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


                        }



                    });


                } else if (document.getElementById("membrcombo").selectedIndex === 3) {


                    var date = $('#date').val();

                    $.ajax({
                        method: "POST",
                        url: "../viewNotpaidMembersajax",
                        data: {date: date, exeid: exeid},
                        success: function (data) {



                            if ($.fn.dataTable.isDataTable('#tableLoan')) {
                                table = $('#tableLoan').DataTable();
                                table.destroy();
                            }


                            $("#tableLoan").DataTable({
                                dom: 'Bfrtip',
                                buttons: [
                                    'excel', 'pdf', 'print', 'colvis'
                                ],
                                data: JSON.parse(data),
                                columns: [

                                    {data: 'memberNo'},
                                    {data: 'memberName'},
                                    {data: 'centerName'},
                                    {data: 'LoanAmount'},
                                    {data: 'paidAmount'}


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

//                                    api.columns('.sum', {page: 'current'}).every(function () {
//                                        var sum = this
//                                                .data()
//                                                .reduce(function (a, b) {
//                                                    return intVal(a) + intVal(b);
//                                                }, 0);
//
//                                        this.footer().innerHTML = sum;
//                                    });


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


                        }



                    });


                } else if (document.getElementById("membrcombo").selectedIndex === 2) {


                    var date = $('#date').val();

                    $.ajax({
                        method: "POST",
                        url: "../viewpaidMembersajax",
                        data: {date: date, exeid: exeid},
                        success: function (data) {



                            if ($.fn.dataTable.isDataTable('#tableLoan')) {
                                table = $('#tableLoan').DataTable();
                                table.destroy();
                            }


                            $("#tableLoan").DataTable({
                                dom: 'Bfrtip',
                                buttons: [
                                    'excel', 'pdf', 'print', 'colvis'
                                ],
                                data: JSON.parse(data),
                                columns: [

                                    {data: 'memberNo'},
                                    {data: 'memberName'},
                                    {data: 'centerName'},
                                    {data: 'LoanAmount'},
                                    {data: 'paidAmount'}


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

//                                    api.columns('.sum', {page: 'current'}).every(function () {
//                                        var sum = this
//                                                .data()
//                                                .reduce(function (a, b) {
//                                                    return intVal(a) + intVal(b);
//                                                }, 0);
//
//                                        this.footer().innerHTML = sum;
//                                    });


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


                        }

                    });

                }


            } else {

                swal("Oops", "Select Date First!", "error");

            }

        });


    });


</script>


<jsp:include page="/footer.jsp"/>