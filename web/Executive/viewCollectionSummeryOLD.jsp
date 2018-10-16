<%@page import="java.util.Iterator"%>
<%@page import="ORM.CenterHasStaff"%>
<%@page import="Srcs.PoolManager"%>
<%@page import="ORM.Staff"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="ORM.Center"%>
<%@page import="org.hibernate.Criteria"%>

<%@page import="org.hibernate.Session"%>
<%@page import="Singleton.dateFormat"%>

<%
    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }
    PageTitleSet.getTitle().setPAGE_TITLE("Collection Summery");

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/header.jsp"/>
<%@page import="Singleton.PageTitleSet"%>
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
<div style="height: 10px"></div>

<div style="height: 10px;"></div>
<div class="card">
    <div class="card-block">
        <div class="container">
            <div class="row">	

                <div class="col-md-4">

                    <div class="form-group">
                        <label for="formGroupExampleInput">Filter by Center</label>
                        <select class="form-control center" id="center" name="center" onchange="select()">
                            <option>Select</option>
                            <%                                          
    
    
                                Session se =PoolManager.getSessionFactory().openSession();
                                
                                Criteria cr=se.createCriteria(Staff.class);
                                cr.add(Restrictions.eq("idStaff", session.getAttribute("id")));
                                
                             Staff uq=(Staff)   cr.uniqueResult();
                                
                             
                           Iterator it=  uq.getCenterHasStaffs().iterator();
                           
                           
                           while(it.hasNext()){
                           
                           CenterHasStaff elem=(CenterHasStaff)it.next();
                           
                           %>


                            <option idCenter="<%= elem.getCenter().getIdCenter()%>"><%= elem.getCenter().getCenterNo() + " - " + elem.getCenter().getCenterName()%></option>


                            <%
                           
                           
                           
                           }
                           
                           
                              se.close();
                              

                            %>

                        </select>
                    </div>
                </div>
                <div class="col-md-4">

                    <div class="form-group">
                        <label for="formGroupExampleInput">Filter by Executive</label>
                        <select class="form-control" id="exe" name="Executive">
                            <option>Select</option>

                            <%                                            Session s1 = PoolManager.getSessionFactory().openSession();
                                Criteria cr1 = s1.createCriteria(Staff.class);
                                cr1.add(Restrictions.eq("isActive", "Active"));
                                
                                cr.add(Restrictions.eq("idStaff", session.getAttribute("id")));
                                
                                 Staff stf=(Staff)   cr.uniqueResult();
                                
                             
                                
                              

                                %>


                            <option idStaff ="<%= stf.getIdStaff()%>" ><%= stf.getNic() + " - " + stf.getNameWithinitials()%></option>

                            <% 
                                s1.close();
                            %>


                        </select>
                        <!--<div class="containerfluid text-right" style="padding-top: 10px;"><input type="submit" value="Filter" name="Search" class="btn btn-primary text-right btn-sm "></div>-->

                    </div>
                </div>
                <div class="col-md-4">

                    <div class="form-group">
                        <label for="formGroupExampleInput">Select Date</label>
                        <div style="height: 6px"></div>
                        <input type="date" class="form-control" id="getDate" placeholder="Enter Member ID or NIC" name="memberid" value="<%= dateFormat.DateFullCurrent()   %>">
                        <br>
                           <div class="form-check">
<!--                        <label class="form-check-label">
                            <input type="checkbox" class="form-check-input" value="" id="viewall">View All
                        </label>-->
                    </div>

                        
                        
                        <div class="containerfluid text-right" style="padding-top: 10px;"><input type="submit" value="Filter" name="Search" id="filter" class="btn btn-primary text-right btn-sm "></div>

                    </div>


                 
                </div>




            </div>

        </div>
        <hr>
        <div class="container">
            <div class="row">



                <div class="col-md-3">
                    <div class="form-group">
                        <label for="formGroupExampleInput">Total Collection</label>
                        <input type="text" style="background-color: white" class="form-control text-right" id="collection" placeholder="Total Collection" name="collection" readonly="">

                    </div>


                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="formGroupExampleInput">Total NP Collection</label>
                        <input type="text" style="background-color: white" class="form-control text-right" id="npcollection" placeholder="Total NP Collection" name="npcollection" readonly="">
                    </div>

                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="formGroupExampleInput">Total Member Fees</label>
                        <input class="form-control text-right" style="background-color: white" type="text" value="" id="fees" name="FEES" placeholder="Total Member Fees" readonly="">


                    </div>


                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="formGroupExampleInput" hidden>Total Loan Issued</label>
                        <input class="form-control " style="background-color: white" type="text" value="" id="loans" name="loans" placeholder="Total Loan Issued" readonly="" hidden>


                    </div>


                </div>

            </div>
        </div>

    </div>

</div>

<script>

//--------------------------Search Data-----------------------------------------


    $("#filter").click(function () {
        
        
        if ($('#viewAll').attr('checked',true)) {
    
    
    
    var center = $("#center").find(":selected").text();
        var exe = $("#exe").find(":selected").text();
        var day = $("#getDate").val();



        if (center === "Select") {

            if (exe !== "Select") {

                //Search with exective
                var staff = $("#exe").find(":selected").attr("idStaff");

                $.ajax({
                    method: "POST",
                    url: "../ViewCenterCollectionAll",
                    data: {staffID: staff,  type: "exe"},
                    success: function (data) {

                        var js = JSON.parse(data);

                        var collection = js[0].collection;
                        var npcollection = js[0].notpaid;
                        var fees = js[0].memberFee;
                        var loans = js[0].totalLoan;

                        $("#collection").val(collection);
                        $("#npcollection").val(npcollection);
                        $("#fees").val(fees);
                        $("#loans").val(loans);

                    }

                });
            }
        } else if (exe === "Select") {

            if (center !== "Select") {

                var Cen = $("#center").find(":selected").attr("idCenter");

                $.ajax({
                    method: "POST",
                    url: "../ViewCenterCollectionAll",
                    data: {CenterID: Cen,  type: "center"},
                    success: function (data) {

                        if (data !== "error") {

                            var js = JSON.parse(data);

                            var collection = js[0].collection;
                            var npcollection = js[0].notpaid;
                            var fees = js[0].memberFee;
                            var loans = js[0].totalLoan;

                            $("#collection").val(collection);
                            $("#npcollection").val(npcollection);
                            $("#fees").val(fees);
                            $("#loans").val(loans);

                        } else {

                            $("#wentWrong").modal();

                        }



                    }

                });

            }
        }
    
    
    
    
    
    
    
    
}else{
        

        var center = $("#center").find(":selected").text();
        var exe = $("#exe").find(":selected").text();
        var day = $("#getDate").val();



        if (center === "Select") {

            if (exe !== "Select") {

                //Search with exective
                var staff = $("#exe").find(":selected").attr("idStaff");

                $.ajax({
                    method: "POST",
                    url: "../ViewCenterCollection",
                    data: {staffID: staff, date: day, type: "exe"},
                    success: function (data) {

                        var js = JSON.parse(data);

                        var collection = js[0].collection;
                        var npcollection = js[0].notpaid;
                        var fees = js[0].memberFee;
                        var loans = js[0].totalLoan;

                        $("#collection").val(collection);
                        $("#npcollection").val(npcollection);
                        $("#fees").val(fees);
                        $("#loans").val(loans);

                    }

                });
            }
        } else if (exe === "Select") {

            if (center !== "Select") {

                var Cen = $("#center").find(":selected").attr("idCenter");

                $.ajax({
                    method: "POST",
                    url: "../ViewCenterCollection",
                    data: {CenterID: Cen, date: day, type: "center"},
                    success: function (data) {

                        if (data !== "error") {

                            var js = JSON.parse(data);

                            var collection = js[0].collection;
                            var npcollection = js[0].notpaid;
                            var fees = js[0].memberFee;
                            var loans = js[0].totalLoan;

                            $("#collection").val(collection);
                            $("#npcollection").val(npcollection);
                            $("#fees").val(fees);
                            $("#loans").val(loans);

                        } else {

                            $("#wentWrong").modal();

                        }



                    }

                });

            }
        }

    }
    });

//------------------------Combobox Function-------------------------------------

    $(document).ready(function () {

        $("#center").change(function () {

            var centerName = $("#center").find(":selected").text();

            if (centerName !== "Select") {

                $("#exe").attr("disabled", true);
                $("#exe").val("Select");

            } else {

                $("#exe").attr("disabled", false);


            }


        });

    });
$(document).ready(function() {
    $('.center').select2({
            
            width:'100%',
            
        });
});
</script>



<jsp:include page="/footer.jsp"/>
