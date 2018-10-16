<%-- 
    Document   : addUser
    Created on : Nov 22, 2017, 12:21:39 PM
    Author     : iamarshrx
--%>

<%@page import="Srcs.PoolManager"%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="ORM.Login"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Criteria"%>

<%@page import="ORM.Staff"%>
<%@page import="org.hibernate.Session"%>
<%@page import="Singleton.PageTitleSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }

    PageTitleSet.getTitle().setPAGE_TITLE("User Details");  %> 
<jsp:include page="/header.jsp"/>
<!--<div style="height: 10px;"></div>-->

<%

    if (request.getParameter("err") != null && request.getParameter("err").equals("passnm")) {
%>


<div class="alert alert-warning">
    <strong>Danger!</strong> Password doesn't Match
</div>


<%
    }
    if (request.getParameter("err") != null && request.getParameter("err").equals("slectstf")) {

%>


<div class="alert alert-warning">
    <strong>Danger!</strong> Please Select Staff
</div>


<%    }


%>


<%    if (request.getParameter("success") != null && request.getParameter("success").equals("ok")) {
%>



<div class="alert alert-success">
    <strong>Welldone!</strong> Successfully Saved !
</div>


<%
    }


%>
<%    if (request.getParameter("success") != null && request.getParameter("success").equals("okupdate")) {
%>



<div class="alert alert-success">
    <strong>Welldone!</strong> Successfully Updated passwords !
</div>


<%
    }


%>
<%    if (request.getParameter("success") != null && request.getParameter("success").equals("delete")) {
%>



<div class="alert alert-success">
    <strong>Welldone!</strong> Successfully Deleted!
</div>


<%
    }


%>



<div class="card">
    <div class="card-header text-right" role="tab" id="headingTwo">

        <a class="collapsed btn btn-primary btn-sm" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
            +Add User
        </a>

    </div>
    <div id="collapseTwo" class="collapse" role="tabpanel" aria-labelledby="headingTwo">
        <div class="card-block">


            <div class="container">
                <form action="../AddUserServlet" method="Post">
                    <div class="row">
                        <div class="col-md-3">


                            <div class="form-group">
                                <label for="exampleSelect1">Select Employee</label>
                                <select class="form-control" id="exampleSelect1" name="Staff">

                                    <option>Select</option>
                                    <%                                        Session s = PoolManager.getSessionFactory().openSession();

                                        Criteria cr = s.createCriteria(Staff.class);
                                        cr.add(Restrictions.eq("isActive", "Active"));

                                        List<Staff> l = cr.list();

                                        for (Staff staff : l) {

                                            Set getLogins = staff.getLogins();
                                            Iterator it = getLogins.iterator();
                                            int id = 0;
                                            while (it.hasNext()) {
                                                Login log = (Login) it.next();
                                                if (log.getStaff().getIsActive().equals("Active")) {

                                                    id = log.getStaff().getIdStaff();

                                                }

                                            }
                                            if (id != staff.getIdStaff()) {

                                                // if (login.getUserName() == null) {

                                    %>




                                    <option><%=staff.getName() + "-" + staff.getNic()%></option>



                                    <%
                                        }

                                    %>




                                    <%//}
                                        }
                                        s.close();
                                    %>




                                </select>

                            </div>


                        </div>
                        <div class="col-md-3">

                            <div class="form-group">
                                <label for="formGroupExampleInput">Username</label>
                                <input type="text" class="form-control" id="username" placeholder="Enter Username" name="user">
                            </div>
                            <div class="" role="alert" id="ualert" style="color:red; ">
                                <b>
                                    Sorry, that username's taken. Try another?</b>
                            </div>


                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="formGroupExampleInput">Password</label>
                                <input type="password" class="form-control" id="pass" placeholder="Enter Password" name="Pass" data-toggle="tooltip" data-placement="right" title="Username Already exists">
                            </div>



                        </div>
                        <div class="col-md-3">

                            <div class="form-group">
                                <label for="formGroupExampleInput">Re-type Password</label>
                                <input type="password" class="form-control" id="repass" placeholder="Re-Enter your Password" name="repass">
                            </div>

                            <div class="form-group text-right">

                                <input type="reset" value="Reset" name="reset" class="btn btn-danger">
                                <input type="submit" value="Submit" name="Save" class="btn btn-primary" id="sb">



                            </div>

                        </div>



                    </div>
                </form>
            </div>





        </div>
    </div>
</div>

<!--<div style="height: 10px;"></div>-->

<div class="card">
    <div class="card-header">
        List All
    </div>
    <div class="card-block">

        <div class=" table-responsive ">          
            <table class="table table-stripped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Name</th>
                        <th>NIC</th>


                        <th>Username</th>

                        <th>Role</th>



                        <th>Status</th>
                        <th>Options</th>


                    </tr>
                </thead>
                <tbody>

                    <%
                        Session sess = PoolManager.getSessionFactory().openSession();
                        Criteria cr1 = sess.createCriteria(Login.class);
                        cr1.add(Restrictions.eq("isActive", "Active"));
                        List<Login> l2 = cr1.list();
                        for (Login login : l2) {
                    %>



                    <tr>
                        <td><%=login.getIdLogin()%></td>
                        <td><%=login.getStaff().getName()%></td>
                        <td><%=login.getStaff().getNic()%></td>
                        <td><%=login.getUserName()%></td>
                        <td><%=login.getStaff().getPosition()%></td>
                        <%

                            if (login.getLoginBlock().equals("unblock")) {
                        %><td style="color: green; "><b><%=login.getLoginBlock()%></b></td><%
                        } else if (login.getLoginBlock().equals("Blocked")) {
                                %><td style="color: red;"><b><%=login.getLoginBlock()%></b></td><%
                                    }


                                %>
                        <td> <button  class="btn btn-primary cls"  myat="<%=login.getIdLogin()%>" id="model">
                                Modify
                            </button></td>






                    </tr>





                    <%
                        }
                        sess.close();

                    %>




                </tbody>
            </table>



            <!--<div style="height: 10px;"></div>-->




        </div>



    </div>
</div>


<!-- Button trigger modal -->


<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <form action="../editUserServlet" method="POST">
                    <div class="container">


                        <div class="row">
                            <div class="col-md-2"></div>
                            <div class="col-md-8">
                                <input type="text" value="" id="hid" name="hid" class="hid" hidden>

                                <div class="form-group">
                                    <label class="col-form-label" for="formGroupExampleInput">Name</label>
                                    <input type="text" class="form-control" id="mname" placeholder="" readonly name="mname">
                                </div>
                                <div class="form-group">
                                    <label class="col-form-label" for="formGroupExampleInput">Username</label>
                                    <input type="text" class="form-control" id="muname" placeholder="" readonly name="muname" >
                                </div>
                                <div class="form-group">
                                    <label class="col-form-label" for="formGroupExampleInput">Password</label>
                                    <input type="password" class="form-control" id="mpass" placeholder="" name="mpass" >
                                </div>
                                <div class="form-group">
                                    <label class="col-form-label" for="formGroupExampleInput">Re-type Password</label>
                                    <input type="password" class="form-control" id="rempass" placeholder="" name="rempass" >
                                </div>




                            </div>
                            <div class="col-md-2"></div>
                        </div>

                    </div>



            </div>
            <div class="modal-footer">

                <input type="submit" value="Update" class="btn btn-primary btn-sm" name="update">  </form>
                <form action="../DeleteUserServlet" >   <input type="text" value="" id="hid" name="hid" class="hid" hidden>
                    <!--<div style="height: 16px;"></div>-->
                    <input type="submit" value="Delete" class="btn btn-danger btn-sm">
                </form>
            </div>

        </div>
    </div>
</div>




<script>




    $('#username').keyup(function () {

        var username = $(this).val();

        $.ajax({
            url: '../UservalAjaxServlet',
            data: {username: username},
            success: function (responseText) {




                if (responseText == "okk") {


                    $('#username').css('border-bottom-color', 'red');
                    $('#ualert').show();

                } else {

                    $('#ualert').hide
                    ///     $('#username').css('border-color', 'none');

                    $('#username').css('border-bottom-color', '#025aa5');


                }




                // alert(responseText)
//                                    var ja = JSON.parse(responseText);
                //alert(ja);

                ///                             alert(responseText);

//                                for (var i = 0; i < ja.length; i++) {
//                                     
//                                   alert(ja.length);
//                                    
//                                    
//                                  
////                                    
//                                    
//    
//                        }
            }


        });


    });

///finish ajax//---------------------------------------------------------

    $('#ualert').hide();



    $('#repass').keyup(function () {

        var pas = $('#pass').val();
        var repass = $(this).val();


//        alert(pas);


        if (pas === repass) {

            //  $('#repass').css('border-color', 'green');


            $('#sb').removeAttr('disabled');

        } else {

            //  $('#repass').css('border-color', 'red');
            $('#sb').attr('disabled', 'disabled');


        }




    }



    );
//------------------------------------------------------------------------------------------------


    $('.cls').on('click', function () {

        var m = $(this).attr('myat');


        $(".hid").attr('value', m);


        $.ajax({
            url: '../UsermodallAjaxServlet',
            data: {ID: m},
            success: function (responseText) {


                // alert(responseText);


                var ja = JSON.parse(responseText);






                for (var i = 0; i < ja.length; i++) {

                    var name = ja[i].name;
                    var username = ja[i].username;
                    var password = ja[i].password;





                }
                $("#mname").attr('value', name);
                $("#muname").attr('value', username);
                $("#mpass").attr('value', password);
                $("#rempass").attr('value', password);

            }


        });


        $('#exampleModal').modal('show');





    });

    //---------------------------------------------------------------------------------------$.ajax({






//    $("#target").click(function () {
//
//    });



    $('#rempass').keyup(function () {

        var pas = $('#mpass').val();
        var repass = $(this).val();

        // alert(pas);


        if (pas === repass) {

            // $('#rempass').css('border-color', 'green');

            $('#rempass').addClass("form-control-success");



        } else {

            $('#rempass').css('border-color', 'red');


        }




    }



    );



</script>                  


<jsp:include page="/footer.jsp"/>
