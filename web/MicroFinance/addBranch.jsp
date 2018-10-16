<%-- 
    Document   : regStaff
    Created on : Nov 21, 2017, 10:42:11 PM
    Author     : iamarshrx
--%>
<%@page import="Srcs.PoolManager"%>
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
    PageTitleSet.getTitle().setPAGE_TITLE("Branch Details");


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
                +Add Branch
            </a>

        </div>

        <div id="collapseOne" class="collapse " role="tabpanel" aria-labelledby="headingOne">
            <div class="card-block">


                <form action="../AddBranchServlet" id="form1" method="GET">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Branch Code</label>
                                    <input type="text" class="form-control" id="branchcode" placeholder="Enter Branch code" name="branchcode" autofocus="" required="">
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Branch Name</label>
                                    <input type="text" class="form-control" id="branchName" placeholder="Enter Branch name" name="branchName" required="">
                                </div>


                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Address Line 1</label>

                                    <input class="form-control" type="text" value="" id="address1" name="address1" placeholder="Enter address line 1" required="">


                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput"> Address Line 2</label>
                                    <input type="text" class="form-control" id="adress2" placeholder="Enter address line 2" name="address2">
                                </div>

                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="formGroupExampleInput">City</label>
                                    <input class="form-control" type="text" value="" id="city" name="city" placeholder="Enter City" required="">


                                </div>


                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Primary Contact No</label>
                                    <input maxlength="10" class="form-control" type="tel"  id="contact1" name="contact1" placeholder="Enter Primary Phone" required="">
                                </div>
                                <div class="form-group">
                                    <label for="formGroupExampleInput">Secondary Contact No</label>
                                    <input maxlength="10" class="form-control" type="tel"  id="contact2" name="contact2" placeholder="Enter Secondary Phone">
                                </div>

                                <div class="form-group text-right">
                                    <!--<div style="height: 10px;"></div>-->
                                    <input type="reset" value="Reset" name="Reset" class="btn btn-danger " id="sub">
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
<!--<div class="card">-->

    <div class=" table-responsive ">          
        <table class="table table-stripped" id="myTable">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Branch Code</th>
                    <th>Branch Name</th>
                    <th>Contact 1</th>
                    <th>Contact 2</th>
                    <th>City</th>
                    <th>Status</th>
                    <th>Options</th>
                </tr>
            </thead>
            <tbody>

                <%                    int i = 1;
                    Session s = PoolManager.getSessionFactory().openSession();
                    Criteria cr = s.createCriteria(Branch.class);
                    cr.add(Restrictions.eq("isActive", "Active"));
                    List<Branch> branch = cr.list();

                    for (Branch b : branch) {%>

                <tr>
                    <th scope="row"><%= i++%></th>
                    <td><%= b.getBranchNo()%></td>
                    <td><%= b.getBranchName()%></td>
                    <td><%= b.getContact1()%></td>
                    <td><%= b.getContact2()%></td>
                    <td><%= b.getCity()%></td>
                    <td><%= b.getIsActive()%></td>
                    <td>
                        <div class="col-md-3"><a href="#" class="btn btn-sm btn-info viewDt" id="viewModal" data-toggle="modal" data-target="#exampleModal" data-whatever="<%= b.getIdBranch()%>">View</a></div>
                    </td>



                </tr>


                <%
                    }
                    s.close();
                %>


            </tbody>
        </table>



        <!--<div style="height: 10px;"></div>-->




    </div>
<!--</div>-->


<script>

    $(document).ready(function() {
        $('#myTable').DataTable({
            dom: 'Bfrtip',
            buttons: [
                'copy', 'excel', 'pdf', 'print', 'colvis'
            ]
        });

        table.buttons().container()
                .appendTo('#example_wrapper .col-md-6:eq(0)');

    });

    function FilterTable() {
        var input, filter, table, tr, td, i;
        input = document.getElementById("myInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("myTable");
        tr = table.getElementsByTagName("tr");
        for (i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[2];
            if (td) {
                if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }

//--------------------------Load Modal Details----------------------------------------

    $('.viewDt').click(function() {

        var BranchID = $(this).attr('data-whatever');
        $.ajax({
            url: '../BranchViewAJAX',
            data: {branchID: BranchID},
            success: function(responseText) {

                var ja = JSON.parse(responseText);
                for (var i = 0; i < ja.length; i++) {

                    var bid = ja[i].bid;
                    var bno = ja[i].bno;
                    var bname = ja[i].bname;
                    var bad1 = ja[i].bad1;
                    var bad2 = ja[i].bad2;
                    var bct = ja[i].bct;
                    var bco1 = ja[i].bco1;
                    var bco2 = ja[i].bco2;


                }

                $('#bid').attr('value', bid);
                $('#bNo').attr('value', bno);
                $('#bname').attr('value', bname);
                $('#bad1').attr('value', bad1);
                $('#bad2').attr('value', bad2);
                $('#bct').attr('value', bct);
                $('#bco1').attr('value', bco1);
                $('#bco2').attr('value', bco2);

            }


        });


    });

//--------------------------Validate Branch COde--------------------------------

    $('#branchcode').keyup(function() {

        var BranchNO = $(this).val();

        $.ajax({
            url: '../ValidateBranchNoAJAX',
            data: {branchNo: BranchNO},
            success: function(response) {

                if (response === 'NO') {


                } else {
                     swal("Oops", response, "error");
//                    alert(response);


                }

            }


        });


    });

//-----------------------Validations--------------------------------------------

    $(document).ready(function() {

        $("#contact1").keypress(function(e) {

            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {

                return false;
            }
        });
    });

    $(document).ready(function() {

        $("#contact2").keypress(function(e) {

            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {

                return false;
            }
        });
    });

    $(document).ready(function() {

        $("#bco1").keypress(function(e) {

            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {

                return false;
            }
        });
    });

    $(document).ready(function() {

        $("#bco2").keypress(function(e) {

            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {

                return false;
            }
        });
    });

</script>

<!-- Modal -->

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

                <form action="../UpdateBranchServlet" method="POST">
                    <div class="row">
                        <div class="col-md-6">

                            <div class="form-group">
                                <label for="formGroupExampleInput">Branch Code</label>
                                <input type="text" value="" class="form-control" id="bNo" placeholder="Enter Branch code" name="branchcode" autofocus="" required="">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Branch Name</label>
                                <input type="text" class="form-control" id="bname" placeholder="Enter Branch name" name="branchName" required="">
                            </div>


                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="formGroupExampleInput">Address Line 1</label>

                                <input class="form-control" type="text" value="" id="bad1" name="address1" placeholder="Enter address line 1" required="">


                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput"> Address Line 2</label>
                                <input type="text" class="form-control" id="bad2" placeholder="Enter address line 2" name="address2">
                            </div>

                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="formGroupExampleInput">Primary Contact No</label>
                                <input maxlength="10" class="form-control" type="tel"  id="bco1" name="contact1" placeholder="Enter Primary Phone" required="">
                            </div>
                            <div class="form-group">
                                <label for="formGroupExampleInput">Secondary Contact No</label>
                                <input maxlength="10" class="form-control" type="tel"  id="bco2" name="contact2" placeholder="Enter Secondary Phone">
                            </div>

                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="formGroupExampleInput">City</label>
                                <input class="form-control" type="text" value="" id="bct" name="city" placeholder="Enter City" required="">

                            </div>
                            <div class="form-group">
                                <input type="text" hidden="" value="" class="form-control" id="bid" placeholder="Enter Branch code" name="branchID" autofocus="" required="">
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
