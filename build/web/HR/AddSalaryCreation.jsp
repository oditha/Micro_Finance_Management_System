<%-- 
    Document   : SalaryCreation
    Created on : Nov 22, 2017, 8:23:41 PM
    Author     : iamarshrx
--%>

<%@page import="Srcs.PoolManager"%>

<%@page import="ORM.Deductions"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="ORM.Allowance"%>
<%@page import="org.hibernate.Criteria"%>

<%@page import="org.hibernate.Session"%>
<%@page import="Singleton.PageTitleSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }

    PageTitleSet.getTitle().setPAGE_TITLE("Salary Management");%>
<jsp:include page="/header.jsp"/>
<jsp:include page="/Modals.jsp"/>

<style>

    #tb td, #tb th {

        padding: .75rem;
        vertical-align: top;
        border-top: none !important;

    }
    #td th,#td td{

        text-align: center;

    }
    .table td, .table th {
        padding: .75rem;
        vertical-align: top;
        border-top: none;
    }

</style>


<!--<div style="height: 10px;"></div>-->

<%

    if (request.getParameter("save") != null && request.getParameter("save").equals("success")) {

%>

<div class="alert alert-success" role="alert">
    You successfully Saved Allowance Type
</div>

<%    }


%>



<%    if (request.getParameter("delete") != null && request.getParameter("delete").equals("success")) {

%>

<div class="alert alert-success" role="alert">
    You successfully Deleted Allowance Type
</div>

<%    }


%>
<%    if (request.getParameter("dsave") != null && request.getParameter("dsave").equals("success")) {

%>

<div class="alert alert-success" role="alert">
    You successfully Added Deduction Type
</div>

<%    }


%>
<div class="alert alert-success" role="alert" id="alalert">
    <strong>Well done!</strong> You successfully added a allowance
</div>
<div class="alert alert-success" role="alert" id="dalert">
    <strong>Well done!</strong> You successfully added a Deduction
</div>

<div class="container">
    <div class="row">
        <div class="col-md-4">


            <div class="card">
                <div class="card-header">
                    Search by Nic
                </div>
                <div class="card-block text-left">




                    <div class="form-group text-right">
                        <label for="formGroupExampleInput"></label>
                        <input type="text" class="form-control   nic"  placeholder="Enter Nic" id="nic">
                        <p id="nicex" style="color: red;">Nic Doesnt Exists</p>
                        <p id="enic" style="color: red">Enter Nic</p>

                        <div style="height: 10px;" id=""></div>
                        <div style="height: 10px;" id="livesearch"></div>
                        <input type="submit" value="Get" class="btn btn-primary get " id="Get">
                    </div>




                </div>
            </div>


        </div>
        <!--        <div class="col-md-6 text-center">  <h3 id="getnm"></h3> </div>-->
    </div>
</div>-


<div class="card">
    <div class="card-header text-right" role="tab" id="headingTwo">

        <a class="collapsed btn-primary btn-sm btn" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
            +Add Allowance
        </a>

    </div>
    <div id="collapseTwo" class="collapse" role="tabpanel" aria-labelledby="headingTwo">
        <div class="card-block">

            <div class="container">
                <form  id="formal">
                    <div class="row">


                        <div class="col-md-6">
                            <div class="form-group">



                                <input type="text" name="staffid" id="staffid" class="id" hidden >
                                <label for="exampleSelect1">Allowance Type</label>
                                <select class="form-control" id="type" name="allowanceType" required>
                                    <option value="select">Select</option>                  
                                    <%                                        Session sess1 = PoolManager.getSessionFactory().openSession();

                                        Criteria cr1 = sess1.createCriteria(Allowance.class);

                                        cr1.add(Restrictions.eq("isdelete", "Active"));

                                        List<Allowance> l1 = cr1.list();

                                        for (Allowance all1 : l1) {%>
                                    <option value="<%= all1.getIdAllowance()%>"><%= all1.getAllowancName()%></option>


                                    <%
                                        }
                                        sess1.close();


                                    %>
                                </select>
                                <p id="stype" style="color: red">Select allowance type</p>
                            </div> 

                            <div class="form-group text-right">


                                <a  class="btn btn-success btn-sm" data-toggle="modal" data-target="#myModal" href="#">+Add Allowance type</a>








                            </div>

                        </div>
                        <div class="col-md-6">




                            <div class="form-group">
                                <label for="exampleTextarea"> Amount </label>
                                <input class="form-control" type="text" value="" id="Aamount" name="aamount" required>
                                <p id="eamount" style="color: red">Enter Amount</p>
                            </div>

                            <div class="form-group text-right">

                                <input type="reset" value="Reset" name="reset" class="btn btn-danger">
                                <!-- <input type="submit" value="Submit" name="Save" class="btn btn-primary" id="saval">-->
                                <a   class="btn btn-primary" id="saval">Save</a>

                            </div>

                        </div>

                    </div>
                </form> 
            </div>
        </div>
    </div>
</div>

<div style="height: 10px;"></div>
<div class="card">
    <div class="card-header text-right" role="tab" id="headingTwo">

        <a class="collapsed btn-primary btn-sm btn" data-toggle="collapse" data-parent="#accordion" href="#deduction" aria-expanded="false" aria-controls="collapseTwo">
            +Add Deductions
        </a>

    </div>
    <div id="deduction" class="collapse" role="tabpanel" aria-labelledby="headingTwo">
        <div class="card-block">
            <form id="dform" >
                <div class="container">

                    <div class="row">

                        <div class="col-md-6">
                            <div class="form-group">
                                <input type="text" name="staffid" id="" class="id" hidden="">

                                <div class="form-group">
                                    <label for="exampleSelect1">Deduction Type</label>

                                    <select class="form-control" id="exampleFormControlSelect1" id="dtype" name="tdtype">
                                        <option value="">Select</option>
                                        <%                                            Criteria cr13 = PoolManager.getSessionFactory().openSession().createCriteria(Deductions.class);

                                            cr13.add(Restrictions.eq("isDelete", "Active"));
                                            List<Deductions> l13 = cr13.list();

                                            for (Deductions d1 : l13) {

                                        %>
                                        <option value="<%=d1.getIdDeductions()%>"><%=d1.getDeductionType()%></option>
                                        <%

                                            }
                                            PoolManager.getSessionFactory().openSession().close();
                                        %>   

                                    </select>




                                    <div class="text-right"> <a  class="btn btn-success btn-sm " data-toggle="modal" data-target="#myModal2" href="#">+Add Deduction type</a></div>

                                </div> 



                            </div>
                        </div>
                        <div class="col-md-6">




                            <div class="form-group">
                                <label for="exampleTextarea"> Amount </label>
                                <input class="form-control" type="text" value="" id="tDamount" name="tDamount">
                            </div>

                            <div class="form-group text-right">

                                <input type="submit" value="Reset" name="reset" class="btn btn-danger">
                                <a    id="dsave" name="Save" class="btn btn-primary">Save</a>





                            </div>

                        </div>
                    </div>
                </div>

            </form>




            <div class=" table-responsive ">          




                <div style="height: 30px;"></div>











            </div>
        </div>
    </div>
</div>

<div style="height: 10px;"></div>

<form  method="Post" id="createsalary">


    <div class="table-responsive">   
        <table class="table" id="Maintable">
            <thead>
                <tr class="info" style="background-color: dff0d8;">

                    <th class="abc active">Credits</th>
                    <th class="abc active">Debits</th>

                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>




                        <table class="table" id="tb">
                            <thead>

                            </thead>
                            <tbody>
                                <tr>
                                    <td>Basic Salary</td>
                                    <td><input type="text" name="bsalary" id="bsalary" readonly class="form-control"></td>
                            <input type="text" name="staffid" id="staffid" class="id" hidden >
                            </tr>
                            <tr>
                                <td>Total Allowance</td>
                                <td><input type="text" name="tallowance" id="tallowance" readonly class="tallowance form-control"></td>

                            </tr>
                            <tr>
                                <td>Sub total</td>
                                <td><input type="text" name="csubtotal" id="csubtotal" readonly class="form-control"></td>

                            </tr>
                            <tr>
                            <tr>
                                <td><div></div></td>
                                <td><div></div></td>

                            </tr>
                            <tr>
                                <td>Net Total</td>
                                <td><input type="text" name="nettotal" id="nettotal" readonly class="form-control"></td>

                            </tr>
                            <tr>
                                <td><div></div></td>
                                <td ><a id="calculate"  class="btn btn-primary "  >Calculate</a><span>   </span><!-- <input type="submit" value="Pay" class="btn btn-primary pay " onclick="save();">--> <a class="btn btn-primary pay " onclick="save();">Pay</a></td>
                                <td></td>

                            </tr>


            </tbody>
        </table>

        <div class="table-responsive">          
            <table class="table" id="altable">
                <thead>
                <p>Current Month Allowances</p>
                <tr>

                    <th>#</th>
                    <th>Date</th>
                    <th>Type</th>
                    <th>Amount</th>

                </tr>
                </thead>
                <tbody>
                    <tr>


                    </tr>

                </tbody>
            </table>
        </div>
        </td>
        <td>



            <table class="table" id="tb">
                <thead>

                </thead>
                <tbody >
                    <tr>
                        <td>Total Deductions</td>
                        <td><input type="text" name="tdeductions" id="tdeductions" readonly class="form-control"></td>

                    </tr>
                    <tr>
                        <td>Etf</td>
                        <td><input type="text" name="etf" id="etf" class="form-control"></td>

                    </tr>
                    <tr>
                        <td>Epf</td>
                        <td><input type="text" name="epf" id="epf" class="form-control"></td>

                    </tr>
                    <tr>
                        <td>Sub Total</td>
                        <td><input type="text" name="dsub" id="dsubtotal" readonly class="form-control"></td>

                    </tr>

                </tbody>
            </table>

            <div style="height: 123px;"></div>
            <div class="table-responsive">          
                <table class="table" id="dtable">
                    <thead>
                    <b>Current Month Deductions</b>
                    <tr>
                        <th>#</th>
                        <th>Date</th>
                        <th>Type</th>
                        <th>Amount</th>

                    </tr>
                    </thead>
                    <tbody id="dtbody">

                    </tbody>
                </table>
            </div>



        </td>


        </tr>
        </tbody>
        </table>
    </div>
</form>

<!----------------------------------------------------------------------------------------->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Add Allowance type</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="../SaveAllowanceTypeServlet" method="Post">

                    <div class="form-group text-left">
                        <label for="exampleTextarea"> Allowance type </label>
                        <input class="form-control" type="text" value="" id="example-number-input" placeholder="Enter Allowance type" name="type"><br>
                        <div class="text-right"><input type="submit" value="Save changes" class="btn btn-primary btn-sm"></div> 
                    </div>   


                    <style>



                    </style>                                                   
                    <table class="table" id="td">
                        <thead>
                            <tr >
                                <th>#</th>
                                <th>Name</th>

                            </tr>
                        </thead>
                        <tbody id="altbody">
                            <%                                                            
                                
                                Session sess = PoolManager.getSessionFactory().openSession();

                                Criteria cr = sess.createCriteria(Allowance.class);

                                cr.add(Restrictions.eq("isdelete", "Active"));

                                List<Allowance> l = cr.list();

                                for (Allowance all : l) {


                            %>

                            <tr >
                                <td><%= all.getIdAllowance()%></td>
                                <td><%= all.getAllowancName()%></td>
                                <td><a href="../DeleteAllowancetypeServlet?id=<%= all.getIdAllowance()%>" class="btn btn-danger">Delete</a></td>

                            </tr>



                            <%

                                }

                                sess.close();
                            %>



                        </tbody>
                    </table>






                </form>

                <div class="container">

                </div>









            </div>
            <div class="modal-footer">

            </div>
        </div>
    </div>
</div>
<!----------------------------------------------------------------------------------------->
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Add Deduction type</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="../SaveDeductiontypeServlet" method="Post">

                    <div class="form-group text-left">
                        <label for="exampleTextarea"> Deduction type </label>
                        <input class="form-control" type="text" value="" id="example-number-input" placeholder="Enter Allowance type" name="type"><br>
                        <div class="text-right"><input type="submit" value="Save changes" class="btn btn-primary btn-sm"></div> 
                    </div>   


                    <style>



                    </style>                                                   
                    <table class="table" id="td">
                        <thead>

                            <tr >
                                <th>#</th>
                                <th>Name</th>
                                <th>Action</th>

                            </tr>
                        </thead>
                        <tbody>

                            <%   
                                
                               Session sess11= PoolManager.getSessionFactory().openSession();
                                
                                
                                Criteria cr12 = sess11.createCriteria(Deductions.class);

                                cr12.add(Restrictions.eq("isDelete", "Active"));
                                List<Deductions> l12 = cr12.list();

                                for (Deductions d1 : l12) {


                            %>
                            <tr >
                                <td> <%=d1.getIdDeductions()%></td>
                                <td><%=d1.getDeductionType()%></td>
                                <td><a  class="btn btn-danger" href="../DeleteDeductiontypeServlet?id=<%=d1.getIdDeductions()%>">Delete</a></td>

                            </tr>


                            <%

                                }
sess11.close();
                            %>




                        </tbody>
                    </table>






                </form>

                <div class="container">

                </div>









            </div>
            <div class="modal-footer">

            </div>
        </div>
    </div>
</div>

<!---------------------------Check current month slary--------------------------------------->
<!-- Check current month slary-->
<div class="modal fade" id="salarycheck">
    <div class="modal-dialog ">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">already exists</h4>

            </div>

            <!-- Modal body -->
            <div class="modal-body">
                You have Already paid for <div id="paidnic"></div>current month
                for more details Go to <a href="/CMC/HR/ViewSalaryReport.jsp">Salary Report</a>

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>                        




<script>
    var basic;
    var total;
    ////////////////--------------------------------------------------------------------------





    $("#Aamount").keypress(function (e) {
        var charCode = (e.which) ? e.which : e.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
    });
    $("#Damount").keypress(function (e) {
        var charCode = (e.which) ? e.which : e.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
    });
//----------------------------------------------------------------------------------------    

    $('#nicex').hide();

    $('.get').on('click', function () {
        validatesalary();
        //creditsubtotal();
        var nic = $('.nic').val();
        LoadAllDeductions();
        Loadallowance();

        //  alert(nic);
        Loadbasicsalary();
        // $(".hid").attr('value', m);


        $.ajax({
            url: '../CheckNicsalaryAjaxSevlet',
            data: {ID: nic},
            success: function (responseText) {

                var no = 'no';


                if (responseText === no) {


                    $('#searchError').modal('show');


                } else {

                    $('#nicex').hide();



                }






            }


        });

///-----------------------------------------------------------------------------------------------------------------------------------------------

        $.ajax({
            url: '../GetIdSalaryAjaxServlet',
            data: {ID: nic},
            success: function (responseText) {

                var ja = JSON.parse(responseText);


                for (var i = 0; i < ja.length; i++) {
                    var id = ja[i].id;
                    var name = ja[i].name;
                    var epf = ja[i].epf;
                    var etf = ja[i].etf;
                }


                $(".id").attr('value', id);
                $("#getnm").append(name);

                $('#collapseTwo').collapse('show');


            }


        });




    });

//------------------------------------------------------------------------------------------------------------------------------------


    $('#alalert').hide();
    $("#saval").click(function () {


        var amount = $('#Aamount').val();
        var staffid = $('.id').val();
        var type = $('#tdtype').val();



        if (staffid.length > 0) {

            if (amount.length > 0) {






                var data = $('#formal').serialize();


                $.ajax({
                    type: 'POST',
                    url: '../AddAllowance2',
                    data: data,
                    success: function (responseText) {


                        if (responseText === 'success') {


                            //  $('#alalert').show();

                            //document.getElementById("formal").reset(); 
                            $('#Aamount').val("");
                            $('#type').val("select");
                            Loadallowance();
                            $('#SaveDone').modal('show');

                            $("#calculate").trigger("click");


                        }



                    }


                });


            } else {

                //   alert("Enter Amount");
                $('#eamount').show();

            }
        } else {

            $('#enic').show();


        }









    });



    $('#eamount').hide();
    $('#stype').hide();
    $('#enic').hide();
    ///-------------------------------------------------------------------------------------------------------------------------------------------------------
    //$('#alalert').hide();
    $("#dsave").click(function () {

        var data = $('#dform').serialize();
        var amount = $('#tDamount').val();
        var staffid = $('.id').val();
        var type = $('#dtype').val();


        if (staffid.length > 0) {

            if (amount.length > 0) {









                $.ajax({
                    type: 'POST',
                    url: '../AddDeductionAjaxServlet',
                    data: data,
                    success: function (responseText) {


                        if (responseText === 'success') {


                            $('#dalert').show();

                            //document.getElementById("formal").reset(); 
                            $('#tDamount').val("");
                            $('#dtype').val("Select");
                            LoadAllDeductions();
                            $('#SaveDone').modal('show');

                            $("#calculate").trigger("click");

                        } else {

                            $('#dalert').hide();
                        }



                    }


                });


            } else {

//                alert("Enter Amount");
//                $('#eamount').show();

            }
        } else {

//            $('#enic').show();


        }






    });



    $('#eamount').hide();
    $('#stype').hide();
    $('#enic').hide();

    ///-------------------------------------------------------------------------------------------------------------------------------------------------------



    $('#dalert').hide();





//------------------------------------------------final calculations-------------------------------------------------------------------------------------------------


    function    Loadallowance() {

        var nic = $('.nic').val();
        $.ajax({
            url: '../LoadAllallowanceAjaxServlet',
            data: {ID: nic},
            success: function (responseText) {

                var arr = JSON.parse(responseText);
                var tamount = 0;
                var table = document.getElementById('altable');


                for (var i = 0; i < arr.length; i++) {




                    tamount += parseInt(arr[i].amount);


                }


                if ($.fn.dataTable.isDataTable('#altable')) {
                    table = $('#altable').DataTable();
                    table.destroy();
                }


                $("#altable").DataTable({
                    "bPaginate": false,
                    "bFilter": false,
                    "bInfo": false,
                    data: arr,
                    columns: [
                        {data: 'id'},
                        {data: 'date'},
                        {data: 'type'},
                        {data: 'amount'}


                    ]



                });



                total = tamount;
                $('#tallowance').val(tamount);

            }

        });

        $('.alname').val(type);

    }



    $(document).ready(function () {

    });
/////////////////-------------------------------------------------------------------------------------------------


    function    LoadAllDeductions() {

        var nic = $('.nic').val();
        $.ajax({
            url: '../LoadAllDeductions',
            data: {ID: nic},
            success: function (responseText) {

                var arr = JSON.parse(responseText);
                var tamount = 0;
                var table = document.getElementById('dtable');
                // document.getElementById("dtbody").deleteRow(arr.length);

                for (var i = 0; i < arr.length; i++) {


                    tamount += parseInt(arr[i].amount);

                }
                if ($.fn.dataTable.isDataTable('#dtable')) {
                    table = $('#dtable').DataTable();
                    table.destroy();
                }


                $("#dtable").DataTable({
                    "bPaginate": false,
                    "bFilter": false,
                    "bInfo": false,
                    data: arr,
                    columns: [
                        {data: 'id'},
                        {data: 'date'},
                        {data: 'type'},
                        {data: 'amount'}


                    ]



                });


                $('#tdeductions').val(tamount);
                //  alert(tamount);

            }

        });

        $('.alname').val(type);

    }



///////////////////////--------------------------------------------------------------------


//    $(document).ready(function () {
////        $('#tableCenters').DataTable();
//        $('#Maintable').DataTable({
//            dom: 'Bfrtip',
//            buttons: [
//                'copy', 'excel', 'pdf', 'print', 'colvis'
//            ]
//        });
//
//        table.buttons().container()
//                .appendTo('#example_wrapper .col-md-6:eq(0)');
//
//    });

/////////////////////////////-------------------------------------------------------------------------------------------------------------------------------



    function    Loadbasicsalary() {

        var nic = $('.nic').val();
        $.ajax({
            url: '../LoadBasicSalary',
            data: {ID: nic},
            success: function (responseText) {




                $('#bsalary').val(responseText);

                basic = parseInt(responseText);
                var etf = (basic / 100) * 8;
                var epf = (basic / 100) * 12;
                /// $('#etf').val();
                $('#etf').val(etf);
                $('#epf').val(epf);



            }

        });

        //$('.alname').val(type);

    }

    function creditsubtotal() {


        var nic = $('.nic').val();

        if (nic.length > 0) {
            var sal = $('#bsalary').val();
            var tallowance = $("#tallowance").val();


            var sub = parseInt(sal) + parseInt(tallowance);

            $('#csubtotal').val(sub);

        }










    }



    function calculatedeductions() {



        var nic = $('.nic').val();
        if (nic.length) {


            var etf = $('#etf').val();
            var epf = $('#epf').val();


            if (etf.length > 0) {
                etf = $('#etf').val();

            } else {
                etf = 0.0;
            }
            $('#etf').val(etf);


            if (epf.length > 0) {
                epf = $('#epf').val();
            } else {
                epf = 0.0;
            }
            $('#epf').val(epf);

        }

        var tdduction = $('#tdeductions').val();


        var sub = parseInt(etf) + parseInt(epf) + parseInt(tdduction);

        $('#dsubtotal').val(sub);

        var csubtotal = $('#csubtotal').val();
        var nettotal = parseInt(csubtotal) - parseInt(sub);

        $('#nettotal').val(nettotal);








    }

    $("#calculate").click(function () {


        creditsubtotal();

        Loadbasicsalary();


        LoadAllDeductions();
        Loadallowance();


        calculatedeductions();



    });

//////////////////////////////////////////////////----------------------------------------------------------------------------------------


    function  save() {
        var data = $('#createsalary').serialize();
        $.ajax({
            type: 'POST',
            url: '../CreateSalaryServlet',
            data: data,
            success: function (responseText) {


//                        if (responseText === 'success') {
//
//
//                            //  $('#alalert').show();
//
//                            //document.getElementById("formal").reset(); 
//                            $('#Aamount').val("");
//                            $('#type').val("select");
//                            Loadallowance();
//                            $('#SaveDone').modal('show');
//
//                            $("#calculate").trigger("click");
//
//
//                        }

                $('#createsalary').trigger("reset");



                var table = $('#altable').DataTable();
                table
                        .clear()
                        .draw();
                var table2 = $('#dtable').DataTable();
                table2
                        .clear()
                        .draw();


                $('.nic').val("");
                $('#SaveDone').modal('show');







            }


        });






    }




    function validatesalary() {
        var nic = $('.nic').val();
        $.ajax({
            url: '../ValidateSalaryPaid',
            data: {ID: nic},
            success: function (responseText) {



                if (responseText === 'yes') {

                    $('#createsalary').trigger("reset");



                    var table = $('#altable').DataTable();
                    table
                            .clear()
                            .draw();
                    var table2 = $('#dtable').DataTable();
                    table2
                            .clear()
                            .draw();


                    $("#paidnic").append("<p>" + nic + "</p>");
                    $('.nic').val("");
                    $('#salarycheck').modal('show');



                }







            }


        });





    }



</script>


<table>







</table>








<jsp:include page="/footer.jsp"/>