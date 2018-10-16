<%
    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }
    PageTitleSet.getTitle().setPAGE_TITLE("Portfolio");

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
<!--<div style="height: 10px"></div>-->

<!--<div style="height: 10px;"></div>-->
<!--<div class="card">
    <div class="card-block">-->

        <div class="container">
            <div class="row">



                <div class="col-md-3">
                    <div class="form-group">
                        <label for="formGroupExampleInput">Total Active Loan With Interest</label>
                        <input type="text" style="background-color: white" class="form-control" id="activeloans" placeholder="Active Loan With Interest" name="activemembers" readonly="">

                    </div>
                    <div class="form-group">
                        <label for="formGroupExampleInput">Active Loan Amount</label>
                        <input type="text" style="background-color: white" class="form-control" id="allLoan" placeholder="Active Loan Amount" name="activeLoan" readonly="">

                    </div>



                </div>
                <div class="col-md-3">

                    <div class="form-group">
                        <label for="formGroupExampleInput">Active Recovery Amount</label>
                        <input type="text" style="background-color: white" class="form-control" id="activerecovery" placeholder="Active Recovery Amount" name="reAmount" readonly="">
                    </div>

                    <div class="form-group">
                        <label for="formGroupExampleInput">Future Recovery</label>
                        <input type="text" style="background-color: white" class="form-control" id="futureRecovery" placeholder="Future Recovery" name="frecovery" readonly="">
                    </div>



                </div>
                <div class="col-md-3">

                    <div class="form-group">
                        <label for="formGroupExampleInput">Future Capital</label>

                        <input class="form-control" style="background-color: white" type="text" value="" id="futurecapital" name="capital" placeholder="Future Capital" readonly="">


                    </div>
                    <div class="form-group">
                        <label for="formGroupExampleInput">Future Interest</label>
                        <input type="text" style="background-color: white" class="form-control" id="futureInterest" placeholder="Future Interest" name="Interest" readonly="">
                    </div>

                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="formGroupExampleInput">Total Arrears</label>
                        <input class="form-control" style="background-color: white" type="email" value="" id="arrears" name="arrears" placeholder="Total Arrears" readonly="">


                    </div>
                    <div class="form-group">
                        <label for="formGroupExampleInput">Expired Arrears</label>
                        <input class="form-control" style="background-color: white" type="tel" value="" id="Expire" 
                               placeholder="Expired Arrears" name="ExpiredArrears" readonly="">
                    </div>

                </div>

            </div>
            <div class="row">

                <div class="col-md-3">

                    <div class="form-group">
                        <label for="formGroupExampleInput">Arrears Age</label>
                        <input class="form-control" style="background-color: white" type="text" value="" id="age" 
                               placeholder="Arrears Age" name="age" readonly="">
                    </div>

                </div>

                <div class="col-md-3">

                    <div class="form-group">
                        <label for="formGroupExampleInput">Collection Percentage</label>
                        <input class="form-control" style="background-color: white" type="text" value="" id="pre" 
                               placeholder="Collection Percentage" name="pre" readonly="">
                    </div>

                </div>


            </div>



        </div>



<!--    </div>

</div>-->


<script>

    $(document).ready(function () {


        $.ajax({

            method: "POST",
            url: "../ViewPortolioReport",

            success: function (res) {

                if (res !== "error") {
                    var ja = JSON.parse(res);

                    for (var i = 0; i < ja.length; i++) {

                        var allLoan = ja[i].allLoan;
                        var activeloans = ja[i].activeloans;
                        var activerecovery = ja[i].activerecovery;
                        var futureRecovery = ja[i].futureRecovery;
                        var futurecapital = ja[i].futurecapital;
                        var futureInterest = ja[i].futureInterest;
                        var arrears = ja[i].arrears;
                        var Expire = ja[i].Expire;
                        var age = ja[i].age;
                        var pre = ja[i].pre;

                    }

                    $("#allLoan").val(allLoan);
                    $("#activeloans").val(activeloans);
                    $("#activerecovery").val(activerecovery);
                    $("#futureRecovery").val(futureRecovery);
                    $("#futurecapital").val(futurecapital);
                    $("#futureInterest").val(futureInterest);
                    $("#arrears").val(arrears);
                    $("#Expire").val(Expire);
                    $("#age").val(age);
                    $("#pre").val(pre);
                } else {

                    $("#wentWrong").modal();

                }

            }

        });


    });

</script>


<jsp:include page="/Modals.jsp"/>
<jsp:include page="/footer.jsp"/>
