
<%@page import="Singleton.PageTitleSet"%>
<%
    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }
    PageTitleSet.getTitle().setPAGE_TITLE("View Loan Accounts");

    try {
        if (!session.getAttribute("UserType").toString().equals("Manager")) {

            response.sendRedirect("/CMC/errorPage/401Unauthorized.html");

        }
    } catch (Exception e) {
    }


%>




<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/header.jsp"/>


<style>
    
   
    
    
</style>





<br>
<div class="container">
    <div class="row">
        <div class="col-md-4">

            <div class="form-group">
                <label for="exampleFormControlInput1">From Date</label>
                <input type="date" class="form-control" id="from" placeholder="">
            </div>



        </div>
        <div class="col-md-4">
            <div class="form-group">
                <label for="exampleFormControlInput1">From Date</label>
                <input type="date" class="form-control" id="to" placeholder="">
            </div>

        </div>
        <div class="col-md-4">
            <button class="btn btn-primary" id="filter">Filter</button>
        </div>
    </div>
</div>


<div class="container">


    <div id="accordion" role="tablist" aria-multiselectable="true">
        <div class="card">
            <div class="card-header text-right bg-danger" role="tab" id="headingOne">

                <a class="btn btn-primary btn-sm" data-toggle="collapse" data-parent="#accordion" href="#collapseOne1" aria-expanded="true" aria-controls="collapseOne" style="color: white">
                    +Loan Account
                </a>





            </div>

            <div id="collapseOne1" class="collapse " role="tabpanel" aria-labelledby="headingOne">
                <div class="card-block">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                
                                <table class="table table-responsive" id="tblloanaccount" style="width: 100%;">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Description</th>
                                <th>Debit</th>
                                <th>Credit</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>


                        <tfoot>
                            <tr>
                                <td><div></div></td>
                                <td><div></div></td>
                                <td  id="tdebitloanacc" style="color: green"></td>
                                <td id="tcreditloanacc" style="color: red"></td>
                            </tr>
                        </tfoot>
                    </table>
                                
                                
                                
                                
                            </div>
                        </div>
                    </div>     
                    
              



                </div>
            </div>



        </div>
    </div>  



</div>
<div class="container">


    <div id="accordion" role="tablist" aria-multiselectable="true">
        <div class="card">
            <div class="card-header text-right bg-secondary" role="tab" id="headingOne">

                <a class="btn btn-primary btn-sm" data-toggle="collapse" data-parent="#accordion" href="#collapseOne2" aria-expanded="true" aria-controls="collapseOne" style="color: white">
                    +Interest Account
                </a>





            </div>

            <div id="collapseOne2" class="collapse " role="tabpanel" aria-labelledby="headingOne">
                <div class="card-block">
                    <table class="table" id="interestacc" style="width: 100%;">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Description</th>
                                <th>Debit</th>
                                <th>Credit</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td><div></div></td>
                                <td><div></div></td>
                                <td  id="tdebitinterestacc" style="color: green"></td>
                                <td id="tcreditinterestacc" style="color: red"></td>
                            </tr>
                        </tfoot>
                    </table>



                </div>
            </div>
        </div>
    </div>  



</div>
<div class="container">


    <div id="accordion" role="tablist" aria-multiselectable="true">
        <div class="card">
            <div class="card-header text-right bg-dark" role="tab" id="headingOne">

                <a class="btn btn-primary btn-sm" data-toggle="collapse" data-parent="#accordion" href="#collapseOne3" aria-expanded="true" aria-controls="collapseOne" style="color: white">
                    +Other Income Accounts
                </a>





            </div>

            <div id="collapseOne3" class="collapse " role="tabpanel" aria-labelledby="headingOne">
                <div class="card-block">
                    <table class="table" id="tblother" style="width: 100%;">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Description</th>
                                <th>Debit</th>
                                <th>Credit</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>


                        <tfoot>
                            <tr>
                                <td><div></div></td>
                                <td><div></div></td>
                                <td  id="tdebitother" style="color: green"></td>
                                <td id="tcreditother" style="color: red"></td>
                            </tr>
                        </tfoot>

                    </table>



                </div>
            </div>
        </div>
    </div>  



</div>
<div class="container">


    <div id="accordion" role="tablist" aria-multiselectable="true">
        <div class="card">
            <div class="card-header text-right bg-success" role="tab" id="headingOne">

                <a class="btn btn-primary btn-sm" data-toggle="collapse" data-parent="#accordion" href="#collapseOne4" aria-expanded="true" aria-controls="collapseOne" style="color: white">
                    +Accrued Income Accounts
                </a>





            </div>

            <div id="collapseOne4" class="collapse " role="tabpanel" aria-labelledby="headingOne">
                <div class="card-block">
                    <table class="table" id="accured" style="width: 100%;">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Description</th>
                                <th>Debit</th>
                                <th>Credit</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>


                        <tfoot>
                            <tr>
                                <td><div></div></td>
                                <td><div></div></td>
                                <td  id="tdebitaccured" style="color: green"></td>
                                <td id="tcreditaccured" style="color: red"></td>
                            </tr>
                        </tfoot>

                    </table>



                </div>
            </div>
        </div>
    </div>  



</div>
<div class="container">


    <div id="accordion" role="tablist" aria-multiselectable="true">
        <div class="card">
            <div class="card-header text-right bg-primary" role="tab" id="headingOne">

                <a class="btn btn-primary btn-sm" data-toggle="collapse" data-parent="#accordion" href="#collapseOne5" aria-expanded="true" aria-controls="collapseOne" style="color: White;">
                    +Cash In Hand Accounts
                </a>





            </div>

            <div id="collapseOne5" class="collapse " role="tabpanel" aria-labelledby="headingOne">
                <div class="card-block">
                    <table class="table" id="tblCashInhand"  style="width: 100%;">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Description</th>
                                <th>Debit</th>
                                <th>Credit</th>
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
                                <td><div></div></td>
                                <td  id="Repaymenttl" style="color: green"></td>
                          
                            </tr>
                        </tfoot>
                        
                    </table>



                </div>
            </div>
        </div>
    </div>  



</div>



<script>
$(document).ready(function() {
   $('#tblloanaccount').DataTable();
 //  $('#tblloanaccount').DataTable();
 $('#interestacc').DataTable();
 $('#tblother').DataTable();
 $('#accured').DataTable();
 $('#tblCashInhand').DataTable();
 
} );
    function Loanaccount() {


        var from = $('#from').val();
        var to = $('#to').val();


        $('#tcreditloanacc').append("");
        $('#tdebitloanacc').append("");

        $.ajax({
            url: '../ViewLoanAccountsAjax',
            data: {from: from, to: to},
            success: function (responseText) {
                var data = JSON.parse(responseText);
                // alert(responseText);
                //$('#tblloanaccount').DataTable();



                if ($.fn.dataTable.isDataTable('#tblloanaccount')) {
                    table = $('#tblloanaccount').DataTable();
                    table.destroy();
                }


                $("#tblloanaccount").DataTable({
                    dom: 'Bfrtip',
                    buttons: [
                        'excel', 'pdf', 'print', 'colvis'
                    ],
                    data: JSON.parse(responseText),
                    columns: [

                        {data: 'date'},
                        {data: 'Description'},
                        {data: 'Debit'},
                        {data: 'Credit'}



                    ]







                });
                //     $('.Payment-Historymod').modal();

                var table = $('#tblloanaccount').DataTable();
                var sum = table.column(3).data().sum();
                var sum1 = table.column(2).data().sum();


                $('#tcreditloanacc').empty();
                $('#tdebitloanacc').empty();
                $('#tcreditloanacc').append(sum);
                $('#tdebitloanacc').append(sum1);







                //alert(sum1);



            }


        });
    }



    function intrestaccount() {


        var from = $('#from').val();
        var to = $('#to').val();




        $.ajax({
            url: '../ViewIntrestAccounts',
            data: {from: from, to: to},
            success: function (responseText) {




                var data = JSON.parse(responseText);
//                // alert(responseText);
//                //$('#tblloanaccount').DataTable();
//
//

                if ($.fn.dataTable.isDataTable('#interestacc')) {
                    table = $('#interestacc').DataTable();
                    table.destroy();
                }
//
//
                $("#interestacc").DataTable({
                    dom: 'Bfrtip',
                    buttons: [
                        'excel', 'pdf', 'print', 'colvis'
                    ],
                    data: JSON.parse(responseText),
                    columns: [

                        {data: 'date'},
                        {data: 'Description'},
                        {data: 'Debit'},
                        {data: 'Credit'}
//
//
//
                    ]
//
//
//
//


//
                });

//
                var table = $('#interestacc').DataTable();
                var sum = table.column(3).data().sum();
                var sum1 = table.column(2).data().sum();


                $('#tdebitinterestacc').empty();

                $('#tcreditinterestacc').empty();
                $('#tcreditinterestacc').append(sum);
                $('#tdebitinterestacc').append(sum1);







                //alert(sum1);



            }


        });
    }


    function otherIncome() {


        var from = $('#from').val();
        var to = $('#to').val();




        $.ajax({
            url: '../viewotherincomeacc',
            data: {from: from, to: to},
            success: function (responseText) {




                var data = JSON.parse(responseText);
//                // alert(responseText);
//                //$('#tblloanaccount').DataTable();
//
//

                if ($.fn.dataTable.isDataTable('#tblother')) {
                    table = $('#tblother').DataTable();
                    table.destroy();
                }
//
//
                $("#tblother").DataTable({
                    dom: 'Bfrtip',
                    buttons: [
                        'excel', 'pdf', 'print', 'colvis'
                    ],
                    data: JSON.parse(responseText),
                    columns: [

                        {data: 'date'},
                        {data: 'Description'},
                        {data: 'Debit'},
                        {data: 'Credit'}
//
//
//
                    ]
//
//
//
//


//
                });

//
                var table = $('#tblother').DataTable();
                var sum = table.column(3).data().sum();
                var sum1 = table.column(2).data().sum();


                $('#tdebitother').empty();

                $('#tcreditother').empty();
                $('#tcreditother').append(sum);
                $('#tdebitother').append(sum1);





                //alert(sum1);



            }


        });
    }
    function AccuredIncome() {


        var from = $('#from').val();
        var to = $('#to').val();




        $.ajax({
            url: '../ViewAccuredIncome',
            data: {from: from, to: to},
            success: function (responseText) {




                var data = JSON.parse(responseText);
//                // alert(responseText);
//                //$('#tblloanaccount').DataTable();
//
//

                if ($.fn.dataTable.isDataTable('#accured')) {
                    table = $('#accured').DataTable();
                    table.destroy();
                }
//
//
                $("#accured").DataTable({
                    dom: 'Bfrtip',
                    buttons: [
                        'excel', 'pdf', 'print', 'colvis'
                    ],
                    data: JSON.parse(responseText),
                    columns: [

                        {data: 'date'},
                        {data: 'Description'},
                        {data: 'Debit'},
                        {data: 'Credit'}
//
//
//
                    ]
//
//
//
//


//
                });

//
                var table = $('#accured').DataTable();
                var sum = table.column(3).data().sum();
                var sum1 = table.column(2).data().sum();




                
                $('#tdebitaccured').empty();

                $('#tcreditaccured').empty();
                $('#tcreditaccured').append(sum);
                $('#tdebitaccured').append(sum1);





                //alert(sum1);



            }


        });
    }
    function CashinHand() {


        var from = $('#from').val();
        var to = $('#to').val();




        $.ajax({
            url: '../CashInhand',
            data: {from: from, to: to},
            success: function (responseText) {




                var data = JSON.parse(responseText);
//                // alert(responseText);
//                //$('#tblloanaccount').DataTable();
//
//

                if ($.fn.dataTable.isDataTable('#tblCashInhand')) {
                    table = $('#tblCashInhand').DataTable();
                    table.destroy();
                }
//
//
                $("#tblCashInhand").DataTable({
                    dom: 'Bfrtip',
                    buttons: [
                        'excel', 'pdf', 'print', 'colvis'
                    ],
                    data: JSON.parse(responseText),
                    columns: [

                        {data: 'date'},
                        {data: 'Description'},
                        {data: 'Debit'},
                        {data: 'Credit'}
//
//
//
                    ]
//
//
//
//


//
                });

//
                var table = $('#tblCashInhand').DataTable();
                var sum = table.column(3).data().sum();
                var sum1 = table.column(2).data().sum();




                
                $('#tdebitCashInhand').empty();

                $('#tcreditCashInhand').empty();
                $('#tcreditCashInhand').append(sum);
                $('#tdebitCashInhand').append(sum1);





                //alert(sum1);



            }


        });
    }


    $(document).ready(function () {

        $("#filter").click(function () {


            Loanaccount();
            intrestaccount();
            otherIncome();
            AccuredIncome();
            CashinHand();
        });
    });






</script>




<jsp:include page="/footer.jsp"/>