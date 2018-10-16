<%@page import="ORM.CenterHasStaff"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.hibernate.criterion.Order"%>
<%@page import="Srcs.PoolManager"%>
<%@page import="ORM.Members"%>
<%@page import="ORM.Center"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="ORM.Branch"%>

<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.Session"%>
<%
    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }
    PageTitleSet.getTitle().setPAGE_TITLE("Member Details");

    try {
//        if (!session.getAttribute("UserType").toString().equals("Manager")) {
//
//            response.sendRedirect("/CMC/errorPage/401Unauthorized.html");
//
//        }
    } catch (Exception e) {
    }


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

<div id="accordion" role="tablist" aria-multiselectable="true">
    <div class="card">
        <div class="card-header text-right" role="tab" id="headingOne">

            <a class="btn btn-primary btn-sm" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                +Add Member
            </a>

        </div>

        <div id="collapseOne" class="collapse " role="tabpanel" aria-labelledby="headingOne">
            <div class="card-block">


                <form action="../AddMemberServletts" id="myForm">
                    <div class="container">
                        <div class="row">



                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Select Branch</label>
                                    <select class="form-control" id="branch" name="branch" disabled="" >
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
                                    <label for="formGroupExampleInput">Select Center</label><br>
                                    <select class="form-control" id="center" name="center" onchange="select()">
                                        <option>Select</option>
                                        <%
                                            Session se = PoolManager.getSessionFactory().openSession();
                                            Criteria c = se.createCriteria(Center.class);
                                            c.add(Restrictions.eq("isActive", "Active"));
                                            c.add(Restrictions.eq("isApprove", "Approve"));

                                            List<Center> l = c.list();

                                            for (Center elem : l) {

                                                Iterator it = elem.getCenterHasStaffs().iterator();

                                                while (it.hasNext()) {
                                                    CenterHasStaff ctc = (CenterHasStaff) it.next();

                                                    if (ctc.getStaff().getNic().equals(session.getAttribute("nic"))) {


                                        %>


                                        <option value="<%= elem.getIdCenter()%>"><%= elem.getCenterNo() + " - " + elem.getCenterName()%></option>


                                        <%      }

                                                }
                                            }
                                            se.close();
                                        %>

                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Member ID</label>
                                    <input type="text" style="background-color: white" required="" class="form-control" id="memberid" placeholder="Member ID" name="memberid" >
                                    <input hidden="" type="text" style="background-color: white" required="" class="form-control" id="NO" placeholder="Member ID" name="NO" >
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Group</label>
                                    <input type="number" required="" class="form-control" id="group" placeholder="Enter Group" name="group">
                                </div>

                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="formGroupExampleInput">NIC</label>
                                    <div style="height: 6px"></div>
                                    <input type="text" required="" class="form-control" id="NIC" placeholder="Enter NIC" name="NIC">
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Name with Initials</label>
                                    <div style="height: 6px"></div>
                                    <input class="form-control" required="" type="text" value="" id="namein" name="namein" placeholder="Name with Initials">


                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput"> Full Name</label>
                                    <!--                                    <div style="height: 6px"></div>-->
                                    <input type="text" required="" class="form-control" id="fullname" placeholder="Enter Fullname" name="fullname">
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Date of Birth</label>
                                    <!--<div style="height: 6px"></div>-->
                                    <input type="date" required="" class="form-control" id="dob" placeholder="dob" name="dob">
                                </div>

                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Contact No</label>
                                    <div style="height: 6px"></div>
                                    <input class="form-control" required="" type="text" value="" id="contact" name="contact" placeholder="Enter Contact no">


                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Address Line 1</label>
                                    <div style="height: 6px"></div>
                                    <input required="" class="form-control" type="tel" value="" id="address1" 
                                           placeholder="Enter Address 1" name="address1">
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Address Line 2</label>
                                    <!--<div style="height: 6px"></div>-->
                                    <input required="" class="form-control" type="tel" value="" id="address2" placeholder="Enter Address 1" name="address2">
                                </div>

                                <div class="form-group">
                                    <label for="formGroupExampleInput">City</label>
                                    <!--<div style="height: 6px"></div>-->
                                    <input required="" class="form-control" type="tel" value="" name="city" id="city" placeholder="Enter City">
                                </div>

                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Gardian NIC</label>
                                    <div style="height: 6px"></div>
                                    <input required="" class="form-control" type="text" value="" id="gNIC" name="gNIC" placeholder="Gardian NIC">
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Guardian Name</label>
                                    <div style="height: 6px"></div>
                                    <input required="" class="form-control" type="text"  id="gname" name="gname" placeholder="Enter Guardian Name">
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Guardian DOB</label>
                                    <input required="" type="date" class="form-control" id="gdob" placeholder="Enter Guardian DOB" name="gdob">
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Guardian Occupation</label>
                                    <input required="" type="text" class="form-control" id="gocc" name="gocc" placeholder="Enter Guardian Occupation">
                                </div>
                                <div class="form-group text-right">
                                    <div style="height: 10px;"></div>

                                    <!--<input type="reset" value="Reset" class="btn btn-danger">-->
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


                                        <!--<div class="card">
                                        
                                            <div class="card-block">-->
        <div class=" table-responsive ">          
            <table class="table table-stripped" id="membersTable">
                <thead>
                    <tr>
                        <th>C NO</th>
                        <th>ID</th>
                        <th>NIC</th>
                        <th>Name</th>
                        <th>Contact</th>
                        <th>Center</th>
                        <th>Status</th>
                        <th>Options</th>
                    </tr>
                </thead>
                <tbody>

                    <%                        int i = 1;

                        Session sss = PoolManager.getSessionFactory().openSession();
                        Criteria crr = sss.createCriteria(Members.class);
                        crr.add(Restrictions.eq("aproved", "Approve"));
                        crr.add(Restrictions.eq("isActive", "Active"));
                        crr.addOrder(Order.asc("memberNo"));
                        List<Members> li = crr.list();

                        for (Members elem : li) {%>

                    <tr>
                        <th scope="row"><%= elem.getCenter().getCenterNo()%></th>
                        <td><%= elem.getMemberNo()%></td>
                        <td><%= elem.getNic()%></td>
                        <td><%= elem.getNameWithInitials()%></td>
                        <td><%= elem.getContactNo()%></td>
                        <td><%= elem.getCenter().getCenterName()%></td>

                        <td><%= elem.getIsActive()%></td>
                        <td><button type="button" id="modal" class="btn btn-info btn-sm bt-mod btn-opn" 
                                    idMember="<%= elem.getIdMembers()%>">Modify</button></td>



                    </tr>


                    <%    }

                        sss.close();
                    %>



                </tbody>
            </table>



            <div style="height: 30px;"></div>




        </div>
<!--    </div>
</div>-->


<script>


//    $(document).ready(function () {
//        
//        var BranchNO = $('#branch').find(":selected").text();
//        var CenterNO = $('#center').find(":selected").val();
//        var Center = $('#center').find(":selected").text();
//        var parm = "branchNo="+BranchNO+"&CenterNO="+CenterNO+"&Center="+Center;
//                
//        setInterval(function () {
//            
//            var xmlhttp = new XMLHttpRequest();
//            xmlhttp.onreadystatechange = function () {
//                if (this.readyState == 4 && this.status == 200) {
//
//                    
//
//                    var val = this.responseText;
//
//                    console.log(val)
//
//                    $("#memberid").val(val);
//
//
//
//                }
//            };
//            xmlhttp.open("POST", "../GenMemberIDServlet", true);
//            xmlhttp.setRequestHeader("Content-Type", "application/x-www-from-urlencoded");
//
//            xmlhttp.send(parm);
//
//        }, 1000);
//
//    })


    $(document).ready(function () {
        $('#membersTable').DataTable({
            dom: 'Bfrtip',
            buttons: [
                'copy', 'excel', 'pdf', 'print', 'colvis'
            ]
        });

        table.buttons().container()
                .appendTo('#example_wrapper .col-md-6:eq(0)');

    });

    function select() {
        var BranchNO = $('#branch').find(":selected").text();
        var CenterNO = $('#center').find(":selected").val();
        var Center = $('#center').find(":selected").text();

        var split = Center.split(" - ");

//        alert(split[0]);

        $("#NO").val(split[0]);

        if (BranchNO !== 'Select') {

            $.ajax({

                url: '../GenMemberIDServlet',
                data: {branchNo: BranchNO, CenterNO: CenterNO, Center: Center},
//                

                success: function (response) {
//                    alert("OK");


                    $('#memberid').attr('value', response);

                }
            });

        }

    }

    $('.bt-mod').click(function () {

        var memberID = $(this).attr('idMember');


        $.ajax({

            url: '../MembersViewAJAX',
            data: {memberID: memberID},

            success: function (responseText) {

                var ja = JSON.parse(responseText);
                for (var i = 0; i < ja.length; i++) {

                    var g_occ = ja[i].g_occ;
                    var g_dob = ja[i].g_dob;
                    var g_name = ja[i].g_name;
                    var g_NIC = ja[i].g_NIC;
                    var memcity = ja[i].memcity;
                    var address_2 = ja[i].address_2;
                    var address_1 = ja[i].address_1;
                    var contactNo = ja[i].contactNo;
                    var memdob = ja[i].memdob;
                    var memname = ja[i].memname;
                    var nameint = ja[i].nameint;
                    var NICMem = ja[i].NICMem;
                    var groupID = ja[i].groupID;
                    var memid = ja[i].memid;
                    var id = ja[i].id;
                    var centerID = ja[i].centerID;

                    var parse = moment(memdob, "DD/MM/YYYY").format("YYYY-MM-DD");


                }

                //   alert(memdob);
                $('#g_occ').attr('value', g_occ);
                $('#g_dob').attr('value', g_dob);
                $('#g_name').attr('value', g_name);
                $('#g_NIC').attr('value', g_NIC);
                $('#memcity').attr('value', memcity);
                $('#address_2').attr('value', address_2);
                $('#address_1').attr('value', address_1);
                $('#contactNo').attr('value', contactNo);
                //  $('#memdob').attr('value', memdob);
                $('#memname').attr('value', memname);
                $('#nameint').attr('value', nameint);
                $('#NICMem').attr('value', NICMem);
                $('#groupID').attr('value', groupID);
                $('#memid').attr('value', memid);
                $('#id').attr('value', id);
                $('.id').attr('value', id);
                $("#centerID").val(centerID);
                $("#memdob").val(parse);







                $(document).ready(function () {
                    $(".btn-opn").click(function () {
                        $("#exampleModal").modal();
                    });
                });

            }


        });


    });



    $(document).ready(function () {
        $('#center').select2({

            width: '100%',

        });
    });




    $(document).ready(function () {
        $("#NIC").keyup(function () {

            if ($("#NIC").val().length > 9) {


                $.ajax({

                    url: '../NicValMem',
                    data: {nic: $("#NIC").val()},

                    success: function (responseText) {


                        if (responseText === 'ok') {



                            swal("Oops", "Nic Already Exists", "error").then(() => {
                                $("#NIC").val("");
                            });





                        }

//alert(responseText);

                    }


                });



            }



        });
    });




</script>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">View Member Details</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">

                <form action="../UpdateMemberServlet" method="POST">

                    <div class="row">



                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="formGroupExampleInput" hidden="">Select Branch</label>
                                <input hidden="" type="number" class="form-control" id="id" placeholder="Enter Group" name="id">

                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Select Center</label>
                                <select class="form-control" id="centerID" name="center" onchange="select()">
                                    <option>Select</option>
                                    <%                                            Session ses = PoolManager.getSessionFactory().openSession();
                                        Criteria cs = ses.createCriteria(Center.class);
//                                        cs.add(Restrictions.eq("isActive", "Active"));
                                        cs.add(Restrictions.eq("isApprove", "Approve"));

                                        List<Center> ls = cs.list();

                                        for (Center elem : l) {%>


                                    <option value="<%= elem.getIdCenter()%>"><%= elem.getCenterNo() + " - " + elem.getCenterName()%></option>


                                    <%    }
                                        ses.close();
                                    %>

                                </select>
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Member ID</label>
                                <input type="text" class="form-control" id="memid" placeholder="Member ID" name="memberid">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Group</label>
                                <input type="number" class="form-control" id="groupID" placeholder="Enter Group" name="group">
                            </div>

                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="formGroupExampleInput">NIC</label>
                                <input type="text" class="form-control" id="NICMem" placeholder="Enter NIC" name="NIC">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Name with Initials</label>

                                <input class="form-control" type="text" value="" id="nameint" name="namein" placeholder="Name with Initials">


                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput"> Full Name</label>
                                <input type="text" class="form-control" id="memname" placeholder="Enter Fullname" name="fullname">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Date of Birth</label>
                                <input type="date" class="form-control" id="memdob" placeholder="dob" name="dob">
                            </div>

                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="formGroupExampleInput">Contact No</label>
                                <input class="form-control" type="text" value="" id="contactNo" name="contact" placeholder="Enter Contact no">


                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Address Line 1</label>
                                <input class="form-control" type="tel" value="" id="address_1" 
                                       placeholder="Enter Address 1" name="address1">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Address Line 2</label>
                                <input class="form-control" type="tel" value="" id="address_2" placeholder="Enter Address 1" name="address2">
                            </div>

                            <div class="form-group">
                                <label for="formGroupExampleInput">City</label>
                                <input class="form-control" type="tel" value="" name="memcity" id="memcity" placeholder="Enter City">
                            </div>

                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="formGroupExampleInput">Gardian NIC</label>
                                <input class="form-control" type="text" value="" id="g_NIC" name="gNIC" placeholder="Gardian NIC">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Guardian Name</label>
                                <input class="form-control" type="text"  id="g_name" name="gname" placeholder="Enter Guardian Name">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Guardian DOB</label>
                                <input type="text" class="form-control" id="g_dob" placeholder="Enter Guardian DOB" name="gdob">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Guardian Occupation</label>
                                <input type="text" class="form-control" id="g_occ" name="gocc" placeholder="Enter Guardian Occupation">
                            </div>

                        </div>

                    </div>

            </div>
            <!--            <div class="modal-footer">
            
                            <input type="submit" class="btn btn-danger btn-sm" name="btn" value="Delete">
                            <input type="submit" class="btn btn-primary btn-sm" name="btn" value="Update">
                            </form>
            
                            <form action="../DeleteMemberServlet">
                                
                                <input type="text" class="form-control id" id="" placeholder="Member ID" name="memberid" hidden="">
                                <div style="height: 20px;">    </div>
                                <input type="submit" class="btn btn-danger btn-sm" name="btn" value="Delete">
                            </form>  
                        </div>-->
        </div>
    </div>
</div>

<jsp:include page="/footer.jsp"/>
