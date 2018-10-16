
<%@page import="Singleton.decimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="ORM.Loan"%>
<%@page import="org.hibernate.Criteria"%>

<%@page import="org.hibernate.Session"%>
<%@page import="Singleton.PageTitleSet"%>
<%
    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }
    PageTitleSet.getTitle().setPAGE_TITLE("Create Loan");

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


</style>
<script>
    $('#collapseOne').collapse("hide");


</script>


<!--Alerts Section-->

<%    if (request.getParameter("save") != null) {

        if (request.getParameter("save").equals("done")) {

            out.print("<div class=\"alert alert-success\" role=\"alert\"><strong>Success!</strong> Data has been saved successfully.</div>");

        } else if (request.getParameter("save").equals("error")) {

            out.print("<div class=\"alert alert-danger\" role=\"alert\"><strong>Error!</strong> A problem has been occurred while submitting your data.</div>");

        } else if (request.getParameter("save").equals("delete")) {

            out.print("<div class=\"alert alert-warning\" role=\"alert\"><strong>Success!</strong> A record has been deleted.</div>");

        }

    }

%>


<!--add Details-->
<%//    Session s = DB.getSession();
//    Criteria c = s.createCriteria(Loan.class);
//    List<Loan> l = c.list();
//    int i = l.size();
//    i++;
//    String contractNo = "CMC-" + decimalFormat.Contract(i);

%>
<div id="accordion" role="tablist" aria-multiselectable="true">
    <div class="card">
        <div class="card-header text-right" role="tab" id="headingOne">

            <a class="btn btn-primary btn-sm" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                +Renew Loan
            </a>

        </div>

        <div id="collapseOne" class="collapse " role="tabpanel" aria-labelledby="headingOne">
            <div class="card-block">


                <form action="../AddRenewLoanServletExecutive" id="myForm" method="POST">

                    <div class="container">
                        <div class="row">

                            <div class="col-md-1"></div>

                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Contract No</label>
                                    <input type="text" style="background-color: white" class="form-control contractNo" id="contractNo" placeholder="Contract No" name="contractNo" readonly="">

                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Search Member</label>
                                    <input type="text" data-toggle="tooltip" title="Press F1 to Search" data-placement="right" class="form-control" id="memberSearch" placeholder="Enter Member ID/NIC" name="memberNo" required="" autofocus="">

                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Member Name</label>
                                    <input type="text" style="background-color: white" class="form-control" id="memberName" placeholder="Member Name" name="memberNo" readonly="">
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Loan Index</label>
                                    <input type="text" style="background-color: white" readonly="" class="form-control" id="lindex" placeholder="Loan Index" name="lindex">
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Guarantor 1</label>
                                    <input class="form-control" style="background-color: white" type="text" value="" id="Guarantor1" name="Guarantor1" placeholder="Guarantor 1" readonly="">
                                </div>
                                <div hidden="">

                                    <input class="form-control" type="text" value="" id="memberID" name="memberid">
                                    <input class="form-control" type="text" value="" id="LoanID" name="loanid">
                                    <input class="form-control" type="text" value="" id="ins" name="ins">
                                </div>


                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Loan Amount</label>
                                    <input type="text" class="form-control text-right" id="amount" placeholder="Enter Loan Amount" name="amount" required="">
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Interest</label>

                                    <input class="form-control text-right" required="" type="text" value="" id="Interest" name="Interest" placeholder="Enter Interest">


                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Period</label>
                                    <input required="" type="text" class="form-control text-right" id="Period" placeholder="Enter Period" name="Period">
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Installment</label>
                                    <input type="text" style="background-color: white" class="form-control text-right" id="Installment" placeholder="Installment" name="Installment" readonly="">
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Guarantor 2</label>
                                    <input class="form-control" style="background-color: white" type="text" value="" id="Guarantor2" name="Guarantor2" placeholder="Guarantor 1" readonly="">
                                </div>

                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Repayment Day</label>
                                    <input class="form-control" style="background-color: white" type="text" value="" id="reDay" name="reDay" readonly="" placeholder="Repayment Day">


                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Member Fee</label>
                                    <input required="" class="form-control text-right" type="text" value="" id="fee" placeholder="Member Fee" name="fee">
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Previous Loan Balance</label>
                                    <input class="form-control  text-danger font-weight-bold text-right" style="background-color: white" type="text" value="" id="pLoan" name="pLoan" placeholder="Previous Loan Amount" readonly="">
                                </div>

                                <div class="form-group">
                                    <label for="formGroupExampleInput">Balance</label>
                                    <input class="form-control text-success font-weight-bold text-right" style="background-color: white" type="text" value="" name="Balance" id="Balance" placeholder="Balance Amount"  readonly="">
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Loan issue Date</label>
                                    <input class="form-control" type="date" value="" name="LoanIssue1" id="LoanIssue" placeholder="Balance Amount"  required="">
                                </div>

                                <div class="form-group text-right">
                                    <div style="height: 10px;"></div>

                                    <!--<input type="reset" value="Reset" name="Reset" class="btn btn-danger ">-->
                                    <input type="submit" value="Save" name="submit" class="btn btn-primary ">
                                </div>
                            </div>

                            <div class="col-md-1"></div>


                        </div>
                    </div>

                </form>	

            </div>
        </div>
    </div>
</div>

<!--Table Section-->


<!--<div class="card">

    <div class="card-block">-->
        <div class="container">
            <form action="../AddLoanServletExecutive" id="myForm" method="POST">
                <div class="container">
                    <div class="row">

                        <div class="col-md-1"></div>



                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="formGroupExampleInput">Contract No</label>
                                <input type="text" style="background-color: white" class="form-control contractNo" id="contractNo" placeholder="Contract No" name="contractNo" value="" readonly="">

                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Search Member</label>
                                <input type="text" data-toggle="tooltip" title="Press F1 to Search" data-placement="right" class="form-control" id="memberNo0" placeholder="Enter Member ID/NIC" name="memberNo" required="" autofocus="">

                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Member Name</label>
                                <input type="text" style="background-color: white" class="form-control" id="nameWithInitials" placeholder="Member Name" name="nameWithInitials" readonly="">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Loan Index</label>
                                <input type="text" readonly="" style="background-color: white" class="form-control" id="LoanIndex" placeholder="Loan Index" name="LoanIndex">
                            </div>
                            <div class="form-group">
                                <label  hidden="" for="formGroupExampleInput"></label>
                                <input type="text" hidden="" class="form-control" id="idMembers" placeholder="Loan Index" name="idMembers">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Loan issue date</label>
                                <input type="date" required="" class="form-control" id="LoanIssue" placeholder="Loan Index" name="LoanIssue">
                            </div>

                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="formGroupExampleInput">Loan Amount</label>
                                <input type="text" class="form-control text-right" id="loanAmount" placeholder="Enter Loan Amount" name="loanamount" required="">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Interest</label>

                                <input required="" class="form-control text-right" type="text" value="" id="loanInterest" name="loanInterest" placeholder="Enter Interest">


                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Period</label>
                                <input required="" type="text" class="form-control text-right" id="loanPeriod" placeholder="Enter Period" name="loanPeriod">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Installment</label>
                                <input type="text" style="background-color: white" class="form-control text-right" id="loanInstallment" placeholder="Installment" name="loanInstallment" readonly="">
                            </div>

                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="formGroupExampleInput">Repayment Day</label>
                                <input class="form-control" style="background-color: white" type="text" value="" id="centerDay" name="loancenterDay" readonly="" placeholder="Repayment Day">


                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Member Fee</label>
                                <input class="form-control text-right" type="text" value="" id="Memfee" placeholder="Enter Member Fee" name="loanfee" required="">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Guarantor 1</label>
                                <input class="form-control" style="background-color: white" type="text" value="" id="Guarantor10" name="loanGuarantor1" placeholder="Guarantor 1" readonly="">
                            </div>

                            <div class="form-group">
                                <label for="formGroupExampleInput">Guarantor 2</label>
                                <input class="form-control" style="background-color: white" type="text" value="" name="loanGuarantor2" id="Guarantor20" placeholder="Guarantor 2"  readonly="">
                            </div>
                            <div class="form-group text-right">
                                <div style="height: 30px;"></div>
                                <!--<input type="reset" value="Reset" name="Reset" class="btn btn-danger " id="reset">-->
                                <input type="submit" value="Save" name="submit" class="btn btn-primary" id="save">
                            </div>
                        </div>

                        <div class="col-md-1"></div>

                    </div>
                </div>
            </form>	

        </div>
<!--    </div>

</div>-->

<script>

    $("#save").click(function() {
    
     $("#save").attr("disabled", "disabled");
    
});


//------------------Load All Loan Records---------------

    $(document).ready(function () {


        $.ajax({
            method: "post",
            url: "",
            data: "",
            success: function (response) {



            }


        });




    });


//--------------------load tooltip
//    $(document).ready(function () {
//        $('[data-toggle="tooltip"]').tooltip();
//    });


//---------------------member serarch

    $('#memberNo0').keyup(function (e) {

        var key = e.which;


        if (key === 35) {

            var memberID = $(this).val();

            $.ajax({
                method: 'post',
                url: '../ViewMemberDataAJAX',
                data: {memberID: memberID},
                success: function (responseText) {


                    if (responseText === 'SearchError') {

                        $("#adSearch").modal();


                    } else {



                        var ja = JSON.parse(responseText);
                        for (var i = 0; i < ja.length; i++) {

                            var nameWithInitials = ja[i].nameWithInitials;
                            var centerDay = ja[i].centerDay;
                            var LoanIndex = ja[i].LoanIndex;
                            var Gar = ja[i].Gar;
                            var flag = ja[i].flag;
                            var idMembers = ja[i].idMembers;



                        }

                        if (flag) {

                            swal("Error", "Settle current loan or take action for pending lone before add new loan!", "error");

                            $('#loanInterest').prop('readonly', true);
                            $('#loanAmount').prop('readonly', true);
                            $('#Memfee').prop('readonly', true);
                            $('#loanPeriod').prop('readonly', true);
                            $('#idMembers').attr('value', idMembers);

                            //$('#collapseOne').collapse();



                        } else {

//                            $('#collapseOne').collapse('toggle');
                            $('#loanInterest').prop('readonly', false);
                            $('#loanAmount').prop('readonly', false);
                            $('#Memfee').prop('readonly', false);
                            $('#loanPeriod').prop('readonly', false);

                            var g1 = Gar.split("+")[0];
                            var g2 = Gar.split("+")[1];

                            $('#nameWithInitials').attr('value', nameWithInitials);
                            $('#centerDay').attr('value', centerDay);
                            $('#LoanIndex').attr('value', LoanIndex);
                            $('#idMembers').attr('value', idMembers);
                            $('#Guarantor10').attr('value', g1);
                            $('#Guarantor20').attr('value', g2);
                            $('#LoanIssue').focus();

                        }

                    }
                }
            });
        }
    });


//-----------------------------calculation loan
    $('#loanPeriod').keyup(function () {

        try {
            var intr = $('#loanInterest').val();
            var loan = $('#loanAmount').val();
            var peri = $('#loanPeriod').val();

            var total = parseFloat(loan) + parseFloat(intr);

            var installment = parseFloat(total / peri);

            $('#loanInstallment').attr('value', installment);

        } catch (e) {

            alert(e);

        }


    });


//----------------------------------retry search

    $(document).ready(function () {


        $('#advButton').click(function () {

            var search = $('#search').val();

            var form = $('#advForm').serialize();

            $.ajax({
                method: 'POST',
                url: '../SearchMemberLoanAJAX',
                data: form,
                success: function (responseText) {



                    if (responseText === 'SearchError') {

                        $("#adSearch").modal('toggle');
                        $("#searchError").modal();



                    } else {

                        $('#memberNo0').val(search);
                        $('#adSearch').modal('toggle')

                        var ja = JSON.parse(responseText);
                        for (var i = 0; i < ja.length; i++) {

                            var nameWithInitials = ja[i].nameWithInitials;
                            var centerDay = ja[i].centerDay;
                            var LoanIndex = ja[i].LoanIndex;
                            var Gar = ja[i].Gar;
                            var flag = ja[i].flag;
                            var idMembers = ja[i].idMembers;



                        }

                        if (flag) {

                            swal("Error", "Settle current loan or take action for pending lone before add new loan!", "error");

                            $('#loanInterest').prop('readonly', true);
                            $('#loanAmount').prop('readonly', true);
                            $('#Memfee').prop('readonly', true);
                            $('#loanPeriod').prop('readonly', true);
//                            $('#collapseOne').collapse();



                        } else {

//                            $('#collapseOne').collapse('toggle');
                            $('#loanInterest').prop('readonly', false);
                            $('#loanAmount').prop('readonly', false);
                            $('#Memfee').prop('readonly', false);
                            $('#loanPeriod').prop('readonly', false);

                            var g1 = Gar.split("+")[0];
                            var g2 = Gar.split("+")[1];

                            $('#nameWithInitials').attr('value', nameWithInitials);
                            $('#centerDay').attr('value', centerDay);
                            $('#LoanIndex').attr('value', LoanIndex);
                            $('#idMembers').attr('value', idMembers);
                            $('#Guarantor10').attr('value', g1);
                            $('#Guarantor20').attr('value', g2);
                            $('#loanAmount').focus();

                        }

                    }


                }


            });
        });

    });


//---------------------------open renew loan

    $(document).ready(function () {

        $('#reloan').click(function () {

            $('#collapseOne').collapse();
            $('#loanSettle').modal('toggle');
            $('#amount').focus();

            var id = $('#idMembers').val();

            $.ajax({
                method: 'post',
                url: '../LoadMemberDataRenewLoanAJAX',
                data: {id: id},
                success: function (responseText) {


                    if (responseText === 'error') {

                        $('#renewError').modal();

                    } else {

                        var json = JSON.parse(responseText);

                        for (var i = 0; i < json.length; i++) {

                            var memberName = json[i].memberName;
                            var reDay = json[i].reDay;
                            var lindex = json[i].lindex;
                            var Gar = json[i].Gar;
                            var pLoan = json[i].pLoan;
                            var memberID = json[i].memberID;
                            var memberSearch = json[i].memberSearch;
                            var ins = json[i].ins;
                            var LoanID = json[i].loanid;
                        }

                        var gr1 = Gar.split("+")[0];
                        var gr2 = Gar.split("+")[1];

                        $('#memberName').attr('value', memberName);
                        $('#reDay').attr('value', reDay);
                        $('#lindex').attr('value', lindex);
                        $('#pLoan').attr('value', pLoan);
                        $('#memberID').attr('value', memberID);
                        $('#memberSearch').attr('value', memberSearch);
                        $('#Guarantor1').attr('value', gr1);
                        $('#Guarantor2').attr('value', gr2);
                        $('#LoanID').attr('value', LoanID);
                        $('#ins').attr('value', ins);
                        $('#loanAmount').focus();
                    }



                }

            });

        });

    });

//-------------------------------renew loan search    

    $('#memberSearch').keyup(function (event) {

        var key = event.which;

        if (key === 35) {

            var val = $('#memberSearch').val();

            $.ajax({
                method: 'post',
                url: '../RenewLoanSearchAJAX',
                data: {member: val},
                success: function (responseText) {

                    if (responseText === "SearchError") {

                        $('#renewSearch').modal();

                    } else if (responseText === "error") {

                        swal("Error", "Take Avtion for pending loan or add repayment before renew loan!", "error");

                    } else if (responseText === "err") {

                        swal("Error", "Take Action for pending loan before add new loan!", "error");

                    } else {

                        var json = JSON.parse(responseText);

                        for (var i = 0; i < json.length; i++) {

                            var memberName = json[i].memberName;
                            var reDay = json[i].reDay;
                            var lindex = json[i].lindex;
                            var Gar = json[i].Gar;
                            var pLoan = json[i].pLoan;
                            var memberID = json[i].memberID;
                            var memberSearch = json[i].memberSearch;
                            var ins = json[i].ins;
                            var LoanID = json[i].loanid;
                        }

                        var gr1 = Gar.split("+")[0];
                        var gr2 = Gar.split("+")[1];

                        $('#memberName').attr('value', memberName);
                        $('#reDay').attr('value', reDay);
                        $('#lindex').attr('value', lindex);
                        $('#pLoan').attr('value', pLoan);
                        $('#memberID').attr('value', memberID);
                        $('#memberSearch').attr('value', memberSearch);
                        $('#Guarantor1').attr('value', gr1);
                        $('#Guarantor2').attr('value', gr2);
                        $('#LoanID').attr('value', LoanID);
                        $('#ins').attr('value', ins);
                        $('#amount').focus();

                    }

                }

            });

        }

    });

//----------------------------------------renew loan advance search--------------DONE

    $(document).ready(function () {

        $('#renewButton').click(function () {

            var search = $('#renewForm').serialize();


            $.ajax({
                method: 'post',
                url: '../SearchMemberRenewAJAX',
                data: search,
                success: function (responseText) {

                    if (responseText === "SearchError") {

//                        alert(responseText);
                        $('#renewSearch').modal('toggle')
                        $('#searchError').modal();

                    } else if (responseText === "error") {

                        swal("Error", "Take Avtion for pending loan or add repayment before renew loan!", "error");


                    } else if (responseText === "err") {


                        swal("Oops", "Take action for pending loan before add new loan!", "error");


                    } else {

                        $('#memberSearch').val($('#renewsearch').val());
                        $('#renewSearch').modal('toggle')



                        var json = JSON.parse(responseText);

                        for (var i = 0; i < json.length; i++) {

                            var memberName = json[i].memberName;
                            var reDay = json[i].reDay;
                            var lindex = json[i].lindex;
                            var Gar = json[i].Gar;
                            var pLoan = json[i].pLoan;
                            var memberID = json[i].memberID;
                            var memberSearch = json[i].memberSearch;
                            var ins = json[i].ins;
                            var LoanID = json[i].loanid;


                        }

                        var gr1 = Gar.split("+")[0];
                        var gr2 = Gar.split("+")[1];

                        $('#memberName').attr('value', memberName);
                        $('#reDay').attr('value', reDay);
                        $('#lindex').attr('value', lindex);
                        $('#pLoan').attr('value', pLoan);
                        $('#memberID').attr('value', memberID);
                        $('#memberSearch').attr('value', memberSearch);
                        $('#Guarantor1').attr('value', gr1);
                        $('#Guarantor2').attr('value', gr2);
                        $('#LoanID').attr('value', LoanID);
                        $('#ins').attr('value', ins);
                        $('#amount').focus();

                    }

                }

            });

        });

    });

//------------------------------------------Renew Loan Balance

    $('#amount').keyup(function () {

        var amount = $('#amount').val();
        var paid = $('#pLoan').val();

        var balace = parseFloat(amount) - parseFloat(paid);

        $('#Balance').val(balace);

    });

//----------------------------------------renew loan calculation

    $('#Period').keyup(function () {

        var amo = $('#amount').val();
        var inters = $('#Interest').val();
        var time = $('#Period').val();

        var ins = parseFloat(amo) + parseFloat(inters);

        var tot = parseFloat(ins / time);

        $('#Installment').val(tot);

    });


//--------------------------------------------------FOCUS----------------------

    $("#loanPeriod").focusout(function () {

        $("#Memfee").focus();

    });



//-----------------------------------------Refrest Contract No------------------


    $(document).ready(function () {

        setInterval(function () {

            $

        }, 500);

    });

//------------------------------------Generate Contract No----------------------

    $(document).ready(function () {
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {

//            alert(this.responseText);

                var val = this.responseText;


                $(".contractNo").val(val);



            }
        };
        xmlhttp.open("GET", "../GenContractNO", true);
//            xmlhttp.setRequestHeader("Content-Type", "application/x-www-from-urlencoded");

        xmlhttp.send();
//        setInterval(function () {
//
//            var xmlhttp = new XMLHttpRequest();
//            xmlhttp.onreadystatechange = function () {
//                if (this.readyState == 4 && this.status == 200) {
//
////            alert(this.responseText);
//
//                    var val = this.responseText;
//
//                    
//                    $(".contractNo").val(val);
//                       
//
//
//                }
//            };
//            xmlhttp.open("GET", "../GenContractNO", true);
////            xmlhttp.setRequestHeader("Content-Type", "application/x-www-from-urlencoded");
//
//            xmlhttp.send();
//
//
//        }, 1000);

    });

</script>

<div class="modal fade" id="renewSearch">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">No result found</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">

                <div class="container">

                    <div class="row">

                        <div class="col-md-12">
                            <form action="" id="renewForm">
                                <div class="form-group">

                                    <label for="formGroupExampleInput">Search type</label><br>

                                    <label class="radio-inline"><input type="radio" name="optradio" value="nic">NIC</label>
                                    <label class="radio-inline"><input type="radio" name="optradio" value="memberNo"> Member ID</label>
                                </div>

                                <div class="input-group">
                                    <input type="text" class="form-control" id="renewsearch" name="search" placeholder="Search for..." aria-label="Search for...">
                                    <span class="input-group-btn" id="span">
                                        <button class="btn btn-primary btnSerach" type="button" id="renewButton" >Go!</button>
                                    </span>
                                </div>
                            </form>
                        </div>

                    </div>


                </div>


            </div>

            <!-- Modal footer -->
            <div class="modal-footer">

            </div>

        </div>
    </div>
</div>

<!-- The Modal msg-->
<div class="modal fade" id="loanSettle">
    <div class="modal-dialog ">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Warning</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <strong>Settle current loan before create new loan or use</strong> 
                <button type="button" class="btn btn-success btn-sm" id="reloan">Renew loan</button>
                <strong> to create new loan.</strong>
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>



<!-- The Modal Renew Error-->
<div class="modal fade" id="renewError">
    <div class="modal-dialog ">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Warning</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <strong>You cannot renew loan without add any repayment.</strong> 

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>

<jsp:include page="/Modals.jsp"/>
<jsp:include page="/footer.jsp"/>
