<%-- 
    Document   : regStaff
    Created on : Nov 21, 2017, 10:42:11 PM
    Author     : iamarshrx
--%>
<%@page import="Srcs.PoolManager"%>
<%@page import="ORM.CenterHasStaff"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="ORM.Center"%>
<%@page import="ORM.Staff"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="ORM.Branch"%>
<%@page import="org.hibernate.Session"%>

<%@page import="Singleton.PageTitleSet"%>
<%

    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }
    PageTitleSet.getTitle().setPAGE_TITLE("Center Details");

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
    $('#collapseOne').collapse("hide");


</script>
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

<div id="accordion" role="tablist" aria-multiselectable="true">
    <div class="card">
        <div class="card-header text-right" role="tab" id="headingOne">

            <a class="btn btn-primary btn-sm" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                +Add Center
            </a>

        </div>

        <div id="collapseOne" class="collapse " role="tabpanel" aria-labelledby="headingOne">
            <div class="card-block">


                <form action="../AddCenterServlet" id="myForm" method="POST">
                    <div class="container">
                        <div class="row">



                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Select Branch</label>
                                    <select class="form-control" id="selectBranch" onchange="select()" name="branch">
                                        <option>Select</option>
                                        <%                                            Session s = PoolManager.getSessionFactory().openSession();
                                            Criteria cr = s.createCriteria(Branch.class);
                                            cr.add(Restrictions.eq("isActive", "Active"));
                                            List<Branch> list = cr.list();
                                            for (Branch b : list) {%>


                                        <option><%= b.getBranchNo() + " - " + b.getBranchName()%></option>  


                                        <%   }
                                            s.close();

                                        %>

                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Select Executive</label>
                                    <select class="form-control" id="exampleSelect1" name="Executive">
                                        <option>Select</option>

                                        <%                                            Session s1 = PoolManager.getSessionFactory().openSession();
                                            Criteria cr1 = s1.createCriteria(Staff.class);
                                            cr1.add(Restrictions.eq("isActive", "Active"));
                                            List<Staff> st = cr1.list();

                                            for (Staff stf : st) {%>


                                        <option><%= stf.getNic() + " - " + stf.getNameWithinitials()%></option>

                                        <% }
                                            s1.close();
                                        %>


                                    </select>
                                </div>



                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Center Code</label>
                                    <!--<div style="height: 6px"></div>-->
                                    <input type="text" style="background-color: white" class="form-control" id="centercode" placeholder="Enter Center code" name="Centercode" readonly="">
                                </div>
                                <div class="form-group">

                                    <label for="formGroupExampleInput">Center Name</label>
                                    <!--<div style="height: 6px"></div>-->
                                    <input required="" class="form-control" type="text" value="" id="address1" name="CenterName" placeholder="Enter Center Name">

                                </div>


                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Center Day</label>
                                    <select class="form-control" id="CenterDay" name="CenterDay">
                                        <option>Monday</option>
                                        <option>Tuesday</option>
                                        <option>Wednesday</option>
                                        <option>Thursday</option>
                                        <option>Friday</option>
                                        <option>Saturday</option>
                                        <option>Sunday</option>

                                    </select>

                                </div>

                                <div class="form-group">
                                    <label for="formGroupExampleInput">Center Time</label>
                                    <!--<div style="height: 6px"></div>-->
                                    <input required="" class="form-control" type="time"  id="contact1" name="time" placeholder="hh:mm AM/PM">
                                </div>
                                <div class="form-group text-right">
                                    <!--<div style="height: 10px;"></div>-->
                                    <input type="reset" value="Reset" name="Reset" class="btn btn-danger ">
                                    <input type="submit" value="Save" name="submit" class="btn btn-primary ">
                                </div>

                            </div>

                        </div>
                    </div>
                </form>	

            </div>
        </div>
    </div>
</div>
<div id="accordion" role="tablist" aria-multiselectable="true">
    <div class="card">
        <div class="card-header text-right" role="tab" id="headingOne">

            <a class="btn btn-primary btn-sm" data-toggle="collapse" data-parent="#accordion" href="#collapseOne1" aria-expanded="true" aria-controls="collapseOne1">
                +Change Center
            </a>

        </div>

        <div id="collapseOne1" class="collapse " role="tabpanel" aria-labelledby="headingOne">
            <div class="card-block">


                <div class="container">
                    <form id="chngcenter">
                        <div class="row">


                            <div class="col-md-3">

                                <div class="form-group">
                                    <label for="formGroupExampleInput">Select Executive </label><br>
                                    <select class="form-control exe1" id="exe" name="Executive">
                                        <option value="Select">Select</option>
                                        <%
                                            try {

                                                Session sess = PoolManager.getSessionFactory().openSession();
                                                Criteria cr2 = sess.createCriteria(Staff.class);
                                                cr2.add(Restrictions.eq("isActive", "Active"));
                                                //cr2.add(Restrictions.eq("position", "Executive"));

                                                List<Staff> list2 = cr2.list();

                                                for (Staff stf : list2) {

                                        %>


                                        <option value="<%=stf.getIdStaff()%>"><%=stf.getName()%></option>


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
                            <div class="col-md-4">

                                <div class="form-group">
                                    <label for="formGroupExampleInput">Select Center</label><br>
                                    <select class="form-control cnt" id="exeCenter" name="centers" multiple="multiple">


                                    </select>

                                </div>

                            </div>
                            <div class="col-md-3">

                                <div class="form-group">
                                    <label for="formGroupExampleInput">Select Executive to change</label>
                                    <br> <select class="form-control exe2" id="Exe2" name="Exe2">

                                        <option value="Select">Select</option>
                                        <%                                        try {

                                                Session sess = PoolManager.getSessionFactory().openSession();
                                                Criteria cr2 = sess.createCriteria(Staff.class);
                                                cr2.add(Restrictions.eq("isActive", "Active"));
                                                cr2.add(Restrictions.eq("position", "Executive"));

                                                List<Staff> list2 = cr2.list();

                                                for (Staff stf : list2) {

                                        %>


                                        <option value="<%=stf.getIdStaff()%>"><%=stf.getName()%></option>


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
                             
                                    <div class="col-md-2">
                                        
                                        <a class="btn btn-primary" style="padding-top: 10px" id="cng">Change</a>
                                        
                                    </div>
                                    
                        </div>
                    </form>
                </div>





            </div>
        </div>
    </div>
</div>

<!--Table Section-->

<!--<div style="height: 10px;"></div>-->
<div class="card">

    <div class="card-header">
        <p>List All </p>
    </div>
    <div class="card-block">

        <div class=" table-responsive ">          
            <table class="table table-stripped" id="tableCenters">
                <thead>
                    <tr>

                        <th>Code</th>
                        <th>Name</th>
                        <th>Day</th>
                        <th>Time</th>
                        <th>Handle by</th>


                        <th>Members</th>

                        <th>Options</th>


                    </tr>
                </thead>
                <tbody>


                    <%                    int i = 1;

                        Session ss = PoolManager.getSessionFactory().openSession();
                        Criteria crr = ss.createCriteria(Center.class);
                        crr.add(Restrictions.eq("isActive", "Active"));
                        crr.add(Restrictions.eq("isApprove", "Approve"));

                        List<Center> li = crr.list();

                        for (Center el : li) {%>

                    <tr>

                        <td><%= el.getCenterNo()%></td>
                        <td><%= el.getCenterName()%></td>
                        <td><%= el.getCenterDay()%></td>
                        <td><%= el.getCentertime()%></td>
                        <td><%

                            Iterator its = el.getCenterHasStaffs().iterator();

                            while (its.hasNext()) {
                                CenterHasStaff next = (CenterHasStaff) its.next();
                                out.print(next.getStaff().getNameWithinitials());
                            }


                            %></td>

                        <td><%= el.getMemberses().size()%></td>



                        <td><button type="button" id="modal" class="btn btn-info btn-sm bt-mod btn-opn" idCenter="<%= el.getIdCenter()%>">Modify</button></td>
                    </tr>

                    <%  }

                        ss.close();

                    %>
                </tbody>
            </table>

            <!--<div style="height: 10px;"></div>-->

        </div>
    </div>
</div>

<script>

    function select() {

        var BranchNO = $('#selectBranch').find(":selected").text();

        if (BranchNO !== 'Select') {

            $.ajax({

                url: '../GenCenterIDServlet',
                data: {branchNo: BranchNO},

                success: function (response) {

                    $('#centercode').attr('value', response);

                }
            });

        }

    }

    $(document).ready(function () {
//        $('#tableCenters').DataTable();
        table = $('#tableCenters').DataTable({
            dom: 'Bfrtip',
            buttons: [
                'copy', 'excel', 'pdf', 'print', 'colvis'
            ]
        });

        table.buttons().container()
                .appendTo('#example_wrapper .col-md-6:eq(0)');

    });


    $('.bt-mod').click(function () {

        var CenterID = $(this).attr('idCenter');


        $.ajax({

            url: '../CentersViewAJAX',
            data: {centerID: CenterID},

            success: function (responseText) {

                var ja = JSON.parse(responseText);
                for (var i = 0; i < ja.length; i++) {

                    var cenid = ja[i].cenid;
                    var name = ja[i].name;
                    var no = ja[i].no;
                    var day = ja[i].day;
                    var time = ja[i].time;
                    var exname = ja[i].exname;
                    var idCenter = ja[i].idCenter;



                }


                $('#cenid').attr('value', cenid);
                $('#name').attr('value', name);
                $('#no').attr('value', no);
                $('#day').attr('value', day);
                $('#timezz').attr('value', time);
                $("#exname").val(exname);
                $("#idCenter").val(idCenter);

                $(document).ready(function () {
                    $(".btn-opn").click(function () {
                        $("#exampleModal").modal();
                    });
                });

            }


        });


    });



    $(document).ready(function () {
        //  $("select").select2({ width: '100%' });  
        $('.exe1').select2({
            
            width:'100%',
            
        });
        $('.exe2').select2({
            
            width:'100%',
            
        });
        $('.cnt').select2({
            
            width:'100%',
            
        });

    });
    $(document).ready(function () {
        $('#cng').click(function () {

            //  var CenterID = $(this).attr('idCenter');

            var frm = $('#chngcenter').serialize();
            $.ajax({
                method: 'POST',
                url: '../ChangeCenterServlet',
                data: $('#chngcenter').serialize(),

                success: function (responseText) {




                    if (responseText === 'ok') {
                        swal({
                            title: "Good job!",
                            text: "You chave successfully changed centers",
                            icon: "success",
                            button: " Aww yiss!",
                        });

                        $(".exe1").val("Select").change();
                        $(".exe2").val("Select").change();

                        $('.cnt option').remove();

                    } else {


                        swal("Oops", "Something went wrong!", "error")



                    }




                }


            });


        });


    });


    $(document).ready(function () {
        $(".exe1").change(function () {

            var stfid = $(this).val();


            $('.cnt option').remove();

            if (stfid === 'Select') {

                $('.cnt option').remove();
            } else {


                $.ajax({

                    url: '../LoadExecutiveCenteradd',
                    data: {stfid: stfid},

                    success: function (responseText) {

                        var json = JSON.parse(responseText);

                        for (var i = 0; i < json.length; i++) {

                            idcenter = json[i].idcenter;
                            centername = json[i].centername;
                            centerno = json[i].centerno;


                            $('.cnt').append("<option  value=\"" + idcenter + "\"   >" + centerno + "-" + centername + "</option>");



                        }










                    }


                });


            }











        });
    });

</script>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">View Center Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">

                <form action="../UpdateCentersServlet" method="POST">
                    <div class="row">
                        <div class="col-md-6">

                            <div class="form-group">
                                <label for="formGroupExampleInput">Center Code</label>
                                <input type="text" value="" class="form-control" id="no" placeholder="Center Code" name="branchcode" autofocus="" required="">
                                <!--<input type="text" value="" class="form-control" id="no" placeholder="Center Code" name="branchcode" autofocus="" required="">-->
                                <input hidden="" type="text" value="" class="form-control" id="idCenter" placeholder="Center Code" name="idCenter" autofocus="" required="">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Center Name</label>
                                <input type="text" class="form-control" id="name" placeholder="Center Name" name="CenterName" required="">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Center Day</label>
                                <input maxlength="10" class="form-control" type="tel"  id="day" name="CenterDay" placeholder="Center Day" required="">
                            </div>

                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="formGroupExampleInput">Center Time</label>

                                <input class="form-control" type="time" value="" id="timezz" name="time" placeholder="Center Time" required="">


                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput"> Handled by</label>
                                <select class="form-control yourExcludeClass" id="exname" name="Executive">
                                    <option>Select</option>

                                    <%                                        Session s1z = PoolManager.getSessionFactory().openSession();
                                        Criteria crz = s1z.createCriteria(Staff.class);
                                        cr1.add(Restrictions.eq("isActive", "Active"));
                                        List<Staff> stt = crz.list();

                                        for (Staff stft : stt) {%>


                                    <option><%= stft.getNic() + " - " + stft.getNameWithinitials()%></option>

                                    <% }
                                        s1z.close();
                                    %>


                                </select>
                            </div>
                            <div class="form-group">

                                <input type="text" hidden="" class="form-control" id="cenid" placeholder="Enter address line 2" name="cenid">
                            </div>

                        </div>


                    </div>

            </div>
            <div class="modal-footer">

                <input type="submit" class="btn btn-danger btn-sm" name="btn" value="Delete">
                <input type="submit" class="btn btn-primary btn-sm" name="btn" value="Update">
            </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/footer.jsp"/>
