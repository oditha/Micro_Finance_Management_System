<%
    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }
    PageTitleSet.getTitle().setPAGE_TITLE("Ledger Report");

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
<!--<div style="height: 10px"></div>

-->
<!--<div style="height: 10px;"></div>-->
<!--<div class="card">
    <div class="card-block">-->
        <div class="container">
            <div class="row">



                <div class="col-md-3">
                    <div class="form-group">
                        <label for="formGroupExampleInput">Member Name</label>
                        <!--<div style="height: 6px"></div>-->
                        <input type="tel" style="background-color: white" class="form-control" id="memberName" placeholder="Member Name" name="membername" readonly="">

                    </div>
                    <div class="form-group">
                        <label for="formGroupExampleInput">Contract No</label>
                        <input class="form-control" style="background-color: white" type="tel" value="" id="contractNo" name="Contract No" placeholder="Contract No" readonly="">


                    </div>
                    <div class="form-group">
                        <label for="formGroupExampleInput">Interest</label>
                        <input class="form-control" style="background-color: white" type="tel" value="" id="TwithInrest" name="TwithInrest" placeholder="Total With Interest" readonly="">


                    </div>


                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="formGroupExampleInput">Center Name</label>
                        <!--<div style="height: 6px"></div>-->
                        <input type="tel" style="background-color: white" class="form-control" id="cname" placeholder="Center Name" name="cname" readonly="">
                    </div>
                    <div class="form-group">
                        <label for="formGroupExampleInput">Loan Amount</label>
                        <input class="form-control" type="tel" style="background-color: white" value="" id="lAmount" name="loanAmount" placeholder="Loan Amount" readonly="">


                    </div>

                    <div class="form-group">
                        <label for="formGroupExampleInput">Loan Close Date</label>
                        <input class="form-control" style="background-color: white" type="tel" value="" id="closedate" 
                               placeholder="Loan Close Date" name="closedate" readonly="">
                    </div>

                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="formGroupExampleInput">Contact No</label>
                        <!--<div style="height: 6px"></div>-->
                        <input type="tel" style="background-color: white" class="form-control" id="contactNo" placeholder="Contact No" name="activeLoan" readonly="">

                    </div>

                    <div class="form-group">
                        <label for="formGroupExampleInput">Issued Date</label>
                        <input class="form-control" style="background-color: white" type="tel" value="" id="IssuedDate" 
                               placeholder="Issued Date" name="IssuedDate" readonly="">
                    </div>
                    <div class="form-group">
                        <label for="formGroupExampleInput">Guarantor 1</label>
                        <input class="form-control" style="background-color: white" type="tel" value="" id="Guarantor1" 
                               placeholder="Guarantor 1" name="Guarantor1" readonly="">
                    </div>

                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="formGroupExampleInput">Loan Index</label>

                        <select class="form-control" id="loanIndex">
                            <option>Select</option>


                        </select>


                    </div>

                    <div class="form-group">
                        <label for="formGroupExampleInput">Total Paid</label>
                        <input class="form-control" style="background-color: white" type="tel" value="" id="paid" 
                               placeholder="Total Paid" name="TotalPaid" readonly="">
                    </div>

                    <div class="form-group">
                        <label for="formGroupExampleInput">Guarantor 2</label>
                        <input class="form-control" style="background-color: white" type="tel" value="" id="Guarantor2" 
                               placeholder="Guarantor 2" name="Guarantor2" readonly="">
                    </div>

                </div>

            </div>

            <div class="row">

                <div class="col-md-3">

                    <div class="form-group">
                        <label for="formGroupExampleInput">Balance</label>
                        <input class="form-control" type="tel" style="background-color: white" value="" id="Balance" name="Balance" placeholder="Balance" readonly="">


                    </div>

                </div>

                <div class="col-md-3">

                    <div class="form-group">
                        <label for="formGroupExampleInput">Arrears</label>
                        <input class="form-control" type="tel" style="background-color: white" value="" id="Arrears" name="Arrears" placeholder="Arrears" readonly="">


                    </div>

                </div>

                <div class="col-md-3">

                    <div class="form-group">
                        <label for="formGroupExampleInput">Arrears Age</label>
                        <input class="form-control" type="tel" style="background-color: white" value="" id="Arrearsage" name="Arrearsage" placeholder="Arrears Age" readonly="">


                    </div>

                </div>
                <div class="col-md-3">

                    <div class="form-group">
                        <label for="formGroupExampleInput">Arrears Type</label>
                        <input class="form-control" type="tel" style="background-color: white" value="" id="type" name="type" placeholder="Arrears Type" readonly="">


                    </div>

                </div>



            </div>

            <div class="row">

                <div class="col-md-3">

                    <div class="form-group">
                        <label for="formGroupExampleInput">Total Installment Count</label>
                        <input class="form-control" type="tel" style="background-color: white" value="" id="totcount" name="totcount" placeholder="Total Installment Count" readonly="">


                    </div>

                </div>
                <div class="col-md-3">

                    <div class="form-group">
                        <label for="formGroupExampleInput">Paid Installment Count</label>
                        <input class="form-control" type="tel" style="background-color: white" value="" id="padicount" name="padicount" placeholder="Paid Installment Count" readonly="">


                    </div>

                </div>

                <div class="col-md-3">

                    <div class="form-group">
                        <label for="formGroupExampleInput">Remaining Installment Count</label>
                        <input class="form-control" type="tel" style="background-color: white" value="" id="recount" name="recount" placeholder="Remaining Installment Count" readonly="">


                    </div>

                </div>


            </div>

        </div>
        <hr>
        <div class=" table-responsive ">          
            <table class="table table-stripped" id="ledger">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Actual Date</th>
                        <th>Payment Date</th>
                        <th>Receipt No</th>

                        <th style="text-align:right">Paid Amount</th>


                    </tr>
                </thead>
                <tbody>

                </tbody>

                <tfoot>
                    <tr>
                        <th colspan="3" style="text-align:right">Total:</th>
                        <th colspan="2"></th>

                    </tr>
                </tfoot> 


            </table>
            <!--<div style="height: 10px;"></div>-->




        </div>

<!--    </div>

</div>-->


<script>




    $(document).ready(function () {

        $("input[type=text]").val("");

        var getUrlParameter = function getUrlParameter(sParam) {
            var sPageURL = decodeURIComponent(window.location.search.substring(1)),
                    sURLVariables = sPageURL.split('&'),
                    sParameterName,
                    i;

            for (i = 0; i < sURLVariables.length; i++) {
                sParameterName = sURLVariables[i].split('=');

                if (sParameterName[0] === sParam) {
                    return sParameterName[1] === undefined ? true : sParameterName[1];
                }
            }
        };


        var member = getUrlParameter('memid');



        $.ajax({

            method: "POST",
            url: "../viewLedgerReportSearch",
            data: {member: member},
            success: function (res) {

                if (res === "error") {

                    $("#wentWrong").modal();

                } else if (res === "SearchError") {

                    $("#adSearch").modal();

                } else {

                    var jaMem = res.split("_")[0];
                    var jaindex = res.split("_")[1];

                    var ja1 = JSON.parse(jaMem);
                    var ja2 = JSON.parse(jaindex);

                    for (var i = 0; i < ja1.length; i++) {

                        var memberName = ja1[i].memberName;
                        var cname = ja1[i].cname;
                        var contactNo = ja1[i].contactNo;


                    }

                    $("#memberName").val(memberName);
                    $("#cname").val(cname);
                    $("#contactNo").val(contactNo);
                    //   $("#TwithInrest").val(loanwithintrest);

                    for (var i = 0; i < ja2.length; i++) {

                        $('#loanIndex').append($('<option>', {
                            value: ja2[i].idLoan,
                            text: ja2[i].index
                        }));

                    }


                }

            }

        });

    })

//---------------------load loan record-----------------------------------------

    $("#loanIndex").change(function () {

        var idLoan = $(this).val();
        var index = $(this).find(":selected").text();

        $.ajax({
            method: "POST",
            url: "../ViewLedgerReportLoan",
            data: {idLoan: idLoan, index: index},
            success: function (res) {


                if (res !== "error") {
                    var js = res.split("$")[1];
                    var tot = res.split("$")[0];
                    var lamo = tot.split("&")[0]
                    var iss = tot.split("&")[1]
                    var cont = tot.split("&")[2]
                    var paid = tot.split("&")[3]
                    var loanwithintrest = tot.split("&")[4]
                    var gar1 = tot.split("&")[5]
                    var gar2 = tot.split("&")[6]
                    var close = tot.split("&")[7]
                    var balance = tot.split("&")[8]
                    var arreas = tot.split("&")[9]
                    var age = tot.split("&")[10]
                    var type = tot.split("&")[11]
                    var paidcount = tot.split("&")[12]
                    var recount = tot.split("&")[13]
                    var totcount = tot.split("&")[14]

                    $("#paid").val(paid);
                    $("#contractNo").val(cont);
                    $("#lAmount").val(lamo);
                    $("#IssuedDate").val(iss);
                    $("#TwithInrest").val(loanwithintrest);
                    $("#Guarantor1").val(gar1);
                    $("#Guarantor2").val(gar2);
                    $("#closedate").val(close);
                    $("#Balance").val(balance);
                    $("#Arrears").val(arreas);
                    $("#Arrearsage").val(age);
                    $("#type").val(type);
                    $("#padicount").val(paidcount);
                    $("#recount").val(recount);
                    $("#totcount").val(totcount);

                    var arr = JSON.parse(js);

                    if ($.fn.dataTable.isDataTable('#ledger')) {
                        table = $('#ledger').DataTable();
                        table.destroy();
                    }


                    $("#ledger").DataTable({
                        dom: 'Bfrtip',
                        buttons: [
                            'excel', 'pdf', 'print', 'colvis'
                        ],
                        data: arr,
                        columns: [
                            {data: 'count'},
                            {data: 'ActualDays'},
                            {data: 'dates'},
                            {data: 'paid'},
                            {data: 'receipt'},
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



                            // Total over all pages
                            total = api
                                    .column(3)
                                    .data()
                                    .reduce(function (a, b) {
                                        return intVal(a) + intVal(b);
                                    }, 0);

                            // Total over this page
                            pageTotal = api
                                    .column(3, {page: 'current'})
                                    .data()
                                    .reduce(function (a, b) {
                                        return intVal(a) + intVal(b);
                                    }, 0);

                            // Update footer
                            $(api.column(3).footer()).html(
                                    'Rs ' + pageTotal + ' ( Rs ' + total + ' total)'
                                    );
                        }

                    });




                } else {

                    $("#wentWrong").modal( );

                }

            }


        });

    });

    //--------------------------DataTable--------------------------------------
    $(document).ready(function () {

        $("#ledger").DataTable({
            dom: 'Bfrtip',
            buttons: [
                'excel', 'pdf', 'print', 'colvis'
            ]
        });

    });
</script>


<jsp:include page="/Modals.jsp"/>
<jsp:include page="/footer.jsp"/>
