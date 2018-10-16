<%-- 
    Document   : regStaff
    Created on : Nov 21, 2017, 10:42:11 PM
    Author     : iamarshrx
--%>
<%@page import="ORM.Staff"%>
<%@page import="Srcs.PoolManager"%>
<%@page import="ORM.Center"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="ORM.Branch"%>
<%@page import="org.hibernate.Criteria"%>

<%@page import="org.hibernate.Session"%>
<%@page import="Singleton.PageTitleSet"%>
<%
    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }
    PageTitleSet.getTitle().setPAGE_TITLE("Loan Disbursement");

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
    #date{
        height: 39px;
        width: 318px;
        border-radius: 5px;
        border-style: ridge;

    }
    .table td, .table th {
        padding: 0;
        vertical-align: top;
        border-top: 1px solid rgba(0,0,0,.06);
    }
</style>
<script>
    $('#collapseOne').collapse("hide");</script>

<!--<div class="card">-->

<!--<div class="card-block">-->
<div class="container">
    <div class="row">	


        <div class="col-md-4" hidden="">
            <div class="form-group">
                <div class="form-group">
                    <label for="formGroupExampleInput">Select Center</label>
                    <select class="form-control" id="center" name="center">
                        <option>Select</option>
                        <%                                    Session se = PoolManager.getSessionFactory().openSession();
                            Criteria c = se.createCriteria(Center.class);
                            c.add(Restrictions.eq("isActive", "Active"));
                            c.add(Restrictions.eq("isApprove", "Approve"));

                            List<Center> l = c.list();

                            for (Center elem : l) {%>


                        <option value="<%= elem.getIdCenter()%>"><%= elem.getCenterNo() + " - " + elem.getCenterName()%></option>


                        <%    }

                        %>

                    </select>
                </div>
            </div>
        </div>






        <div class="col-md-4">

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
        <div class="col-md-4">
            <div class="form-group">

                <label for="exampleSelect1">Filter By Date</label>
                <!--<div style="height: 6px"></div>-->
                <input type="date" class="form-control" id="days">
                <div class="containerfluid text-right" style="padding-top: 10px;"><input type="submit" id="Filer" value="Filter" name="Search" class="btn btn-primary text-right btn-sm" required=""></div>


            </div>
        </div>

        <div class="col-md-4">
            <div class="form-group">
                <label for="formGroupExampleInput">Total</label>
                <input type="text" style="background-color: white" class="form-control" id="total" placeholder="Total" name="contractNo" readonly="">

            </div>
        </div>
    </div>

</div>
<!--</div>-->

<hr>

<div class=" table-responsive ">          
    <table class="table table-bordered" id="tableView">
        <thead>
            <tr>
                <th>#</th>
                <th>Member ID</th>
                <th>Member Name</th>
                <th>Member Nic</th>
                <th>Member Fee</th>
                <th>Loan Amount</th>

                <th>Loan Index</th>
                <th>Installment</th>
                <th>Signature</th>


            </tr>
        </thead>
        <tbody>

        </tbody>

        <tfoot>
            <tr>
                <td><div></div></td>
                <td><div></div></td>
                <td><div></div></td>
                <td><div></div></td>
                <td id="" style="color: red"><input type="text" disabled="" class="text-right" id="Memberfee" Style="text-align:left; color:green; width: 100px"></td>
                <td id="" style="color: red"><input type="text" disabled="" class="text-right" id="LoanAmount" Style="text-align:left; color:green; width: 100px"></td>
                <td id="" style="color: red"><input type="text" disabled="" class="text-right" id="Paidamount" Style="text-align:left; color:green; width: 100px"></td>
                <td id="" style="color: red"><input type="text" disabled="" class="text-right" id="Installment" Style="text-align:left; color:green; width: 100px"></td>

            </tr>
        </tfoot>
    </table>


</div>
<!--</div>-->


<script>

    $(document).ready(function () {

        $("#tableView").DataTable({
            dom: 'Bfrtip',
            "order": [[1, "asc"]],
            buttons: [
                'excel', 'pdf', 'print', 'colvis'
            ]
        });




    });


    $("#center").change(function () {

        var centerName = $("#center").find(":selected").text();

        if (centerName !== "Select") {

            $("#executive").attr("disabled", true);
            $("#executive").val("Select");

        } else {

            $("#executive").attr("disabled", false);


        }



    });







    $("#Filer").click(function () {

        var cenID = $("#center").find(":selected").val();
        var executive = $("#executive").find(":selected").text();
        var executiveid = $("#executive").find(":selected").val();
        var dates = $("#days").val();
        var Center = $('#center option:selected').text();



        if (executive === 'Select') {


            $.ajax({
                method: "POST",
                url: "../ViewDisbursment",
                data: {cenID: cenID, dates: dates},
                success: function (data) {

                    if (data !== "error") {

                        var total = data.split("$")[0];
                        $("#total").val(total);
                        var js = data.split("$")[1];
                        var json = JSON.parse(js);
                        if ($.fn.dataTable.isDataTable('#tableView')) {
                            table = $('#tableView').DataTable();
                            table.destroy();
                        }


                        $("#tableView").DataTable({
                            dom: 'Bfrtip',
                            "order": [[1, "asc"]],
                            buttons: [
                                'copy',
                                {
                                    extend: 'excel',
                                    messageTop: null
                                },
                                {
                                    extend: 'pdf',
                                    messageBottom: null
                                },
                                {
                                    extend: 'print',
                                    title: '<div class=' + 'text-center' + '><h4>Canto Micro Commercial Investment (Pvt) Ltd <br> Disbursement Sheet</h4>  </div>',
                                    messageTop: '<div class=' + 'text-center' + '>Center: ' + Center + '</div>'
                                    ,
                                    messageBottom: null
                                }
                            ],
                            data: json,
                            columns: [
                                {data: 'Count'},
                                {data: 'MemNO'},
                                {data: 'MemName'},
                                {data: 'Membernic'},
                                {data: 'Memberfee'},
                                {data: 'Loanamo'},
                                {data: 'paidAmo'},
                                {data: 'Installment'},
                                {data: 'sign'}
                            ]

                        });
                        var table = $('#tableView').DataTable();
                        var Memberfee = table.column(4).data().sum();
                        var LoanAmount = table.column(5).data().sum();
                        //  var LoanAmount = table.column(5).data().sum();
                        var Installment = table.column(67).data().sum();

                        $('#Memberfee').val(Memberfee);
                        $('#LoanAmount').val(LoanAmount);
                        $('#Installment').val(Installment);
                        //   $('#Memberfee').val(Memberfee);
                        var Paidamount = table.column(6).data().sum();
                        $('#Paidamount').val(Paidamount);


                    } else {

                        $("#wentWrong").modal();
                    }

                }

            });

        } else {

            // alert($("#executive").find(":selected").val());
            $.ajax({
                method: "POST",
                url: "../ViewDisbursmentExecutiveFilter",
                data: {dates: dates, stfid: $("#executive").find(":selected").val()},
                success: function (data) {

                    if (data !== "error") {

                        var total = data.split("$")[0];
                        $("#total").val(total);
                        var js = data.split("$")[1];
                        var json = JSON.parse(js);
                        if ($.fn.dataTable.isDataTable('#tableView')) {
                            table = $('#tableView').DataTable();
                            table.destroy();
                        }


                        $("#tableView").DataTable({
                            dom: 'Bfrtip',
                            "order": [[1, "asc"]],
                            buttons: [
                                'copy',
                                {
                                    extend: 'excel',
                                    messageTop: null
                                },
                                {
                                    extend: 'pdf',
                                    messageBottom: null
                                },
                                {
                                    extend: 'print',
                                    title: '<div class=' + 'text-center' + '><h4>Canto Micro Commercial Investment (Pvt) Ltd <br> Disbursement Sheet</h4>  </div>',
                                    messageTop: '<div class=' + 'text-center' + '>Center: ' + Center + '</div>'
                                    ,
                                    messageBottom: null
                                }
                            ],
                            data: json,
                            columns: [
                                {data: 'Count'},
                                {data: 'MemNO'},
                                {data: 'MemName'},
                                {data: 'Membernic'},
                                {data: 'Memberfee'},
                                {data: 'Loanamo'},
                                {data: 'paidAmo'},
                                {data: 'Installment'},
                                {data: 'sign'}
                            ]

                        });
                        var table = $('#tableView').DataTable();
                        var Memberfee = table.column(4).data().sum();
                        var LoanAmount = table.column(5).data().sum();
                        //  var LoanAmount = table.column(5).data().sum();
                        var Installment = table.column(7).data().sum();

                        $('#Memberfee').val(Memberfee);
                        $('#LoanAmount').val(LoanAmount);
                        $('#Installment').val(Installment);
                        var Paidamount = table.column(6).data().sum();
                        $('#Paidamount').val(Paidamount);
                    } else {

                        $("#wentWrong").modal();
                    }

                }

            });



        }

    });

</script>


<jsp:include page="/Modals.jsp"/>
<jsp:include page="/footer.jsp"/>
