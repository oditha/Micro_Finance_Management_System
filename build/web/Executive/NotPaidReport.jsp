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
    PageTitleSet.getTitle().setPAGE_TITLE("N/P Weekly Report");


%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/header.jsp"/>


<div class="container">
    <div class="row">
        <div class="col-md-3">

            <div class="form-group">
                <label for="exampleFormControlInput1">Start Date</label>
                <input type="date" class="form-control" id="startdate" >
            </div>



        </div>
        <div class="col-md-3">

            <div class="form-group">
                <label for="exampleFormControlInput1">End Date</label>
                <input type="date" class="form-control" id="enddate" >
            </div>



        </div>

        <div class="col-md-3">


            <div class="form-group">
                <label for="formGroupExampleInput">Filter by Executive</label>
                <select class="form-control" id="executive" name="executive">


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



<table class="table table-striped table-responsive table-sm" id="tableLoan">
    <thead>
        <tr>

            <th>Member No</th>
            <th>Member Name</th>
            <th>Center</th>
            <th>Contact No</th>
            <th>Loan Amount</th>
            <th>Paid Amount</th>
            <th>Balance</th>
            <th>Installment</th>
            
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


            if ($('#startdate').val() !== "" && $('#enddate').val() !== "") {

                var exeid = $('#executive').val();
                var type = "EXE";

                var startdate = $('#startdate').val();
                var enddate = $('#enddate').val();

                $.ajax({
                    method: "POST",
                    url: "../viewNPReport",
                    data: {startdate: startdate, exeid: exeid, enddate: enddate, type: type},
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
                                {data: 'paidAmount'},
                                {data: 'LoanAmount'},
                                {data: 'paid'},
                                {data: 'balance'},
                                {data: 'installment'},
                            ],
                            "columnDefs": [
                                {"className": "text-right", "targets": [4]},
                                {"className": "text-right", "targets": [5]},
                                {"className": "text-right", "targets": [6]},
                                {"className": "text-right", "targets": [7]},
                            ],

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