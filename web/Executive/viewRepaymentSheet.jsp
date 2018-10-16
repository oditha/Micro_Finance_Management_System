<%@page import="ORM.CenterHasStaff"%>
<%@page import="java.util.Iterator"%>
<%@page import="ORM.Staff"%>
<%@page import="ORM.Staff"%>
<%@page import="Srcs.PoolManager"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="ORM.Center"%>
<%@page import="org.hibernate.Criteria"%>

<%@page import="org.hibernate.Session"%>
<%@page import="Singleton.dateFormat"%>

<%
    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }
    PageTitleSet.getTitle().setPAGE_TITLE("Repayment sheet");

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/header.jsp"/>
<%@page import="Singleton.PageTitleSet"%>
<style>
    form .container{
        padding-top: 30px;
    }
    .btn-primary{
        color: white;
    }

    .table td, .table th {
        padding: 0;
        vertical-align: top;
        border-top: 1px solid rgba(0,0,0,.06);
    }
</style>
<script>
    $('#collapseOne').collapse("hide");


</script>

<div style="height: 10px;"></div>
<div class="card">
    <div class="card-header" id="headingOne">

        <h4>Repayment Sheet</h4>

    </div>
    <div class="card-block">
        <div class="container">
            <div class="row">	

                <div class="col-md-3">
                    <div class="form-group">
                        <div class="form-group">
                            <label for="formGroupExampleInput">Select Center</label>
                            <select class="form-control" id="center" name="center">
                                <option>Select</option>
                                <%                                      
                                    Session se = PoolManager.getSessionFactory().openSession();

                                    Criteria cr = se.createCriteria(Staff.class);
                                    cr.add(Restrictions.eq("idStaff", Integer.parseInt(session.getAttribute("id").toString())));

                                    Staff uq = (Staff) cr.uniqueResult();

                                    Iterator it = uq.getCenterHasStaffs().iterator();

                                    while (it.hasNext()) {

                                        CenterHasStaff elem = (CenterHasStaff) it.next();

                                %>


                                <option idCenter="<%= elem.getCenter().getIdCenter()%>"><%= elem.getCenter().getCenterNo() + "-" + elem.getCenter().getCenterName()%></option>


                                <%

                                    }
                                    se.close();


                                %>

                            </select>
                        </div>
                    </div>
                </div>



            </div>

        </div>

        <div class=" table-responsive ">          
            <table class="table table-bordered" id="repaymentSheet">
                <thead>
                    <tr>
                        <th> Group  </th>
                        <th>Mem No</th>
                        <th style="width: 300px;"> Name</th>
                        <th>Contact </th>
                        <th>Loan Amount</th>
                        <th>Rental</th>
                        <th>Total</th>
                        <th>(W1-Paid)</th>
                        <th>(W1-Corr)</th>
                        <th>(W2-Paid)</th>
                        <th>(W2-Corr)</th>
                        <th>(W3-Paid)</th>
                        <th>(W3-Corr)</th>
                        <th>(W4-Paid)</th>
                        <th>(W4-Corr)</th>
                        <th>(W5-Paid)</th>
                        <th>(W1-Corr)</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>

        </div>

    </div>

</div>


<script>
//------------------------------Load Datatable----------------------------------
    $(document).ready(function () {

        $("#repaymentSheet").DataTable({
            dom: 'Bfrtip',
            buttons: [
                'excel', 'pdf', 'print', 'colvis'
            ]
        });

    });

//-------------------------------load Repayment---------------------------------

    $("#center").change(function () {

        var idCenter = $("#center").find(":selected").val();
   var Center = $('#center option:selected').text();
        if (idCenter !== "Select") {

            $.ajax({
                method: "post",
                url: "../RepaymentSheetServlet",
                data: {idCenter: idCenter},
                success: function (res) {

                    if (res !== "error") {



                        var arr = JSON.parse(res);
                        arr.sort(sort_by('memNo', false, parseInt));

                        if ($.fn.dataTable.isDataTable('#repaymentSheet')) {
                            table = $('#repaymentSheet').DataTable();
                            table.destroy();
                        }


                        $("#repaymentSheet").DataTable({
                            dom: 'Bfrtip',
                            "order": [[1, "asc"]],
                            buttons: [
                                'copy',
                                {
                                    extend: 'excel',
                                    messageTop: 'The information in this table is copyright to Sirius Cybernetics Corp.'
                                },
                                {
                                    extend: 'pdf',
                                    messageBottom: null
                                },
                                {
                                    extend: 'print',
                                    title: '<div class=' + 'text-center' + '><h4>Canto Micro Commercial Investment (Pvt) Ltd <br> Repayment Sheet</h4>  </div>',
                                    messageTop: '<div class=' + 'text-center' + '>Center: ' + Center + '</div>'
                                    ,
                                    messageBottom: null,
                                    customize: function (win) {
                                        $(win.document.body)
                                                .css('font-size', '9pt')


                                        $(win.document.body).find('table')
                                                .addClass('compact')
                                                .css('font-size', '8pt');
                                    },
                                }
                            ],
                            data: arr,
                            columns: [
                                {data: 'group'},
                                {data: 'memNo'},
                                {data: 'memName'},
                                {data: 'contact'},
                                {data: 'loanAmount'},
                                {data: 'rental'},
                                {data: 'Remain'},
                                {data: 'week1'},
                                {data: 'week1'},
                                {data: 'week2'},
                                {data: 'week2'},
                                {data: 'week3'},
                                {data: 'week3'},
                                {data: 'week4'},
                                {data: 'week4'},
                                {data: 'week5'},
                                {data: 'week5'}
                            ]

                        });

                    } else {

                        $("#wentWrong").modal();

                    }






                }

            });


        }


    });


    $(document).ready(function () {
        $('#center').select2({
            
            width:'100%',
            
        });
    });


</script>


<jsp:include page="/footer.jsp"/>
