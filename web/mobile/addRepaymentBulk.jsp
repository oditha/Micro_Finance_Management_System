<%-- 
    Document   : regStaff
    Created on : Nov 21, 2017, 10:42:11 PM
    Author     : iamarshrx
--%>
<%@page import="Srcs.PoolManager"%>
<%@page import="ORM.Repayment"%>
<%@page import="ORM.Loan"%>
<%@page import="ORM.Members"%>
<%@page import="java.util.Iterator"%>
<%@page import="Servlets.MicroFinance.AddRepaymentALLAJAX"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="ORM.Center"%>

<%@page import="org.hibernate.Criteria"%>
<%@page import="Singleton.PageTitleSet"%>
<%

    PageTitleSet.getTitle().setPAGE_TITLE("Add Repayment All");

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"/>



<style>
    form .container{
        padding-top: 30px;
    }
    .btn-primary{
        color: white;
    }


</style>
<script>
    $('#collapseOne').collapse("hide");</script>
<div style="height: 10px"></div>

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
<div style="height: 10px"></div>

<!--add Details-->
<!--Table Section-->

<div style="height: 10px;"></div>
<div class="card">
    <div class="card-header text-right">

        <div class=""><a class="btn btn-danger btn-sm" href="home.jsp">
                Back
            </a></div> 



    </div>
    <div class="card-body">
        <div class="container">
            <!--<form action="../AddRepaymentAlllServlet" id="myForm0">-->
            <div class=" table-responsive ">          
                <table class="table table-stripped" id="repayTable">
                    <thead>
                        <tr>
                            
                            <th>Member No</th>
                            
                            <th>Contract No</th>
                            <th>Payment</th>

                        </tr>
                    </thead>
                    <tbody>



                        <%                                try {
                                int ID = 1;
                                String parameter = request.getParameter("cid");
                                Criteria createCriteria = PoolManager.getSessionFactory().openSession().createCriteria(Center.class);
                                createCriteria.add(Restrictions.eq("idCenter", Integer.parseInt(parameter)));
                                createCriteria.add(Restrictions.eq("isActive", "Active"));
                                Center uniqueResult = (Center) createCriteria.uniqueResult();

                                Iterator iterator = uniqueResult.getMemberses().iterator();
                                while (iterator.hasNext()) {

                                    Members next = (Members) iterator.next();

                                    Iterator iterator1 = next.getLoans().iterator();

                                    String memberNo = next.getMemberNo();
                                    String nameWithInitials = next.getNameWithInitials();

                                    while (iterator1.hasNext()) {

                                        Loan next1 = (Loan) iterator1.next();

                                        if (next1.getStatus().equals("Unpaid")) {

                                            Double loanAmount = next1.getLoanAmount() + next1.getLoanInterest();
                                            Integer idLoan = next1.getIdLoan();
                                            Double loanInstallment = next1.getLoanInstallment();
                                            String repaymentDay = next1.getRepaymentDay();
                                            String contractNo = next1.getContractNo();
                                            double sum = 0;
                                            Iterator iterator2 = next1.getRepayments().iterator();
                                            while (iterator2.hasNext()) {

                                                Repayment next2 = (Repayment) iterator2.next();

                                                sum += next2.getPaidAmount();

                                            }

                                            double balance = loanAmount - sum;%>

                        <tr>

                            
                            <td cenDay ="<%= repaymentDay%>" loanAmo = "<%= loanAmount%>"><%= memberNo%></td>
                            
                            <td idLoan = "<%= idLoan%>" installment = "<%= loanInstallment%>"><%= contractNo%></td>
                            
                            <td><input type="text" name="Paid" class="form-control"></td>

                        </tr>




                        <%   }

                                    }

                                }
                                PoolManager.getSessionFactory().close();

                            } catch (Exception e) {

                                out.write("" + e);
                                e.printStackTrace();

                            }


                        %>




                    </tbody>
                </table>

                <div style="height: 10px;"></div>

            </div>
            <div class="form-group text-right">
                <div style="height: 10px;"></div>
                <input type="reset" value="Reset" name="Reset" class="btn btn-danger " >
                <input type="submit" value="Save" name="submit" class="btn btn-primary " id="CenterFilter">
            </div>

            <!--</form>-->	

        </div>
    </div>

</div>


<script>

    //--------------getData from Table

    $("#CenterFilter").click(function () {

        var table = $("table tbody");
        jsonObject = [];
        table.find("tr").each(function (i) {

            var $tds = $(this).find("td");

            repayment = $tds.eq(1).attr("installment");
            Loan = $tds.eq(0).attr("loanAmo");
            Paid = $tds.eq(2).find("input").val();
            acDay = $tds.eq(0).attr("cenDay");
            idLoan = $tds.eq(1).attr("idLoan");

            item = {};
            item ["repayment"] = repayment;
            item ["Paid"] = Paid;
            item ["acDay"] = acDay;
            item ["idLoan"] = idLoan;
            item ["Loan"] = Loan;
            
            jsonObject.push(item);





        });
        
        
        var json = JSON.stringify(jsonObject);
        $.ajax({
            
            method: "POST",
            url: "../AddRepaymentALLAJAX",
            data: {json: json},
            
            success: function (res) {
                
                alert(res)
                
                if (res === "ok") {
                    
                   
                    
                    $("#saveDoneMob").modal({
                        
                        keyboard: false
                        
                        
                    });
                     $("table").find("tr:gt(0)").remove();
                }else{
                    
                    $("#wentWrong").modal();
                    
                }
                        
                    }
            
            
        });
        

    });




</script>



<jsp:include page="/Modals.jsp"/>
<jsp:include page="/footer.jsp"/>
