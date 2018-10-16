<%-- 
    Document   : SalaryReport
    Created on : Nov 26, 2017, 10:32:39 PM
    Author     : iamarshrx
--%>

<%@page import="Singleton.dateFormat"%>
<%@page import="Singleton.PageTitleSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }

    PageTitleSet.getTitle().setPAGE_TITLE("Salary Report");%>
<jsp:include page="/header.jsp"/>


<style> 

    input{
        text-align: right;
        
    }
    #NetSalary {
        text-align: left;
        
    }
    #year {
        text-align: left;
        
    }

</style>



<!--<div style="height: 10px;"></div>-->
<div class="card">
    <div class="card-block">


        <div class="container">
            <div class="row">
                <div class="col-md-4">

                    <div class="form-group">
                        <label for="exampleSelect1">Select Month</label>
                        <select class="form-control" id="montselect">
                            <option value="00">Select Month</option>
                            <option value="01">January</option>
                            <option value="02">February</option>
                            <option value="03">March</option>
                            <option value="04">April</option>
                            <option value="05">May</option>
                            <option value="06">June</option>
                            <option value="07">July</option>
                            <option value="08">Augest</option>
                            <option value="09">September</option>
                            <option value="10">October</option>
                            <option value="11">November</option>
                            <option value="12">December</option>



                        </select>
                        <p style="color: red;" id="err">Please Select month</p>
                    </div>




                </div>
                <div class="col-md-4">

                    <div class="form-group">
                        <label for="formGroupExampleInput">Enter Year</label>
                        <input type="number" class="form-control" id="year" placeholder="Example input" value="<%=dateFormat.YearOnly()%>">
                    </div>
                    <div class="text-right">  <input type="submit" name="" id="Search" value="Search" class="btn btn-primary">   </div>

                </div>
                <div class="col-md-4">

                </div>
            </div>
        </div>
        <div class="col-md-4"></div>
        <div class="col-md-4"></div>
        <div class="col-md-4">




        </div>  


        <div class=" table-responsive ">          
            <table class="table table-stripped" id="tblsal">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Full Name</th>
                        <th>NIC</th>


                        <th>Date</th>
                        <th>Basic Salary</th>
                        <th>Allowance</th>
                        <th>Deduction</th>


                        <th>Etf</th>
                        <th>Epf</th>
                        <th>NetSalary</th>

                        <th>Status</th>
                        <th>Options</th>


                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>





        </div>
    </div>
</div>




<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="mymodel">
    <div class="modal-dialog modal-lg">
        <div class="modal-content ">


            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">View salary</h5>
              
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <div class="row">

                        <div class="col-md-6">


                            <table>

                                <tr>

                                    <td> <label for="formGroupExampleInput">Basic Salary</label></td>
                                    <td> 

                                        <div class="form-group">

                                            <input type="text" class="form-control" id="basic" placeholder="Example input">
                                        </div>


                                    </td>



                                </tr>
                                <tr>

                                    <td> <label for="formGroupExampleInput">Total Allowance</label></td>
                                    <td> 

                                        <div class="form-group">

                                            <input type="text" class="form-control" id="Tallowance" placeholder="Example input">
                                        </div>


                                    </td>



                                </tr>
                                <tr>

                                    <td> <label for="formGroupExampleInput">Total Credit</label></td>
                                    <td> 

                                        <div class="form-group">

                                            <input type="text " class="form-control" id="CTotal" placeholder="Example input" style="color: green;">
                                        </div>


                                    </td>



                                </tr>



                            </table>









                        </div>
                        <div class="col-md-6">



                            <table>

                                <tr>

                                    <td> <label for="formGroupExampleInput">Total Deduction </label></td>
                                    <td> 

                                        <div class="form-group">

                                            <input type="text" class="form-control" id="Tdeduction" placeholder="Example input">
                                        </div>


                                    </td>



                                </tr>
                                <tr>

                                    <td> <label for="formGroupExampleInput">Etf</label></td>
                                    <td> 

                                        <div class="form-group">

                                            <input type="text" class="form-control" id="Etf" placeholder="Example input">
                                        </div>


                                    </td>



                                </tr>
                                <tr>

                                    <td> <label for="formGroupExampleInput">Epf </label></td>
                                    <td> 

                                        <div class="form-group">

                                            <input type="text " class="form-control" id="Epf" placeholder="Example input">
                                        </div>


                                    </td>



                                </tr>
                                <tr>

                                    <td> <label for="formGroupExampleInput">Total Debit </label></td>
                                    <td> 

                                        <div class="form-group">

                                            <input type="text " class="form-control" id="TDebit" placeholder="Example input" style="color: red;">
                                        </div>


                                    </td>



                                </tr>



                            </table>





                        </div>

                        <div class="container">
                            <div class="row">
                                <div class="col-md-2"></div>
                                <div class="col-md-6">

                                    <div class="form-group row">
                                        <label for="example-text-input" class="col-4 col-form-label">Net Salary </label>
                                        <div class="col-8">
                                            <input class="form-control" type="text" value="" id="NetSalary" style="color: green;">
                                        </div>
                                    </div>

                                </div>
                                <div class="col-md-2"></div>
                            </div>
                        </div>



                        <div class="container">
                            <div class="row">
                                <div class="col-md-6">
                                    <p class="text-center">Allowances</p>
                                    <table id="altable12">


                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Name</th>
                                                <th>Date</th>
                                                <th>Amount</th>
                                            </tr>
                                        </thead>
                                        <tbody>




                                        </tbody>

                                    </table>



                                </div>
                                <div class="col-md-6">

                                    <p class="text-center">Deductions</p>
                                    <table id="de12">


                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Name</th>
                                                <th>Date</th>
                                                <th>Amount</th>
                                            </tr>
                                        </thead>
                                        <tbody>




                                        </tbody>

                                    </table>   









                                </div>
                            </div>
                        </div>


                    </div>
                </div>  
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

            </div>





        </div>
    </div>
</div>        










<script>


    $(document).ready(function () {
//        $('#tableCenters').DataTable();
        $('#tblsal').DataTable({
            dom: 'Bfrtip',
            buttons: [
                'copy', 'excel', 'pdf', 'print', 'colvis'
            ]
        });
        table = $('#tblsal').DataTable();
        table.buttons().container()
                .appendTo('#example_wrapper .col-md-6:eq(0)');


        $('#err').hide();


    });





    $("#Search").click(function () {

        var month = $('#montselect').val();
        var year = $('#year').val();


        if (month != 00) {

            $('#err').hide();

            if (year.length <= 4 && year.length != 0) {



                $.ajax({
                    type: 'POST',
                    url: '../StaffSalaryReportServlet',
                    data: {month: month, year: year},
                    success: function (responseText) {


                        var json = JSON.parse(responseText);

                        if ($.fn.dataTable.isDataTable('#tblsal')) {
                            table = $('#tblsal').DataTable();
                            table.destroy();
                        }


                        $("#tblsal").DataTable({
                            data: json,
                            columns: [
                                {data: 'no'},
                                {data: 'name'},
                                {data: 'nic'},
                                {data: 'date'},
                                {data: 'Basic'},
                                {data: 'allowance'},
                                {data: 'deduction'},
                                {data: 'etf'},
                                {data: 'epf'},
                                {data: 'netsalary'},
                                {data: 'status'},
                                {data: 'edit'}

                            ]



                        });



                    }

                });










            }





        } else {
            $('#err').show();
        }




    });




    $(document).ready(function () {
        $('button').click(function () {
            



        });
    });




function reply_click(clicked_id)
{
 //  alert(clicked_id);
   //var stfid = $(".vat").attr("stfid");
var arr=clicked_id.split("-");

var salid=arr[0];
var stfid=arr[1];

          //  var at = $(".vat").attr("myat");

            var month = $('#montselect').val();
            var year = $('#year').val();




            $.ajax({
                type: 'POST',
                url: '../StaffSalaryreportoneLoad',
                data: {id: salid},
                success: function (responseText) {

                    var arr = JSON.parse(responseText);
                    for (var i = 0; i < arr.length; i++) {


                        var basic = arr[i].Basic;
                        var Totalsalary = arr[i].Totalsalary;
                        var allowance = arr[i].allowance;
                        var deduction = arr[i].deduction;
                        var payment = arr[i].payment;
                        var etf = arr[i].etf;
                        var epf = arr[i].epf;
                        var netsalary = arr[i].netsalary;

                    }



                    $("#basic").val(basic);
                    $("#Tallowance").val(allowance);
                    $("#CTotal").val(Totalsalary);
                    $("#Tdeduction").val(deduction);
                    $("#Etf").val(etf);
                    $("#Epf").val(epf);
                    $("#Epf").val(epf);
                    $("#NetSalary").val(netsalary);
                    $("#TDebit").val(payment);
                }


            });



//----------------------------------------------- 

            $.ajax({
                type: 'POST',
                url: '../LoadAllowancereport',
                data: {month: month, year: year, id: stfid},
                success: function (responseText) {




                    var json = JSON.parse(responseText);

                    if ($.fn.dataTable.isDataTable('#altable12')) {
                        table = $('#altable12').DataTable();
                        table.destroy();
                    }


                    $("#altable12").DataTable({
                        "bPaginate": false,
                        "bFilter": false,
                        "bInfo": false,
                        data: json,
                        columns: [
                            {data: 'no'},
                            {data: 'name'},
                            {data: 'date'},
                            {data: 'amount'},
                        ]



                    });





                }

            });
            $.ajax({
                type: 'POST',
                url: '../LoadAllDeductionreport',
                data: {month: month, year: year, id: stfid},
                success: function (responseText) {




                    var json = JSON.parse(responseText);

                    if ($.fn.dataTable.isDataTable('#de12')) {
                        table = $('#de12').DataTable();
                        table.destroy();
                    }


                    $("#de12").DataTable({
                        "bPaginate": false,
                        "bFilter": false,
                        "bInfo": false,
                        data: json,
                        columns: [
                            {data: 'no'},
                            {data: 'name'},
                            {data: 'date'},
                            {data: 'amount'},
                        ]



                    });





                }

            });

   
   $('#mymodel').modal('show');
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
}








</script>



<jsp:include page="/footer.jsp"/>