<%-- 
    Document   : regStaff
    Created on : Nov 21, 2017, 10:42:11 PM
    Author     : iamarshrx
--%>
<%@page import="Singleton.PageTitleSet"%>
<%

    PageTitleSet.getTitle().setPAGE_TITLE("Center Schedule");
try {
        if (!session.getAttribute("UserType").toString().equals("Manager")) {

            response.sendRedirect("/CMC/errorPage/401Unauthorized.html");

        }
    } catch (Exception e) {
    }
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
<div style="height: 10px"></div>

<!--Alerts Section-->

<div class="alert alert-success" role="alert">
    This is a success alert—check it out!
</div>
<div class="alert alert-danger" role="alert">
    This is a success alert—check it out!
</div>
<div style="height: 10px"></div>

<!--add Details-->

<!--Table Section-->

<div style="height: 10px;"></div>
<div class="card">
    <div class="card-block">
        <div class="container">
            <div class="row">	


                <div class="col-md-4">
                    <div class="form-group">
                        <form action="">
                            <label for="exampleSelect1">Filter By Center</label>
                            <select class="form-control" id="exampleSelect1">
                                <option>Badulla</option>
                                <option>Passara</option>

                            </select>
                            <div class="containerfluid text-right" style="padding-top: 10px;"><input type="submit" value="Filter" name="Search" class="btn btn-primary text-right btn-sm"></div>

                        </form>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="form-group">
                        <form action="">
                            <label for="exampleSelect1">Filter By Day</label>
                            <select class="form-control" id="exampleSelect1">
                                <option>Monday</option>
                                <option>Tuesday</option>
                                <option>Wednesday</option>
                                <option>Thursday</option>
                                <option>Friday</option>
                                <option>Saturday</option>
                                <option>Sunday</option>

                            </select>
                            <div class="containerfluid text-right" style="padding-top: 10px;"><input type="submit" value="Filter" name="Search" class="btn btn-primary text-right btn-sm"></div>

                        </form>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="form-group">
                        <form action="">
                            <label for="exampleSelect1">Filter By Executive</label>
                            <select class="form-control" id="exampleSelect1">
                                <option>NIC - Name</option>
                                <option>De-Active</option>

                            </select>
                            <div class="containerfluid text-right" style="padding-top: 10px;"><input type="submit" value="Filter" name="Search" class="btn btn-primary text-right btn-sm"></div>

                        </form>
                    </div>
                </div>



            </div>

        </div>
    </div>
    <div class=" table-responsive ">          
        <table class="table table-stripped">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Center Code</th>
                    <th>Center Name</th>


                    <th>Center Day</th>
                    <th>Time</th>
                    <th>Executive</th>


                </tr>
            </thead>
            <tbody>

                <tr>
                    <th scope="row">1</th>
                    <td>H1</td>
                    <td>Badulla</td>
                    <td>Monday</td>
                    <td>09:00 AM</td>
                    <td>NIC - Saman</td>
                    
                </tr>
                <tr>
                    <th scope="row">2</th>
                    <td>H1</td>
                    <td>Badulla</td>
                    <td>Monday</td>
                    <td>09:00 AM</td>
                    <td>NIC - Saman</td>
                    
                </tr>
            </tbody>
        </table>



        <div style="height: 10px;"></div>




    </div>
</div>





<jsp:include page="/footer.jsp"/>
