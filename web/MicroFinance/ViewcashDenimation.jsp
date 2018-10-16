<%@page import="Srcs.PoolManager"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="ORM.Staff"%>
<%@page import="org.hibernate.Criteria"%>

<%@page import="org.hibernate.Session"%>
<%
    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }
    PageTitleSet.getTitle().setPAGE_TITLE("Cash Denimation");
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
        padding-top: 10px;
    }
    .btn-primary{
        color: white;
    }
    #executive{
        width: 400px;
    }

</style>-->
<!--<script>
    $('#collapseOne').collapse("hide");


</script>-->

<div id="accordion" role="tablist" aria-multiselectable="true">

    <form action="" id="myForm">
<!--        <div class="card">
            <div class="card-block">-->
                <div class="row">
                    <div class="form-group col-md-3">
                        <label for="formGroupExampleInput">Date</label>
                        <input type="date" name="Rday" id="Rday" class="form-control">
                    </div>
                    <div class="form-group col-md-3">
                        <div class="form-group">
                            <label for="formGroupExampleInput">Select Executive</label>
                            <select class="form-control" id="Executive" name="Executive" onchange="statup()">
                                <option>Select</option>

                                <%                                Session s1 = PoolManager.getSessionFactory().openSession();
                                    Criteria cr1 = s1.createCriteria(Staff.class);
                                    cr1.add(Restrictions.eq("isActive", "Active"));
                                    List<Staff> st = cr1.list();

                                    for (Staff stf : st) {%>


                                <option value="<%= stf.getIdStaff()%>"><%= stf.getNic() + "-" + stf.getNameWithinitials()%></option>

                                <% }
                                    s1.close();
                                %>


                            </select>
                        </div>

                    </div>
                </div>
<!--            </div>
        </div>-->
        <br>
<!--        <div class="card">

            <div class="card-block">-->

                <div class="container">
                    <div class="row">

                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="formGroupExampleInput">Exchange Cash</label>
                                <input type="text" class="form-control" id="ExchangeCash" name="ExchangeCash" readonly="" style="background-color: white" required=""  readonly="">
                                <input hidden="" type="text" class="form-control" id="idStaff" name="idStaff" readonly="" style="background-color: white" required=""  readonly="">

                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Center Collection</label>
                                <input type="text" class="form-control" id="CenterCollection" name="CenterCollection" readonly="" style="background-color: white" required="" >

                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Member Fees</label>
                                <input type="text" class="form-control" id="MemberFees" name="MemberFees" readonly="" style="background-color: white" required=""  readonly="">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">N/P Collection</label>
                                <input type="text" class="form-control" id="npCollection" name="npCollection" readonly="" style="background-color: white" required="" readonly="">
                            </div>
                            <br>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Total Amount</label>
                                <input type="text" class="form-control" id="TotalAmount"  name="TotalAmount" readonly="" style="background-color: white" required="" readonly="">
                            </div>
                            <br><br>

                            <div class="form-group">
                                <label for="example-text-input">5000.00</label>

                                <input class="form-control" type="text" name="example-5000" id="example-5000" required="" readonly="">

                            </div>
                            <div class="form-group">
                                <label for="example-search-input">2000.00</label>

                                <input class="form-control" type="text" name="example-2000" id="example-2000" required="" readonly="">

                            </div>
                            <div class="form-group">
                                <label for="example-email-input">1000.00</label>

                                <input class="form-control" type="text" name="example-1000"  id="example-1000" required="" readonly="">

                            </div>
                            <div class="form-group">
                                <label for="example-url-input">500.00</label>

                                <input class="form-control" type="text" name="example-500" id="example-500" required="" readonly="">

                            </div>
                            <div class="form-group">
                                <label for="example-url-input">100.00</label>

                                <input class="form-control" type="text" name="example-100" id="example-100" required="" readonly="">

                            </div>

                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="formGroupExampleInput">Total Loan Amount</label>
                                <input type="text" class="form-control" id="TotalLoan" name="TotalLoan" readonly="" style="background-color: white" required="" readonly="">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Expenses</label>
                                <input class="form-control" type="text" value="" id="Expenses" name="Expenses" required="" readonly="">
                            </div>
                            <br><br><br><br><br><br><br><br>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Total Amount</label>
                                <input type="text" class="form-control" id="TotalAmount1"  name="TotalAmount1" readonly="" style="background-color: white" required="">
                                <input hidden="" type="text" class="form-control" id="Tot"  name="TotalAmountTT" readonly="" style="background-color: white" required="">
                            </div>
                            <br><br>


                            <div class="form-group">
                                <label for="example-text-input">50.00</label>

                                <input class="form-control" type="text" name="example-50" id="example-50" required="" readonly="">

                            </div>
                            <div class="form-group">
                                <label for="example-search-input">20.00</label>

                                <input class="form-control" type="text" name="example-20" id="example-20" required="" readonly="">

                            </div>
                            <div class="form-group">
                                <label for="example-email-input">10.00</label>

                                <input class="form-control" type="text" name="example-10" id="example-10" required="" readonly="">

                            </div>
                            <div class="form-group">
                                <label for="example-url-input">Coins</label>

                                <input class="form-control" type="text" name="example-Coins" id="example-Coins" required="" readonly="">
                            </div>
                            <div class="form-group">
                                <label for="example-url-input">Total</label>

                                <input class="form-control" type="text" id="example-Total" name="example-Total" readonly="" style="background-color: white" required="" readonly="">

                            </div>

                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="formGroupExampleInput">Short</label>
                                <input class="form-control" type="text" value="" id="Short" name="Short" required="" readonly="">
                                <input hidden="" class="form-control" type="text" value="" id="BalShort" name="ShortSSS" required="" readonly="">


                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Exsas</label>
                                <input class="form-control" type="text" value="" id="Exsas" name="Exsas" required="" readonly="">
                            </div>
                            <br><br><br><br><br><br><br><br>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Balance</label>
                                <input type="text" class="form-control" id="Balance"  name="Balance" readonly="" style="background-color: white" required="" readonly="">
                            </div>
                            <br>
                            <!--                            <div class="form-group">
                                                            <label for="exampleTextarea">Remarks</label>
                                                            <textarea class="form-control" id="Remarks" name="Remarks" rows="4"></textarea>
                                                        </div>-->

                            <br><br><br>

                            <!--                            <div class="form-group text-right">
                                                            <div style="height: 10px;"></div>
                            
                                                            <input type="reset" value="Reset" name="Reset" class="btn btn-danger ">
                                                            <input type="submit" value="Save" name="submit" id="Save" class="btn btn-primary ">
                                                        </div>-->
                        </div>

                    </div>
                </div>

                </form>		
<!--            </div>
        </div>-->
</div>


<div style="height: 10px;"></div>
<div class="card">


</div>



<script>


    //--------------------------------------LOAD RECORDS-----------------------   
    $("#Executive").change(function () {

        var date = $("#Rday").val();
        var center = $("#Executive").find(":selected").val();

        alert("Start");

        if (date !== "" && center !== "Select") {
            $("#idStaff").val(center);
            $.ajax({
                method: "POST",
                url: "../ViewCashDenimation",
                data: {date: date, idStaff: center},
                success: function (data) {

                    alert(data);

                    if (data !== "error") {

                        var json = JSON.parse(data);

                        for (var i = 0; i < json.length; i++) {

                            var ExchangeCash = json[i].ExchangeCash;
                            var TotalLoanAmount = json[i].TotalLoanAmount;
                            var Short = json[i].Short;
                            var CenterCollection = json[i].CenterCollection;
                            var Expences = json[i].Expences;
                            var Exas = json[i].Exas;
                            var MemberFee = json[i].MemberFee;
                            var npcollection = json[i].npcollection;
                            var IncomeAmount = json[i].IncomeAmount;
                            var TotalhortExtras = json[i].TotalhortExtras;
                            var N5000 = json[i].N5000;
                            var N2000 = json[i].N2000;
                            var N1000 = json[i].N1000;
                            var N500 = json[i].N500;
                            var N100 = json[i].N100;
                            var N50 = json[i].N50;
                            var N20 = json[i].N20;
                            var N10 = json[i].N10;
                            var NCoins = json[i].NCoins;
                            var Ntotal = json[i].Ntotal;


//                            var npCollection = json[i].npCollection;
//                            var MemberFees = json[i].MemberFees;
//                            var ExchangeCash = json[i].ExchangeCash;
//                            var TotalAmount = json[i].TotalAmount;

                        }

                        var tot = parseFloat(IncomeAmount) - parseFloat(ExchangeCash);

                        $("#TotalAmount").val(IncomeAmount);
                        $("#CenterCollection").val(CenterCollection);
                        $("#npCollection").val(npcollection);
                        $("#MemberFees").val(MemberFee);
                        $("#ExchangeCash").val(ExchangeCash);
                        $("#TotalLoan").val(TotalLoanAmount);
                        $("#Expenses").val(Expences);
                        $("#Exsas").val(Exas);
                        $("#Short").val(Short);
                        $("#TotalAmount1").val(tot);
                        $("#Tot").val(tot);
                        $("#Balance").val(tot);
                        $("#example-5000").val(N5000);
                        $("#example-2000").val(N2000);
                        $("#example-1000").val(N1000);
                        $("#example-500").val(N500);
                        $("#example-100").val(N100);
                        $("#example-50").val(N50);
                        $("#example-20").val(N20);
                        $("#example-10").val(N10);
                        $("#example-Coins").val(NCoins);
                        $("#example-Total").val(Ntotal);






                    } else {

                        $("#wentWrong").modal();

                    }
                }



            });

        }


    });

</script>
<script src="https://code.jquery.com/jquery-3.2.1.js" integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE=" crossorigin="anonymous"></script>

<jsp:include page="/footer.jsp"/>