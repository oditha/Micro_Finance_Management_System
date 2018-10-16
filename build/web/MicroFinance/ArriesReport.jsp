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
    PageTitleSet.getTitle().setPAGE_TITLE("Arrears Report");

    try {
        if (!session.getAttribute("UserType").toString().equals("Manager")) {

            response.sendRedirect("/CMC/errorPage/401Unauthorized.html");

        }
    } catch (Exception e) {
    }


%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/header.jsp"/>


<div class="container">
    <div class="row">
      
        <div class="col-md-4">


            <div class="form-group">
                <label for="formGroupExampleInput">Filter by Executive</label>
                <select class="form-control" id="executive" name="executive">
                    <option>Select</option>

                    <%                                try {

                            Session sess = PoolManager.getSessionFactory().openSession();
                            Criteria cr = sess.createCriteria(Staff.class);
                            cr.add(Restrictions.eq("isActive", "Active"));
                            //  cr.add(Restrictions.eq("position", "Executive"));

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
            <th>Contact No</th>
            <th>Center</th>
            <th>Loan Amount</th>
            <th>Arrears Amount</th>
            <th>Arrears Age</th>
        </tr>
    </thead>
    <tbody>
    </tbody>

    <tfoot>
        <tr>
            <th colspan="4" style="text-align:right">Total:</th>
            <th colspan="3"></th>

        </tr>
    </tfoot>

</table>



<script>








    $(document).ready(function () {


        $(".btn-filter").click(function () {


            if (true) {

                var exeid = $('#executive').val();
                var type = "ALL";
                if (document.getElementById("executive").selectedIndex === 0) {

                    type = "ALL"

                } else {
                    type = "EXE"
                }




                $.ajax({
                    method: "POST",
                    url: "../viewArriesReport",
                    data: {exeid: exeid, type: type},
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
                                {data: 'contact'},
                                {data: 'centerName'},
                                {data: 'LoanAmount'},
                                {data: 'arr'},
                                {data: 'arrage'},
                            ],
                            "columnDefs": [
                                {"className": "text-right", "targets": [4]},
                                {"className": "text-right", "targets": [5]},
                                {"className": "text-right", "targets": [6]}
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


                    }



                });




            } else {

                swal("Oops", "Select Date First!", "error");

            }

        });


    });


</script>


<jsp:include page="/footer.jsp"/>