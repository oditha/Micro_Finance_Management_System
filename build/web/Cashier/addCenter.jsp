
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="ORM.Members"%>
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


                <form action="../AddCenterServletExecutive" id="myForm" method="POST">
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
                                    <select class="form-control" id="exampleSelect1" name="Executive" readonly>
                                        <option>Select</option>

                                        <%
                                            Session s1 = PoolManager.getSessionFactory().openSession();
                                            Criteria cr1 = s1.createCriteria(Staff.class);
                                            cr1.add(Restrictions.eq("isActive", "Active"));
                                            cr1.add(Restrictions.eq("idStaff", session.getAttribute("id")));
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
                                    <div style="height: 6px"></div>
                                    <input type="text" style="background-color: white" class="form-control" id="centercode" placeholder="Enter Center code" name="Centercode" readonly="">
                                </div>
                                <div class="form-group">

                                    <label for="formGroupExampleInput">Center Name</label>
                                    <div style="height: 6px"></div>
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
                                    <div style="height: 6px"></div>
                                    <input required="" class="form-control" type="time"  id="contact1" name="time" placeholder="hh:mm AM/PM">
                                </div>
                                <div class="form-group text-right">
                                    <div style="height: 10px;"></div>
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

<!--Table Section-->

<!--<div style="height: 10px;"></div>-->
<!--<div class="card">
    <div class="card-block">-->
        <div class=" table-responsive ">          
            <table class="table table-stripped" id="tableCenters">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Code</th>
                        <th>Name</th>
                        <th>Day</th>
                        <th>Time</th>
                        <th>Total Members</th>
                        


                    </tr>
                </thead>
                <tbody>
                    <%
                                            
                                            
                                            
                                            
                                            int i=1;
                        try {

                            Map<String,Integer>hm=new HashMap();
                            
                            System.out.println(hm);
                            Session sess = PoolManager.getSessionFactory().openSession();

                            Criteria cr5 = sess.createCriteria(Staff.class);
                            cr5.add(Restrictions.eq("nic", session.getAttribute("nic").toString()));

                            Staff uq = (Staff) cr5.uniqueResult();
                            
                        Iterator it=    uq.getCenterHasStaffs().iterator();
                        System.out.println(uq.getName());
                        while(it.hasNext()){
                            
                            
                         CenterHasStaff next=(CenterHasStaff)it.next();
                         if(next.getCenter().getIsApprove().equals("Approve") && next.getCenter().getIsActive().equals("Active")){
                         %>
                   
                         <tr>
                             <td><%= i++    %></td>
                             <td><%= next.getCenter().getCenterNo()    %></td>
                             <td><%= next.getCenter().getCenterName()    %></td>
                             <td><%= next.getCenter().getCenterDay()    %></td>
                             <td><%= next.getCenter().getCentertime()    %></td>
                             <td>
                                 <%
                                 
                                Iterator it6= next.getCenter().getMemberses().iterator();
                                 while(it6.hasNext()){
                                     
                                     Members mem=(Members)it6.next();
                                    
                                     if(mem.getIsActive().equals("Active")){
                                         
                                         hm.put(mem.getNic(), mem.getIdMembers());
                                         
                                         
                                     }
                                     
                                     
                                 }
                                 
                                 out.print(hm.size());
                                 %>
                                 
                                 
                                 
                             </td>
                             
                             
                             
                         </tr>
                    
                    
                    
                    
                    
                    <%
                            
                            
                            
                        }
                            
                            
                        }

                            sess.close();

                        } catch (Exception e) {

                            e.printStackTrace();

                        }


                    %>

                </tbody>
            </table>

            <div style="height: 10px;"></div>

        </div>
<!--    </div>
</div>-->

<script>


    $(document).ready(function() {
$('#exampleSelect1').prop('selectedIndex', 1);
    });


    function select() {

        var BranchNO = $('#selectBranch').find(":selected").text();

        if (BranchNO !== 'Select') {

            $.ajax({
                url: '../GenCenterIDServlet',
                data: {branchNo: BranchNO},
                success: function(response) {

                    $('#centercode').attr('value', response);

                }
            });

        }

    }

    $(document).ready(function() {
//        $('#tableCenters').DataTable();
        $('#tableCenters').DataTable({
            dom: 'Bfrtip',
            buttons: [
                'copy', 'excel', 'pdf', 'print', 'colvis'
            ]
        });

        table.buttons().container()
                .appendTo('#example_wrapper .col-md-6:eq(0)');

    });


    $('.bt-mod').click(function() {

        var CenterID = $(this).attr('idCenter');


        $.ajax({
            url: '../CentersViewAJAX',
            data: {centerID: CenterID},
            success: function(responseText) {

                var ja = JSON.parse(responseText);
                for (var i = 0; i < ja.length; i++) {

                    var cenid = ja[i].cenid;
                    var name = ja[i].name;
                    var no = ja[i].no;
                    var day = ja[i].day;
                    var time = ja[i].time;
                    var exname = ja[i].exname;



                }


                $('#cenid').attr('value', cenid);
                $('#name').attr('value', name);
                $('#no').attr('value', no);
                $('#day').attr('value', day);
                $('#timezz').attr('value', time);
                $("#exname").val(exname);

                $(document).ready(function() {
                    $(".btn-opn").click(function() {
                        $("#exampleModal").modal();
                    });
                });

            }


        });


    });



</script>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">View Branch Details</h5>
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
                                <select class="form-control" id="exname" name="Executive">
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
