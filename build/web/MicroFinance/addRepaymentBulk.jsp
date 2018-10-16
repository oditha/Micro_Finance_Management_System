<%-- 
    Document   : regStaff
    Created on : Nov 21, 2017, 10:42:11 PM
    Author     : iamarshrx
--%>
<%@page import="org.hibernate.Session"%>
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
    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }
    PageTitleSet.getTitle().setPAGE_TITLE("Add Repayment All");
    try {
        if (!session.getAttribute("UserType").toString().equals("Manager")) {

            response.sendRedirect("/CMC/errorPage/401Unauthorized.html");

        }
    } catch (Exception e) {
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/header.jsp"/>



<!--<style>
    form .container{
        padding-top: 30px;
    }
    .btn-primary{
        color: white;
    }


</style>-->
<script>
    $('#collapseOne').collapse("hide");</script>
<!--<div style="height: 10px"></div>-->

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
<!--<div style="height: 10px"></div>-->

<!--add Details-->
<!--Table Section-->

<!--<div style="height: 10px;"></div>-->
<!--<div class="card">-->
    <!--<div class="card-header">-->

        <div class="text-left">

            <h4 id="centername">

                <%            
                    
                    Center uniqueResult = null;
                        String parameter = request.getParameter("selectCenter");
                            Session sesss = PoolManager.getSessionFactory().openSession();
                    
                    try {
                        int ID = 1;
                        Criteria createCriteria = sesss.createCriteria(Center.class);
                        createCriteria.add(Restrictions.eq("idCenter", Integer.parseInt(parameter)));
                        createCriteria.add(Restrictions.eq("isActive", "Active"));
                        createCriteria.add(Restrictions.eq("isApprove", "Approve"));

                        uniqueResult = (Center) createCriteria.uniqueResult();
                        String name = uniqueResult.getCenterName();
                        out.write("Centre "+name);
                    } catch (Exception e) {
                    }

                %>

            </h4>

        </div>


                <div class="text-right" style="padding-bottom: 20px;"><a class="btn btn-danger btn-sm" href="addRepayment.jsp">
                Back
            </a></div> 



    <!--</div>-->
    <!--<div class="card-body">-->
        <div class="container">
            <!--<form action="../AddRepaymentAlllServlet" id="myForm0">-->
            <div class=" table-responsive ">          
                <table class="table table-stripped" id="repayTable">
                    <thead>
                        <tr>
                            <!--<th>#</th>-->
                            <th>Member No</th>
                            <th>Member Name</th>
                            <th>Contract No</th>
                            <th>Loan Amount</th>
                            <th>Installment</th>
                            <th>Balance</th>
                            <th>Payment</th>

                        </tr>
                    </thead>
                    <tbody>



                        <%                            try {

                                Iterator iterator = uniqueResult.getMemberses().iterator();
                                while (iterator.hasNext()) {

                                    Members next = (Members) iterator.next();

                                    Iterator iterator1 = next.getLoans().iterator();

                                    String memberNo = next.getMemberNo();
                                    String nameWithInitials = next.getNameWithInitials();

                                    while (iterator1.hasNext()) {

                                        Loan next1 = (Loan) iterator1.next();

                                        if (next1.getStatus().equals("Unpaid") && next1.getIsActive().equals("Active") && next1.getIsAprove().equals("Approve")) {

                                            Double loanAmount = next1.getLoanAmount() + next1.getLoanInterest();
                                            Integer idLoan = next1.getIdLoan();
                                            Double loanInstallment = next1.getLoanInstallment();
                                            String repaymentDay = next1.getRepaymentDay();
                                            String contractNo = next1.getContractNo();
                                            double sum = 0;
                                            Iterator iterator2 = next1.getRepayments().iterator();
                                            while (iterator2.hasNext()) {

                                                Repayment next2 = (Repayment) iterator2.next();

                                                if (next2.getIsActive().equals("Active")) {
                                                    sum += next2.getPaidAmount();

                                                }

                                            }

                                            double balance = loanAmount - sum;


                        %>

                        <tr>


                            <td><%= memberNo%></td>
                            <td cenDay ="<%= repaymentDay%>" ><%= nameWithInitials%></td>
                            <td idLoan = "<%= idLoan%>"><%= contractNo%></td>
                            <td><%= loanAmount%></td>
                            <td><%= loanInstallment%></td>
                            <td><%= balance%></td>
                            <td><input type="text" name="Paid" class="form-control paid countable" ></td>

                        </tr>




                        <%   }

                                    }

                                }
                                sesss.close();

                            } catch (Exception e) {

                                out.write("" + e);
                                e.printStackTrace();

                            }


                        %>




                    </tbody>
                </table>

                <!--<div style="height: 10px;"></div>-->

            </div>
            <div class="form-group text-right">
                <!--<div style="height: 10px;"></div>-->
                <input type="reset" value="Reset" name="Reset" class="btn btn-danger " >
                <input type="submit" value="Save" name="submit" class="btn btn-primary " id="CenterFilter">
            </div>

            <!--</form>-->	

        </div>
    <!--</div>-->

<!--</div>-->


<script>

    //--------------getData from Table

    $("#CenterFilter").click(function () {

        $("#CenterFilter").attr("disabled", "disabled");

        var table = $("table tbody");
        jsonObject = [];

        var tabletotal = 0;


        table.find("tr").each(function (i) {

            var $tds = $(this).find("td");

            repayment = $tds.eq(4).text();
            Loan = $tds.eq(3).text();
            Paid = $tds.eq(6).find("input").val();
            acDay = $tds.eq(1).attr("cenDay");
            idLoan = $tds.eq(2).attr("idLoan");



            if (!isNaN(Paid) && Paid.length !== 0) {

                tabletotal += parseFloat(Paid);
            }

            item = {};
            item ["repayment"] = repayment;
            item ["Paid"] = Paid;
            item ["acDay"] = acDay;
            item ["idLoan"] = idLoan;
            item ["Loan"] = Loan;
            //get sum of html column
            jsonObject.push(item);





        });

        var json = JSON.stringify(jsonObject);

        swal({
            title: "Payment Total for "+$("#centername").text()+" : " + tabletotal,
            text: "Are you sure to continue",
            icon: "warning",
            buttons: true,
            dangerMode: true,
        })
                .then((willDelete) => {
                    if (willDelete) {
                        $.ajax({

                            method: "POST",
                            url: "../AddRepaymentALLAJAX",
                            data: {json: json},

                            success: function (res) {



                                if (res === "ok") {



                                    $("#saveDone").modal({

                                        keyboard: false


                                    });
                                    $("table").find("tr:gt(0)").remove();
                                } else {

                                    $("#wentWrong").modal();

                                }

                            }


                        });


                    } else {
                        swal("You must check again");
                        $("#CenterFilter").removeAttr("disabled", "disabled");
                    }
                });



    });

    function sortTable(table, order) {
        var asc = order === 'asc',
                tbody = table.find('tbody');

        tbody.find('tr').sort(function (a, b) {
            if (asc) {
                return $('td:first', a).text().localeCompare($('td:first', b).text());
            } else {
                return $('td:first', b).text().localeCompare($('td:first', a).text());
            }
        }).appendTo(tbody);
    }

    sortTable($('#repayTable'), 'asc');


</script>



<jsp:include page="/Modals.jsp"/>
<jsp:include page="/footer.jsp"/>
