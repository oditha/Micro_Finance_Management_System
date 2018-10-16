<%@page import="Srcs.PoolManager"%>
<%@page import="ORM.Staff"%>
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
    PageTitleSet.getTitle().setPAGE_TITLE("Collection Report");

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
<style>
    form .container{
        padding-top: 30px;
    }
    /*    .btn-primary{
            color: white;
        }*/


</style>

<style>
    th { white-space: nowrap; }

</style>

<script>
    $('#collapseOne').collapse("hide");


</script>
<!--<div style="height: 10px"></div>

<div style="height: 10px;"></div>-->
<!--<div class="card">
    <div class="card-block">-->
<div class="container">
    <div class="row">	

        <div class="col-md-4">

            <div class="form-group">
                <label for="formGroupExampleInput">Filter by Executive</label>
                <select class="form-control" id="exe" name="Executive">
                    <option>Select</option>

                    <%                                            Session s1 = PoolManager.getSessionFactory().openSession();
                        Criteria cr1 = s1.createCriteria(Staff.class);
                        cr1.add(Restrictions.eq("isActive", "Active"));
                        List<Staff> st = cr1.list();

                        for (Staff stf : st) {%>


                    <option idStaff ="<%= stf.getIdStaff()%>" ><%= stf.getNic() + " - " + stf.getNameWithinitials()%></option>

                    <% }
                        s1.close();
                    %>


                </select>
                <!--<div class="containerfluid text-right" style="padding-top: 10px;"><input type="submit" value="Filter" name="Search" class="btn btn-primary text-right btn-sm "></div>-->

            </div>
        </div>
        <div class="col-md-4">

            <div class="form-group">
                <label for="formGroupExampleInput">Select Date</label>
                <!--<div style="height: 6px"></div>-->
                <input type="date" class="form-control" id="getDate" placeholder="Enter Member ID or NIC" name="memberid" value="">
                <br>
                <div class="form-check">
                    <label class="form-check-label" hidden="">
                        <input type="checkbox" class="form-check-input" value="" id="viewall">View All
                    </label>
                </div>




            </div>



        </div>

        <div class="col-md-3">

            <div class="" style="padding-top: 40px;"><input type="submit" value="Filter" name="Search" id="filter" class="btn btn-primary text-right btn-sm "></div>


        </div>


    </div>

</div>
<hr>
<div class="container">
    <div class="row">



        <div class="col-md-3">
            <div class="form-group">
                <label for="formGroupExampleInput">Total Collection</label>
                <input type="text" style="background-color: white" class="form-control text-right" id="collection" placeholder="Total Collection" name="collection" readonly="">

            </div>


        </div>
        <div class="col-md-3">
            <div class="form-group">
                <label for="formGroupExampleInput">Total NP Collection</label>
                <input type="text" style="background-color: white" class="form-control text-right" id="npcollection" placeholder="Total NP Collection" name="npcollection" readonly="">
            </div>

        </div>
        <div class="col-md-3">
            <div class="form-group">
                <label for="formGroupExampleInput">Total Member Fees</label>
                <input class="form-control text-right" style="background-color: white" type="text" value="" id="fees" name="FEES" placeholder="Total Member Fees" readonly="">


            </div>


        </div>
        <div class="col-md-3">
            <div class="form-group">
                <label for="formGroupExampleInput" >Total Office Payments</label>
                <input class="form-control " style="background-color: white" type="text" value="" id="loans" name="loans" placeholder="Total Office Payments" readonly="">


            </div>


        </div>

    </div>
</div>


<div class="container">
    <div class="row">



        <table class="table table-responsive">
            <thead>
                <tr>
                    <th scope="col">Center No</th>
                    <th scope="col">Center Name</th>
                    <th scope="col" class="sum">Total Collection</th>
                    <th scope="col" class="sum">Total Underpayment</th>
                    <th scope="col" class="sum">Not Paid Count</th>
                    <th scope="col" class="sum">Under Paid Count</th>
                    <th scope="col" class="sum">Not paid Total</th>
                    <th scope="col" class="sum">Percentage</th>

                    <!--<th scope="col">Total Loan</th>-->
                </tr>
            </thead>
            <tbody>
            </tbody>
            <tfoot>
                <tr>
                    <th colspan="2" style="text-align:right">Total:</th>
                    <th></th>

                </tr>
            </tfoot>

        </table>




    </div>
</div>




<!--    </div>

</div>-->

<script>

//--------------------------Search Data-----------------------------------------
    $(document).ready(function () {
        $('#center').select2({

            width: '100%',

        });
    });

    $("#filter").click(function () {


        var center = $("#center").find(":selected").text();
        var exe = $("#exe").find(":selected").text();
        var day = $("#getDate").val();

//        alert(day)

        if (exe !== "Select" && day !== null) {

            //Search with exective
            var staff = $("#exe").find(":selected").attr("idStaff");
            // alert("STAFF")
            $.ajax({
                method: "POST",
                url: "../ViewCenterCollection",
                data: {staffID: staff, date: day, type: "exe"},
                success: function (data) {
                    
                    
                    
                    var js = JSON.parse(data);

                    var collection = js[0].collection;
                    var npcollection = js[0].notpaid;
                    var fees = js[0].memberFee;
                    var loans = js[0].totalLoan;

                    $("#collection").val(collection);
                    $("#npcollection").val(npcollection);
                    $("#fees").val(fees);
                    $("#loans").val(loans);

                }

            });
            $.ajax({
                method: "POST",
                url: "../ViewCenterCollectionTble",
                data: {staffID: staff, date: day, type: "exe"},
                success: function (data) {


                    var js = JSON.parse(data);

                    if ($.fn.dataTable.isDataTable('.table')) {
                        table = $('.table').DataTable();
                        table.destroy();
                    }


                    $(".table").DataTable({
                        dom: 'Bfrtip',
                        buttons: [
                            'excel', 'pdf', 'print', 'colvis'
                        ],
                        "columnDefs": [
                            {className: "text-right", "targets": [2]},
                            {className: "text-right", "targets": [3]},
                            {className: "text-right", "targets": [4]},
                            {className: "text-right", "targets": [5]},
                            {className: "text-right", "targets": [6]},
                            {className: "text-right", "targets": [7]},
                        ],
                        data: js,
                        columns: [

                            {data: 'CenterNo'},
                            {data: 'CenterName'},
                            {data: 'collection'},
                            {data: 'notpaid'},
                            {data: 'memberFee'},
                            {data: 'upcount'},
                            {data: 'nptotal'},
                            {data: 'collpre'},
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
                                    .column(2)
                                    .data()
                                    .reduce(function (a, b) {
                                        return intVal(a) + intVal(b);
                                    }, 0);

                            // Total over this page
                            pageTotal = api
                                    .column(2, {page: 'current'})
                                    .data()
                                    .reduce(function (a, b) {
                                        return intVal(a) + intVal(b);
                                    }, 0);

                            // Update footer
                            $(api.column(2).footer()).html(
                                    'Rs ' + pageTotal + ' ( Rs ' + total + ' total)'
                                    );
                        }

                    });


                }

            });
        } else {


            swal("Oops", "Select Executive and date!", "error")


        }




    });

//------------------------Combobox Function-------------------------------------



</script>



<jsp:include page="/footer.jsp"/>
