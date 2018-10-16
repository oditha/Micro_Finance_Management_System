

<%@page import="Srcs.PoolManager"%>

<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="ORM.Resignation"%>
<%@page import="org.hibernate.Criteria"%>

<%@page import="org.hibernate.Session"%>
<%@page import="Singleton.PageTitleSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    if (session.getAttribute("userName") != null) {

    } else {

        response.sendRedirect("/CMC/newlogin.jsp");

    }


    PageTitleSet.getTitle().setPAGE_TITLE("Resignarion");%>
<jsp:include page="/header.jsp"/>

<%
    if (request.getParameter("save") != null) {
%>

<div class="alert alert-success" role="alert">
    <strong>Well done!</strong> You successfully requested resignation
</div>


<%
    }


%>
<%    if (request.getParameter("Update") != null) {
%>

<div class="alert alert-success" role="alert">
    <strong>Well done!</strong> You successfully Updated Resignation Details
</div>


<%
    }


%>
<%    if (request.getParameter("Delete") != null) {
%>

<div class="alert alert-success" role="alert">
    <strong>Well done!</strong> You successfully Deleted Resignation Details
</div>


<%
    }


%>


<div class="card">
    <div class="card-header text-right" role="tab" id="headingTwo">

        <a class="collapsed btn btn-primary btn-sm" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
            +Add New
        </a>

    </div>
    <div id="collapseTwo" class="collapse" role="tabpanel" aria-labelledby="headingTwo">
        <div class="card-block">
            <form action="../AddResignationExecutive" method="Post">
                <div class="container">
                    <div class="row">


                        <div class="col-md-6"> 
                            <div class="form-group">
                                <label for="exampleTextarea">Resignation Date</label>
                                <input class="form-control" type="date"  name="date" value="" id="dateinput" placeholder="Enter Resignation Date" required onchange="cal();">
                                <input type="text" name="Username" id="" value="<%=session.getAttribute("Username")%>" hidden>
                                <input type="text" name="id" id="" value="<%=session.getAttribute("id")%>" hidden>
                                <input type="text" name="nic" id="" value="<%=session.getAttribute("nic")%>" hidden>
                                <div id="inform" style="color: red;">Please request before 3 months</div>

                                <div style="height: 10px;"></div>
                                <div class="form-group text-right">





                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">

                            <div class="form-group">
                                <label for="exampleTextarea">Resignation Reason</label>
                                <textarea class="form-control" id="reason" placeholder="Enter Reason" name="reason" required></textarea>
                            </div>

                            <div class="form-group text-right">

                                <input type="reset" value="Reset" name="reset" class="btn btn-danger" id="reset">
                                <input type="submit" value="Submit" name="Save" class="btn btn-primary" id="save">

                            </div>
                        </div>

                    </div>
                </div>
            </form>
            <%


            %>



        </div>
    </div>
</div>


<!--<div class="card">-->
<!--    <div class="card-header">
        View Resignation Details
    </div>-->
    <!--<div class="card-block">-->


        <div class=" table-responsive ">          
            <table class="table table-stripped" id="restable">



                <thead>
                    <tr>
                        <th>#</th>
                        <th>Name</th>
                        <th>NIC</th>


                        <th>Requested Date</th>

                        <th>Resignation Date</th>



                        <th>Status</th>
                        <th>Options</th>


                    </tr>
                </thead>
                <tbody>
                    <%                        Session sess = PoolManager.getSessionFactory().openSession();

                        Criteria cr = sess.createCriteria(Resignation.class);

                        cr.createAlias("staff", "s");

                        cr.add(Restrictions.eq("s.idStaff", Integer.parseInt(session.getAttribute("id").toString())));
                        cr.add(Restrictions.eq("isActive", "Active"));

                        List<Resignation> l = cr.list();

                        for (Resignation res : l) {


                    %>

                    <tr>
                        <td><%=res.getIdResignation()%></td>
                        <td><%=res.getStaff().getName()%></td>
                        <td><%=res.getStaff().getNic()%></td>
                        <td><%=res.getRequestDate()%></td>
                        <td><%=res.getResihnationDate()%></td>
                        <td><%=res.getIsAproved()%></td>
                        <td>  <button class="btn btn-primary cls" data-toggle="modal" data-target="#myModal" myat="<%=res.getIdResignation()%>">Edit</button> </td>

                    </tr>


                    <%
                        }

                        sess.close();
                    %>




                </tbody>
            </table>

            <a id="fs">weyaw</a>

  




        </div>


<!--    </div>
</div>-->


<!--                  model ------------------------------------------------->



<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Edit Resignation</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="../EditResignationServlet" method="Post">
                    <input type="text" name="hid12" class="hid12" hidden >

                    <div class="form-group">
                        <label for="formGroupExampleInput">Requested Date</label>
                        <input type="date" class="form-control" id="editdate" placeholder="" name="reqdate" value="">
                    </div>
                    <div class="form-group">
                        <label for="formGroupExampleInput2">Reason</label>

                        <textarea  class="form-control" id="editReason" placeholder="Another input" name="Reason" ></textarea>
                    </div>









            </div>
            <div class="modal-footer">

                <input type="submit" value="Update" class="btn btn-primary btn-sm" name="update">  

                </form>
                <form action="../DeleteResignationServlet" style="padding: 0px;">  
                    <input type="text" value="" id="hid" name="hid" class="hid" hidden>
                    <input type="submit" value="Delete" class="btn btn-danger btn-sm">
                </form>

            </div>
        </div>
    </div>
</div>






<script>

    $(document).ready(function() {


        load();


    });


    function load() {
        var ID = "<%=session.getAttribute("id")%>";

        $.ajax({
            url: '../CheckResignationAjax',
            data: {ID: ID},
            success: function(responseText) {




                if (responseText === 'okkk') {
                    $("#save").attr("disabled", "disabled");
                    $("#reset").attr("disabled", "disabled");
                    // $("input[type=text]").attr("disabled", "disabled");
                    $("#dateinput").attr("disabled", "disabled");

                } else {
                    $("#save").removeAttr('disabled');
                    $("#reset").removeAttr('disabled');
                    $("#dateinput").removeAttr('disabled');
                }





            }

        });
    }


    $(".cls").click(function() {


        var title = $('.cls').attr('myat');

        $(".hid12").attr("value", title);
        $(".hid").attr("value", title);

        var hid = $('.hid12').attr('myat');


        $.ajax({
            type: 'POST',
            url: '../LoadEditResignation',
            data: {ID: title},
            success: function(responseText) {


                var arr = JSON.parse(responseText);


                for (var i = 0; i < arr.length; i++) {

                    var date = arr[i].Date;
                    var reson = arr[i].reson;

                }
                $('#editdate').attr("value", date);
                $('#editReason').val(reson);









            }

//        $("#editdate").val(resihnationDate);
//        $("#editReason").val(reson);

        });






    });


    $(document).ready(function() {
        $('#restable').DataTable();
    });


    $('#inform').hide();


    function GetDays() {
        var dropdt = new Date();
        var pickdt = new Date(document.getElementById("dateinput").value);
        return parseInt((pickdt - dropdt) / (24 * 3600 * 1000));

    }

    function cal() {



        if (30 >= GetDays()) {
            $('#inform').show();
            $("#save").attr("disabled", "disabled");


        } else {

            $('#inform').hide();

            $("#save").removeAttr('disabled');


        }



    }










</script>






<jsp:include page="/footer.jsp"/>