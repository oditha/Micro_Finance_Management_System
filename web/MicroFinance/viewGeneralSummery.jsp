<%@page import="ORM.Staff"%>
<%@page import="Srcs.PoolManager"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="ORM.Center"%>
<%@page import="org.hibernate.Criteria"%>

<%@page import="org.hibernate.Session"%>
<%
    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }
    PageTitleSet.getTitle().setPAGE_TITLE("Genaral Summary");

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


<!--<div class="card">
    <div class="card-block">-->
        <div class="container">
            <div class="row">	



                <div class="col-md-3">
                    <div class="form-group">
                        <label for="formGroupExampleInput">Filter by Center</label>
                        <select class="form-control" id="center" name="center">
                            <option>Select</option>
                            <%                                
                                
                                Session se = PoolManager.getSessionFactory().openSession();
                                
                                Criteria c = se.createCriteria(Center.class);
                                
                                c.add(Restrictions.eq("isActive", "Active"));
                                c.add(Restrictions.eq("isApprove", "Approve"));

                                List<Center> l = c.list();

                                for (Center elem : l) {%>


                            <option idCenter="<%= elem.getIdCenter()%>"><%= elem.getCenterNo() + " - " + elem.getCenterName()%></option>


                            <%    }
                                se.close();
                            %>

                        </select>
                    </div>

                </div>


                <div class="col-md-3">



                    <div class="form-group">
                        <label for="formGroupExampleInput">Filter by Executive</label>
                        <select class="form-control" id="executive" name="executive">
                            <option>Select</option>

                            <%                                try {

                                    Session sess = PoolManager.getSessionFactory().openSession();
                                    Criteria cr = sess.createCriteria(Staff.class);
                                    cr.add(Restrictions.eq("isActive", "Active"));
                                    cr.add(Restrictions.eq("position", "Executive"));

                                    List<Staff> list = cr.list();

                                    for (Staff stf : list) {

                            %>


                            <option value="<%=stf.getIdStaff()%>"><%=stf.getNameWithinitials()%></option>


                            <%

                                    }

                                    sess.close();

                                } catch (Exception e) {
                                    e.printStackTrace();

                                }

                            %>
                        </select>
                    </div>




                </div>


            </div>

        </div>
        <hr>
        <!--<div style="height: 10px"></div>-->
        <div class="container">
            <div class="row">



                <div class="col-md-3">
                    <div class="form-group">
                        <label for="formGroupExampleInput">Total Active Members</label>
                        <input type="text" style="background-color: white" class="form-control" id="activemembers" placeholder="Total Active Members" name="activemembers" readonly="">

                    </div>
                    <div class="form-group">
                        <label for="formGroupExampleInput">Active Loan Amount</label>
                        <input type="text" style="background-color: white" class="form-control" id="activeloans" placeholder="Active Loan Amount" name="activeLoan" readonly="">

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
                        <input class="form-control" style="background-color: white" type="text" value="" id="arrears" name="arrears" placeholder="Total Arrears" readonly="">


                    </div>
                    <div class="form-group">
                        <label for="formGroupExampleInput">Expired Arrears</label>
                        <input class="form-control" style="background-color: white" type="text" value="" id="Expire" 
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
<!--<div style="height: 10px"></div>-->

<div id="accordion" role="tablist" aria-multiselectable="true">
    <div class="card">
        <div class="card-header text-right" role="tab" id="headingOne">

            <a class="btn btn-primary btn-sm" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                Members List
            </a>

        </div>

        <div id="collapseOne" class="collapse " role="tabpanel" aria-labelledby="headingOne">
            <div class="card-block">

                <div class="container">
                    <div class="row">	

                        <div class="col-md-3">
                            <form action="action">
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Filter By Type</label>
                                    <select class="form-control" id="MemFilter">
                                        <option>Select</option>
                                        <option>ALL Members</option>
                                        <option>Not Paid Members</option>
                                        <option>Under Payment Members</option>
                                        <option>Over Payment Members</option>
                                        <option>Arrears Members</option>
                                        <option>Expired Members</option>
                                    </select>

                                    <input type="text" id="centerID" name="Center ID" hidden="" >

                                    <!--<div class="containerfluid text-right" style="padding-top: 10px;"><input type="submit" value="Filter" name="Search" class="btn btn-primary text-right btn-sm "></div>-->

                                </div>
                            </form>
                        </div>




                    </div>

                </div>
                <hr>
                <div class=" table-responsive "> 
                    <table id="tbl"></table>
                    <table class="table table-stripped" id="tableView">
                        <thead>
                            <tr>

                                <th>#</th>
                                <th>Member ID</th>
                                <th>Member Name</th>


                                <th>Loan Amount</th>
                                <th>Contract No</th>
                                <th>Total Paid</th>



                                <th>Balance</th>



                            </tr>
                        </thead>
                        <tbody>


                        </tbody>

                        <tfoot>
                            <tr>
                                <td><div></div></td>
                                <td><div></div></td>
                                <td><div></div></td>
                                <td id="" style="color: red"><input type="text" disabled="" class="text-right" id="loanamount" Style="text-align:left; color:green; width: 100px"></td>
                                <td><div></div></td>

                                <td  id="" style="color: green"><input type="text" disabled="" class="text-right"id="Totalpaid" Style="text-align:left; color:green; width: 100px"></td>
                                <td  id="" style="color: green"><input type="text" disabled="" class="text-right"id="balance" Style="text-align:left; color:green; width: 100px"></td>
                            </tr>
                        </tfoot>
                    </table>
                    <!--<div style="height: 10px;"></div>-->




                </div>




            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
       
       $("input[type=text]").val("");
       
    });
    $("#center").change(function () {

        var Center = $("#center").find(":selected").text();

        if (Center !== "Select") {

            $("#executive").attr("disabled", true);
            $("#executive").val("Select");

            var idCenter = $("#center").find(":selected").attr("idCenter");
            $("#centerID").val(idCenter)
            $.ajax({
                metod: "POST",
                url: "../ViewGenaralSummery",
                data: {idCenter: idCenter},
                success: function (res) {
      
                    if (res !== "error") {
                        var ja = JSON.parse(res);

                        for (var i = 0; i < ja.length; i++) {

                            var activemembers = ja[i].activemembers;
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

                   

                        $("#activemembers").val(activemembers);
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
        } else {

            $("#executive").attr("disabled", false);
        }


    });

    $("#executive").change(function () {

        var executive = $("#executive").find(":selected").text();

        if (executive !== "Select") {

            $("#Center").attr("disabled", true);
            $("#Center").val("Select");

            var executiveid = $("#executive").find(":selected").val();
            //$("#centerID").val(idCenter)
            $.ajax({
                metod: "POST",
                url: "../ViewGenaralSummeryExecutiveFilter",
                data: {executiveid: executiveid},
                success: function (res) {
      
                    if (res !== "error") {
                        var ja = JSON.parse(res);

                        for (var i = 0; i < ja.length; i++) {

                            var activemembers = ja[i].activemembers;
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
                        


                        $("#activemembers").val(activemembers);
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
        } else {

            $("#executive").attr("disabled", false);
        }


    });








//-------------------------Load Members-----------------------------------------    

    $("#MemFilter").change(function () {

        var type = $("#MemFilter").find(":selected").text();
        var Executiveid = $("#executive").find(":selected").val();
        var IDCenter = $("#centerID").val();
        if (type === "Select") {

            $("table").find("tr:gt(0)").remove();

        } else {

            if ($("#center").find(":selected").text() === 'Select') {
           //     alert("khg");
                $.ajax({
                    method: "post",
                    url: "../ViewGenaralSummaryMembersExecutivefilter",
                    data: {type: type, idCenter: IDCenter, Executiveid: Executiveid},
                    success: function (res) {


                        if (res !== "error") {

                            var json = JSON.parse(res);

                            if ($.fn.dataTable.isDataTable('#tableView')) {
                                table = $('#tableView').DataTable();
                                table.destroy();
                            }


                            $("#tableView").DataTable({
                                data: json,
                                columns: [
                                    {data: 'Count'},
                                    {data: 'MemberNo'},
                                    {data: 'MemberNAme'},
                                    {data: 'totalAmount'},
                                    {data: 'ContractNo'},
                                    {data: 'totalPaid'},
                                    {data: 'remaningAmount'}
                                ]

                            });


                            var table = $('#tableView').DataTable();
                            var sum = table.column(3).data().sum();
                            var sum1 = table.column(5).data().sum();
                            var sum2 = table.column(6).data().sum();




                            $('#balance').val(sum2 + ".00");
                            $('#loanamount').val(sum + ".00");
                            $('#Totalpaid').val(sum1 + .00);

                        } else {

                            $("#wentWrong").modal();

                        }

                    }

                });
            } else {


                $.ajax({
                    method: "post",
                    url: "../ViewGenaralSummaryMembers",
                    data: {type: type, idCenter: IDCenter},
                    success: function (res) {


                        if (res !== "error") {

                            var json = JSON.parse(res);

                            if ($.fn.dataTable.isDataTable('#tableView')) {
                                table = $('#tableView').DataTable();
                                table.destroy();
                            }


                            $("#tableView").DataTable({
                                data: json,
                                columns: [
                                    {data: 'Count'},
                                    {data: 'MemberNo'},
                                    {data: 'MemberNAme'},
                                    {data: 'totalAmount'},
                                    {data: 'ContractNo'},
                                    {data: 'totalPaid'},
                                    {data: 'remaningAmount'}
                                ]

                            });


                            var table = $('#tableView').DataTable();
                            var sum = table.column(3).data().sum();
                            var sum1 = table.column(5).data().sum();
                            var sum2 = table.column(6).data().sum();




                            $('#balance').val(sum2 + ".00");
                            $('#loanamount').val(sum + ".00");
                            $('#Totalpaid').val(sum1 + .00);

                        } else {

                            $("#wentWrong").modal();

                        }

                    }

                });



            }








        }



    });

//    $(document).ready(function () {
//
//        $("#tableView").DataTable();
//
//    });

</script>




<jsp:include page="/footer.jsp"/>
