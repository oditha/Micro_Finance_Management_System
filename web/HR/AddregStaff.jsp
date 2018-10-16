<%-- 
    Document   : regStaff
    Created on : Nov 21, 2017, 10:42:11 PM
    Author     : iamarshrx
--%>

<%@page import="Srcs.PoolManager"%>

<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="java.util.List"%>
<%@page import="ORM.Staff"%>

<%@page import="org.hibernate.Session"%>
<%@page import="Singleton.PageTitleSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }

    PageTitleSet.getTitle().setPAGE_TITLE("Staff Management");  %>
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
<%

    if (request.getAttribute("save") != null) {%>

<div class="alert alert-success" role="alert">
    You have successfully added a employee
</div>


<%

    }


%>
<%    if (request.getParameter("Delete") != null) {


%>

<div class="alert alert-success" role="alert">
    You have successfully Deleted a employee
</div>


<%    }


%>
<%    if (request.getParameter("Update") != null) {%>

<div class="alert alert-success" role="alert">
    You have successfully Updated a employee
</div>


<%

    }


%>


<div id="accordion" role="tablist" aria-multiselectable="true">
    <div class="card">
        <div class="card-header text-right" role="tab" id="headingOne">

            <a class="btn btn-primary btn-sm" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                +Add Staff
            </a>

        </div>

        <div id="collapseOne" class="collapse " role="tabpanel" aria-labelledby="headingOne">
            <div class="card-block">


                <form action="../StaffRegisterServlet" id="f1" method="POST" id="form1">
                    <div class="container">
                        <div class="row">



                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="formGroupExampleInput">NIC</label>
                                    <input type="text" class="form-control" id="Nic" placeholder="Enter NIC" name="nic" required>
                                    <p style="color: red;"  id="nichide">Nic Already Exists!</p>
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Licence No</label>
                                    <input type="text" class="form-control" id="licenceNo" placeholder="Enter licence No" name="licenceNo" >
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Name</label>
                                    <input type="text" class="form-control" id="staffname" placeholder=" Enter Name" name="StaffName" required>
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Name with initials</label>
                                    <input type="text" class="form-control" id="staffnamew" placeholder=" Enter Name With Initials" name="StaffNameinitials" required>
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Gender</label>
                                    <br>
                                    <label class="custom-control custom-radio">
                                        <input name="gender" type="radio" class="custom-control-input" value="male">
                                        <span class="custom-control-indicator"></span>
                                        <span class="custom-control-description">Male</span>
                                    </label>
                                    <label class="custom-control custom-radio">
                                        <input id="mixed0" name="gender" type="radio" class="custom-control-input" value="Female">
                                        <span class="custom-control-indicator"></span>
                                        <span class="custom-control-description">Female</span>
                                    </label>


                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Date Of birth</label>

                                    <input class="form-control" type="date" value="" id="dob" name="dob" required>


                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput"> Address 1</label>
                                    <input type="text" class="form-control" id="adress1" placeholder=" Enter Address 1" name="Address1" required>
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Address 2</label>
                                    <input type="text" class="form-control" id="address2" placeholder="Enter Address 2" name="Address2" >
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">City</label>
                                    <input type="text" class="form-control" id="city" placeholder="Enter city" name="city" required>
                                </div>

                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Email</label>
                                    <input class="form-control" type="email" value="" id="email" name="email" placeholder="Enter Email" required>


                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Contact 1</label>
                                    <input class="form-control" type="tel" value="" id="contact1" name="contact1" placeholder="Enter Contact 1" required maxlength="10">
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Contact 2</label>
                                    <input class="form-control" type="tel" value="" id="contact2" name="contact2" placeholder="Enter Contact 2" maxlength="10">
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Position</label>
                                    <select class="form-control" id="position" name="position" required >
                                        <option value="Manager">Manager</option>
                                        <option value="Executive">Executive</option>
                                        <option value="Documentation Officer">Documentation Officer</option>
                                        <option value="Cashier">Cashier</option>

                                    </select>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Basic Salary</label>
                                    <input class="form-control" type="text"  id="basicSalary" name="basicSalary" placeholder="Enter Basic slary" required>
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Joining Date</label>
                                    <input class="form-control" type="date" value="" id="joiningDate" name="joiningDate" required>
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Etf No</label>
                                    <input type="text" class="form-control" id="formGroupExampleInput" placeholder="Enter Etf No" name="etf">
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Epf No</label>
                                    <input type="text" class="form-control" id="formGroupExampleInput" placeholder="Enter Epf No" name="epf">
                                </div>
                                <div class="form-group text-right">
                                    <!--<div style="height: 100px;"></div>-->
                                    <input type="reset" value="Reset"  class="btn btn-danger ">
                                    <input type="submit" value="Save" name="submit" class="btn btn-primary ">




                                </div>
                            </div>
                            <div class="container" >
                                <div class="row">
                                    <div class="col-md-3">



                                    </div>
                                    <div class="col-md-3"></div>
                                    <div class="col-md-3"></div>
                                    <div class="col-md-3 text-right">   </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </form>	


            </div>
        </div>   

        <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit Employee</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <div class="container">

                            <div class="row">
                                <div class="col-md-6"></div>
                                <div class="col-md-6"><img src="" alt="" class="img-fluid img text-center" id="img" width="100px" height="100px"></div>
                            </div>
                        </div>

                        <div class="container">
                            <form action="../EditStaffServlet" method="POST">
                                <div class="row">


                                    <div class="col-md-6">

                                        <div class="form-group">
                                            <label for="formGroupExampleInput">NIC</label>
                                            <input type="text" class="form-control" id="eNic" placeholder="Enter NIC" name="nic">

                                        </div>
                                        <div class="form-group">
                                            <label for="formGroupExampleInput">Name</label>
                                            <input type="text" class="form-control" id="estaffname" placeholder=" Enter Name" name="StaffName">
                                        </div>


                                        <div class="form-group">
                                            <label for="formGroupExampleInput">Gender</label>
                                            <br>
                                            <label class="custom-control custom-radio">
                                                <input name="gender" type="radio" class="custom-control-input" value="male" id="male">
                                                <span class="custom-control-indicator"></span>
                                                <span class="custom-control-description">Male</span>
                                            </label>
                                            <label class="custom-control custom-radio">
                                                <input name="gender" type="radio" class="custom-control-input" value="Female" id="female">
                                                <span class="custom-control-indicator"></span>
                                                <span class="custom-control-description">Female</span>
                                            </label>


                                        </div>



                                        <div class="form-group">
                                            <label for="formGroupExampleInput">Email</label>
                                            <input class="form-control" type="email" value="" id="eemail" name="email" placeholder="Enter Email">


                                        </div>
                                        <div class="form-group">
                                            <label for="formGroupExampleInput">Contact 1</label>
                                            <input class="form-control" type="tel" value="" id="econtact1" name="contact1" placeholder="Enter Contact 1"   maxlength="10">
                                        </div>
                                        <div class="form-group">
                                            <label for="formGroupExampleInput">Contact 2</label>
                                            <input class="form-control" type="tel" value="" id="econtact2" name="contact2" placeholder="Enter Contact 2"   maxlength="10">
                                        </div>
                                        <div class="form-group">
                                            <label for="formGroupExampleInput">Position</label>
                                            <select class="form-control" id="eposition" name="position" >
                                                <option value="Manager">Manager</option>
                                                <option value="Executive">Executive</option>
                                                <option value="Documentation Officer">Documentation Officer</option>
                                                <option value="Cashier">Cashier</option>

                                            </select>
                                        </div>


                                        <div class="form-group">
                                            <label for="formGroupExampleInput">Basic Salary</label>
                                            <input class="form-control" type="text"  id="ebasicSalary" name="basicSalary" placeholder="Enter Basic slary">
                                        </div>
                                        <div class="form-group">
                                            <label for="formGroupExampleInput">Joining Date</label>
                                            <input class="form-control" type="date" value="" id="ejoiningDate" name="joiningDate">
                                        </div>



                                    </div>
                                    <div class="col-md-6">

                                        <div class="form-group">
                                            <label for="formGroupExampleInput">Licence No</label>
                                            <input type="text" class="form-control" id="elicenceNo" placeholder="Enter licence No" name="licenceNo">
                                        </div>

                                        <div class="form-group">
                                            <label for="formGroupExampleInput">Name with initials</label>
                                            <input type="text" class="form-control" id="festaffname" placeholder=" Enter Name With Initials" name="StaffNameinitials">
                                        </div>


                                        <div class="form-group">
                                            <label for="formGroupExampleInput">Date Of birth</label>

                                            <input class="form-control" type="date" value="" id="edob" name="dob">


                                        </div>
                                        <div class="form-group">
                                            <label for="formGroupExampleInput"> Address 1</label>
                                            <input type="text" class="form-control" id="eadress1" placeholder=" Enter Address 1" name="Address1">
                                        </div>
                                        <div class="form-group">
                                            <label for="formGroupExampleInput">Address 2</label>
                                            <input type="text" class="form-control" id="eaddress2" placeholder="Enter Address 2" name="Address2">
                                        </div>
                                        <div class="form-group">
                                            <label for="formGroupExampleInput">City</label>
                                            <input type="text" class="form-control" id="ecity" placeholder="Enter city" name="city">
                                        </div>


                                        <div class="form-group">
                                            <label for="formGroupExampleInput">Etf No</label>
                                            <input type="text" class="form-control" id="eetf" placeholder="Enter Etf No" name="etf">
                                        </div>
                                        <div class="form-group">
                                            <label for="formGroupExampleInput">Epf No</label>
                                            <input type="text" class="form-control" id="eepf" placeholder="Enter Epf No" name="epf">
                                        </div>

                                    </div>






                                </div>


                                <div class="modal-footer">
                                    <input type="text" value="" id="hid" name="hid" class="hid" hidden>
                                    <input type="submit" value="Update" class="btn btn-primary btn-sm" name="update">  
                                    </form>
                                    <form action="../DeleteStaffServlet" style="padding: 0px; padding-top: 20px">  
                                        <input type="text" value="" id="hid" name="hid" class="hid"hidden >
                                        <input type="submit" value="Delete" class="btn btn-danger btn-sm">
                                    </form>
                                </div>

                        </div>
                    </div>



                    <script type="text/javascript">

                        //    var form = $('#form1');
                        //    form.submit(function () {
                        //
                        //        $.ajax({
                        //            type: form.attr('method'),
                        //            url: form.attr('action'),
                        //            data: form.serialize(),
                        //            success: function (data) {
                        //                var result = data;
                        //                $('#result').attr("value", result);
                        //               
                        //                $("#alert").html(info);
                        //                //adding class
                        //                // $("#alert").addClass("alert alert-success");
                        //
                        //            }
                        //        });
                        //
                        //        return false;
                        //    });
                    </script>





                </div>
            </div>
        </div>
    </div>
</div>
<!--<div style="height: 30px;"></div>-->
<div class="card">









    <div class="card-header">
        <h4>List All </h4>
    </div>
    <div class="card-block">
        <div class="container">
            <div class="row">	

            </div>



        </div>


    </div>
    <div class=" table-responsive ">          
        <table class="table table-stripped" id="dtable">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Full Name</th>
                    <th>NIC</th>


                    <th>Contact</th>
                    <th>Position</th>
                    <th>Address</th>



                    <th>Status</th>
                    <th>Options</th>


                </tr>
            </thead>

            <tbody>

                <%                        Session s = PoolManager.getSessionFactory().openSession();

                    Criteria cr = s.createCriteria(Staff.class);
                    cr.add(Restrictions.eq("isActive", "Active"));

                    List<Staff> l = cr.list();

                    for (Staff staff : l) {
                        // out.print(staff.getCity()   );

                %>

                <tr>
                    <td><%= staff.getIdStaff()%></td>
                    <td><%= staff.getName()%></td>
                    <td><%= staff.getNic()%></td>
                    <td><%= staff.getContact1()%></td>
                    <td><%= staff.getPosition()%></td>
                    <td><%= staff.getAddress1() + "," + staff.getAddress2() + "," + staff.getCity() + "."%></td>
                    <td><%= staff.getIsActive()%></td>

                    <td>  <button class="btn btn-primary cls"  myat="<%= staff.getIdStaff()%>">Edit</button> </td>

                </tr>

                <%

                    }

                    s.close();
                %>





            </tbody>
        </table>

        <table>
            <%
            %>
        </table>

    </div>

    <!--<div style="height: 30px;"></div>-->



</div>

<div class="modal-footer">
</div>




<script>

    //-------------------------------------------------------------------------------------------------------------------------------------------------------------------

    $('#Nic').keyup(function() {

        var nic = $(this).val();

        $.ajax({
            url: '../AddStaffAjaxServlet',
            data: {nic: nic},
            success: function(responseText) {

                //alert(responseText);


                if (responseText == "okk") {


                    $('#Nic').css('border-color', 'red');
                    $('#nichide').show();

                } else {

                    $('#nichide').hide();
                    ///     $('#username').css('border-color', 'none');

                    $('#Nic').css('border-color', '#025aa5');


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

    $('#nichide').hide();

//-------------------------------------------------------------------------------------

    $('.cls').on('click', function() {

        var m = $(this).attr('myat');


        $(".hid").attr('value', m);


        $.ajax({
            url: '../RegStaffAjaxServlet',
            data: {ID: m},
            success: function(responseText) {





                var ja = JSON.parse(responseText);






                for (var i = 0; i < ja.length; i++) {

                    var pic = ja[i].pic;
                    var nic = ja[i].nic;
                    var Licence = ja[i].Licence;
                    var Namew = ja[i].Namew;
                    var gender = ja[i].gender;
                    var dob = ja[i].dob;
                    var email = ja[i].email;
                    var ad1 = ja[i].ad1;
                    var ad2 = ja[i].ad2;
                    var c1 = ja[i].c1;
                    var c2 = ja[i].c2;
                    var city = ja[i].city;
                    var position = ja[i].position;
                    var etf = ja[i].etf;
                    var epf = ja[i].epf;
                    var basic = ja[i].basic;
                    var jdate = ja[i].jdate;
                    var fullname = ja[i].fullname;
                    var salary = ja[i].salary;










                }

                $('#eNic').val(nic);
                $('#estaffname').val(fullname);
                $('#eemail').val(email);

                if (gender === 'male') {
                    document.getElementById("male").checked = true;
                    document.getElementById("female").checked = false;
                } else {
                    document.getElementById("male").checked = false;
                    document.getElementById("female").checked = true;
                }

                $('#festaffname').val(fullname);
                $('#econtact1').val(c1);
                $('#econtact2').val(c2);
                $('#eposition').val(position);
                $('#ebasicSalary').val(salary);
                $('#ejoiningDate').val(jdate);
                $('#elicenceNo').val(Licence);
                $('#estaffname').val(Namew);
                $('#edob').val(dob);
                $('#eadress1').val(ad1);
                $('#eaddress2').val(ad2);
                $('#eetf').val(etf);
                $('#eepf').val(epf);
                $('#ecity').val(city);







            }


        });


        $('.bd-example-modal-lg').modal('show');






    });

    $(document).ready(function() {
        $('#table').DataTable({
            dom: 'Bfrtip',
            buttons: [
                'copy', 'excel', 'pdf', 'print', 'colvis'
            ]
        });

        table = $('#dtable').DataTable();
        table.buttons().container()
                .appendTo('#example_wrapper .col-md-6:eq(0)');

    });





    $("#contact1").keyup(function() {

        var contact = $('#contact1').val();

        if (contact.length <= 10) {

        } else {


        }





    });

    $("#contact1").keypress(function(e) {
        var charCode = (e.which) ? e.which : e.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
    });
    $("#contact2").keypress(function(e) {
        var charCode = (e.which) ? e.which : e.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
    });
    $("#basicSalary").keypress(function(e) {
        var charCode = (e.which) ? e.which : e.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
    });
</script>
































<jsp:include page="/footer.jsp"/>
