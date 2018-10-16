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
    PageTitleSet.getTitle().setPAGE_TITLE("Loan Index Report");

    try {
        if (!session.getAttribute("UserType").toString().equals("Manager")) {

            response.sendRedirect("/CMC/errorPage/401Unauthorized.html");

        }
    } catch (Exception e) {
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/header.jsp"/>
<%@page import="Singleton.PageTitleSet"%>
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

<!--<div class="card">
    <div class="card-block">-->
        <div class="container">
            <div class="row">	

                <div class="col-md-4">
                    <div class="form-group">
                        <label for="exampleSelect1">Filter By Center</label>
                        <select class="form-control" id="Center">
                            <option value="">Select</option>
                            <%                                Session se = PoolManager.getSessionFactory().openSession();
                                Criteria c = se.createCriteria(Center.class);
                                c.add(Restrictions.eq("isActive", "Active"));
                                c.add(Restrictions.eq("isApprove", "Approve"));

                                List<Center> l = c.list();

                                for (Center elem : l) {%>


                            <option value="<%= elem.getIdCenter()%>"><%= elem.getCenterNo() + " - " + elem.getCenterName()%></option>


                            <%    }
                                se.close();
                            %>

                        </select>
                        <!--<div class="containerfluid text-right" style="padding-top: 10px;"><input type="submit" value="Filter" name="Search" class="btn btn-primary text-right btn-sm "></div>-->

                    </div>
                </div>

                <div class="col-md-3">
                    <div class="form-group">
                        <label for="exampleSelect1">Select Month</label>
                        <select class="form-control" id="month">
                            <option value="">Select</option>
                            <option value="01">January</option>
                            <option value="02">February</option>
                            <option value="03">March</option>
                            <option value="04">April</option>
                            <option value="05">May</option>
                            <option value="06">June</option>
                            <option value="07">July</option>
                            <option value="08">August</option>
                            <option value="09">September</option>
                            <option value="10">October</option>
                            <option value="11">November</option>
                            <option value="12">December</option>
                        </select>

                    </div>
                </div>

                <div class="col-md-2">
                    <div class="form-group">
                        <label for="formGroupExampleInput">Enter Year</label>
                        <div style="height: 6px"></div>
                        <input type="number" class="form-control date-own" id="year" placeholder="Enter Year" name="activeLoan" value="<%= dateFormat.YearOnly()%>">
                        <div class="containerfluid text-right" style="padding-top: 10px;"><input type="submit" value="Filter" name="filter" id="filter" class="btn btn-primary text-right btn-sm "></div>

                    </div>
                </div>




            </div>

        </div>

        <div class=" table-responsive ">          
            <table class="table table-stripped" id="loanindextable">
                <thead>
                    <tr>

                        <th>Loan Index</th>
                        <th>Quantity</th>

                        <th>Total Loan</th>

                    </tr>
                </thead>

            </table>





        </div>

<!--    </div>

</div>-->


<script>

    $("#filter").click(function () {


        var center = $("#Center").find(":selected").val();
        var month = $("#month").find(":selected").val();
        var year = $("#year").val();

        $.ajax({
            method: "POST",
            url: "../ViewLoanIndexReport",
            data: {center: center, month: month, year: year},
            success: function (response) {

                if (response != "err") {

                    var arr = JSON.parse(response);
                    arr.sort(sort_by('index', false, parseInt));

                    if ($.fn.dataTable.isDataTable('#loanindextable')) {
                        table = $('#loanindextable').DataTable();
                        table.destroy();
                    }


                  $("#loanindextable").DataTable({
                        dom: 'Bfrtip',
                        "order": [[1, "asc"]],
                        buttons: [
                            'copy',
                            {
                                extend: 'excel',
                                messageTop: '.'
                            },
                            {
                                extend: 'pdf',
                                messageBottom: null
                            },
                            {
                                extend: 'print',

                            }
                        ],
                        data: arr,
                        columns: [
                            {data: 'index'},
                            {data: 'count'},
                            {data: 'total'},
                        ],
                        
                     

                    });



                }

            }

        });



    });

</script>


<jsp:include page="/Modals.jsp"/>
<jsp:include page="/footer.jsp"/>
