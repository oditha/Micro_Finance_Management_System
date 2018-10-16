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
        if (!session.getAttribute("UserType").toString().equals("Executive")) {

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
        padding-top: 10px;
    }
    .btn-primary{
        color: white;
    }
    #executive{
        width: 400px;
    }

</style>
<!--<script>
    $('#collapseOne').collapse("hide");


</script>-->
<div id="accordion" role="tablist" aria-multiselectable="true">

    <form action="" id="myForm">
        <!--<div class="card">-->
            <!--<div class="card-block">-->
                <div class="row">
                    <div class="form-group col-md-3">
                        <label for="formGroupExampleInput">Date</label>
                        <input type="date" name="Rday" id="Rday" class="form-control">
                    </div>
                    <div class="form-group col-md-3">
                        <div class="form-group">
                            <label for="formGroupExampleInput">Select Executive</label>
                            <select class="form-control" id="Executive" name="Executive">
                                <option>Select</option>

                                <%                           
                                    
                                    Session s1 = PoolManager.getSessionFactory().openSession();
                                    Criteria cr1 = s1.createCriteria(Staff.class);
                                    
                                    cr1.add(Restrictions.eq("isActive", "Active"));
                                    cr1.add(Restrictions.eq("nic", session.getAttribute("nic")));
                                    
                                    List<Staff> st = cr1.list();

                                    for (Staff stf : st) {%>


                                <option value="<%= stf.getIdStaff()%>"><%= stf.getNic() + " - " + stf.getNameWithinitials()%></option>

                                <% }
                                    s1.close();
                                %>


                            </select>
                        </div>

                    </div>
                </div>
            <!--</div>-->
        <!--</div>-->
        <br>
<!--        <div class="card">

            <div class="card-block">-->

                <div class="container">
                    <div class="row">

                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="formGroupExampleInput">Exchange Cash</label>
                                <input type="text" class="form-control" id="ExchangeCash" name="ExchangeCash" readonly="" style="background-color: white" required="" >
                                <input hidden="" type="text" class="form-control" id="idStaff" name="idStaff" readonly="" style="background-color: white" required="" >

                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Center Collection</label>
                                <input type="text" class="form-control" id="CenterCollection" name="CenterCollection" readonly="" style="background-color: white" required="" >

                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Member Fees</label>
                                <input type="text" class="form-control" id="MemberFees" name="MemberFees" readonly="" style="background-color: white" required="" >
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">N/P Collection</label>
                                <input type="text" class="form-control" id="npCollection" name="npCollection" readonly="" style="background-color: white" required="">
                            </div>
                            <br>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Total Amount</label>
                                <input type="text" class="form-control" id="TotalAmount"  name="TotalAmount" readonly="" style="background-color: white" required="">
                            </div>
                            <br><br>

                            <div class="form-group">
                                <label for="example-text-input">5000.00</label>

                                <input class="form-control" type="text" name="example-5000" id="example-5000">

                            </div>
                            <div class="form-group">
                                <label for="example-search-input">2000.00</label>

                                <input class="form-control" type="text" name="example-2000" id="example-2000" >

                            </div>
                            <div class="form-group">
                                <label for="example-email-input">1000.00</label>

                                <input class="form-control" type="text" name="example-1000"  id="example-1000" >

                            </div>
                            <div class="form-group">
                                <label for="example-url-input">500.00</label>

                                <input class="form-control" type="text" name="example-500" id="example-500" >

                            </div>
                            <div class="form-group">
                                <label for="example-url-input">100.00</label>

                                <input class="form-control" type="text" name="example-100" id="example-100" >

                            </div>

                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="formGroupExampleInput">Total Loan Amount</label>
                                <input type="text" class="form-control" id="TotalLoan" name="TotalLoan" readonly="" style="background-color: white" required="">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Expenses</label>
                                <input class="form-control" type="text" value="" id="Expenses" name="Expenses" required="">
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

                                <input class="form-control" type="text" name="example-50" id="example-50" required="">

                            </div>
                            <div class="form-group">
                                <label for="example-search-input">20.00</label>

                                <input class="form-control" type="text" name="example-20" id="example-20" required="">

                            </div>
                            <div class="form-group">
                                <label for="example-email-input">10.00</label>

                                <input class="form-control" type="text" name="example-10" id="example-10" required="">

                            </div>
                            <div class="form-group">
                                <label for="example-url-input">Coins</label>

                                <input class="form-control" type="text" name="example-Coins" id="example-Coins" required="">
                            </div>
                            <div class="form-group">
                                <label for="example-url-input">Total</label>

                                <input class="form-control" type="text" id="example-Total" name="example-Total" readonly="" style="background-color: white" required="">

                            </div>

                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="formGroupExampleInput">Short</label>
                                <input class="form-control" type="text" value="" id="Short" name="Short" required="">
                                <input hidden="" class="form-control" type="text" value="" id="BalShort" name="ShortSSS" required="">


                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Exsas</label>
                                <input class="form-control" type="text" value="" id="Exsas" name="Exsas" required="">
                            </div>
                            <br><br><br><br><br><br><br><br>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Balance</label>
                                <input type="text" class="form-control" id="Balance"  name="Balance" readonly="" style="background-color: white" required="">
                            </div>
                            <br>
                            <div class="form-group">
                                <label for="exampleTextarea">Remarks</label>
                                <textarea class="form-control" id="Remarks" name="Remarks" rows="4"></textarea>
                            </div>

                            <br><br><br>

                            <div class="form-group text-right">
                                <div style="height: 10px;"></div>

                                <input type="reset" value="Reset" name="Reset" class="btn btn-danger ">
                                <input type="submit" value="Save" name="submit" id="Save" class="btn btn-primary ">
                            </div>
                        </div>

                    </div>
                </div>

                </form>		
            <!--</div>-->
        <!--</div>-->
</div>


<div style="height: 10px;"></div>
<div class="card">


</div>



<script>

    //--------------------------------------LOAD RECORDS-----------------------   
    $("#Executive").change(function () {

        var date = $("#Rday").val();
        var center = $("#Executive").find(":selected").val()
        if (date !== "" && center !== "Select") {
            $("#idStaff").val(center);
            $.ajax({
                method: "POST",
                url: "../AddCashDenimation",
                data: {date: date, idStaff: center},
                success: function (data) {
                    
                    
                    
                    if (data !== "error") {

                        var json = JSON.parse(data);

                        for (var i = 0; i < json.length; i++) {

                            var CenterCollection = json[i].CenterCollection;
                            var npCollection = json[i].npCollection;
                            var MemberFees = json[i].MemberFees;
                            var ExchangeCash = json[i].ExchangeCash;
                            var TotalAmount = json[i].TotalAmount;

                        }

                        var tot = parseFloat(TotalAmount) - parseFloat(ExchangeCash);

                        $("#TotalAmount").val(TotalAmount);
                        $("#CenterCollection").val(CenterCollection);
                        $("#npCollection").val(npCollection);
                        $("#MemberFees").val(MemberFees);
                        $("#ExchangeCash").val(ExchangeCash);
                        $("#TotalLoan").val(ExchangeCash);
                        $("#Expenses").val(".00");
                        $("#Exsas").val(".00");
                        $("#Short").val(".00");
                        $("#TotalAmount1").val(tot);
                        $("#Tot").val(tot);
                        $("#Balance").val(tot);





                    } else {

                        $("#wentWrong").modal();

                    }
                }



            });

        }


    });

//----------------------------------------------Calculatons---------------------------

    $("#Expenses").keyup(function () {

        var expence = $("#Expenses").val();
        var total = $("#Tot").val();
        var value = parseFloat(total - expence);
        $("#TotalAmount1").val(value);
        $("#Balance").val(value);

    });

    $("#Short").keyup(function () {

        var expence = $("#Short").val();
        var total = $("#TotalAmount1").val();
        var value = parseFloat(total - expence);
        $("#BalShort").val(value);
        $("#Balance").val(value);

    });

    $("#Exsas").keyup(function () {

        var expence = $("#Exsas").val();
        var total = $("#TotalAmount1").val();
        var value = parseFloat(total) + parseFloat(expence);

        $("#Balance").val(value);

    });

    $("#example-Coins").keyup(function () {
        
        
        
        
        

        var total5000 = $("#example-5000").val();
        var total2000 = $("#example-2000").val();
        var total1000 = $("#example-1000").val();
        var total500 = $("#example-500").val();
        var total100 = $("#example-100").val();
        var total50 = $("#example-50").val();
        var total20 = $("#example-20").val();
        var total10 = $("#example-10").val();
        var coins = $("#example-Coins").val();


        var value = parseFloat(total5000 * 5000) + parseFloat(total2000 * 2000) + parseFloat(total1000 * 1000) + parseFloat(total500 * 500) + parseFloat(total100 * 100)
                + parseFloat(total50 * 50) + parseFloat(total20 * 20) + parseFloat(total10 * 10) + parseFloat(coins);

        $("#example-Total").val(value);

    });


//---------------------------------------FOCUS-----------------------------------

    $("#Expenses").focusout(function () {

        $("#Short").focus();

    });
    $("#Exsas").focusout(function () {

        $("#example-5000").focus();

    });
    $("#example-100").focusout(function () {

        $("#example-50").focus();

    });

//---------------------------------SAVE DATA------------------------------------

    $("#Save").click(function () {

        var tot = $("#example-Total").val();
        if (tot !== "") {

            var data = $("#myForm").serialize();

            $.ajax({
                method: "POST",
                url: "../AddCashDenimationServlet",
                data: data,
                success: function (res) {
                    console.log(res)
                    if (res === "done") {

                        swal("Good job!", "Data Saved Sucessfully!", "success");
                        $("#myForm")[0].reset();

                    } else if (res === "error") {

                        $("#wentWrong").modal();


                    }

                }

            });


        }
    });

</script>
<jsp:include page="/Modals.jsp"/>
<jsp:include page="/footer.jsp"/>

