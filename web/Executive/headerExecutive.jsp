

<%@page import="Singleton.PageTitleSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!----------------------------Sweet Alert--------------------------------->
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <script src="https://code.jquery.com/jquery-3.2.1.js" integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE=" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
        <!--        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">-->

        <!--Chart JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>


        <!--Bootstrap Material Design-->

        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Material+Icons">
        <link rel="stylesheet" href="https://unpkg.com/bootstrap-material-design@4.0.0-beta.4/dist/css/bootstrap-material-design.min.css" integrity="sha384-R80DC0KVBO4GSTw+wZ5x2zn2pu4POSErBkf8/fSFhPXHxvHJydT0CSgAP2Yo2r4I" crossorigin="anonymous">
        <script src="https://unpkg.com/popper.js@1.12.6/dist/umd/popper.js" integrity="sha384-fA23ZRQ3G/J53mElWqVJEGJzU0sTs+SvzG8fXVWP+kJQ1lwFAOkcUOysnlKJC33U" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/bootstrap-material-design@4.0.0-beta.4/dist/js/bootstrap-material-design.js" integrity="sha384-3xciOSDAlaXneEmyOo0ME/2grfpqzhhTcM4cE32Ce9+8DW/04AGoTACzQpphYGYe" crossorigin="anonymous"></script>


        <!--------------------------------DATATABLES-------------------------------------->

        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap4.min.css">
        <!--<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">-->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.4.2/css/buttons.bootstrap4.min.css">

        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap4.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.4.2/js/dataTables.buttons.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.4.2/js/buttons.bootstrap4.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.4.2/js/buttons.html5.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.4.2/js/buttons.print.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/1.4.2/js/buttons.colVis.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/plug-ins/1.10.16/api/sum().js"></script>

        <!--       ----------------------------------- jquery ui----------------------------------------------------------------------------------------------------------------------->

        <link href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" rel="Stylesheet"></link>
        <script src='https://cdn.rawgit.com/pguso/jquery-plugin-circliful/master/js/jquery.circliful.min.js'></script>
        <script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js" ></script>


        <!--      ////////////////////////////////////////////////////////////////////////////////////////  select2-->

        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2-bootstrap-css/1.4.6/select2-bootstrap.css" />





        <title><%=PageTitleSet.getTitle().getPAGE_TITLE()%></title>
        <style>
            hr{
                display: block;
                height: 1px;
                border: 0;
                border-top: 1px solid #ccc;
                margin: 1em 0;
                padding: 0; 
            }
            .col-md-2{
                padding-right: 0px;
                padding-left: 0px;
            }
            ul {
                list-style-type: none;

            }

            li{
                padding-left: 20px;
                color: white;
            }
            h4{
                padding-left: 30px;
            }
            /*            .form-control[readonly]{
            
                            background: white;
            
            
            
                        }*/
            .select2-results__option {

                color: black;
            }

        </style>
        <script src="https://use.fontawesome.com/b609a141a6.js"></script>
    </head>


    <body onload="">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2 fixed-top" style="background:#2c3e50; ">

                    <div style="height: 1000px; " >

                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-md-12 text-center" style="color: white; padding-top: 10px;" >

                                    <img src="https://www.w3schools.com/w3css/img_avatar3.png" alt="" style=" border-radius: 50%; height: 100px; width: 100px;" class="img-fluid">
                                    <br>
                                    <div class="btn-group">
                                        <button type="button" class="btn  dropdown-toggle"  style="background: none; color: white;" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <b><%

                                                try {
                                                    if (session.getAttribute("userName").toString() != null) {
                                                        out.print(session.getAttribute("userName").toString());
                                                    } else {

                                                        response.sendRedirect("/CMC/newlogin.jsp");
                                                    }
                                                } catch (Exception e) {
                                                }


                                                %></b>
                                        </button>
                                        <div class="dropdown-menu">
                                            <!--                                            <a class="dropdown-item" href="#">Settings</a>-->
                                            <!--<div class="dropdown-divider"></div>-->
                                            <a class="dropdown-item" href="/CMC/LogoutServlet">Logout</a>
                                        </div>
                                    </div>


                                </div>
                            </div>
                        </div>

                        <div class="container-fluid">

                        </div>
                        <div >




                            <hr>
                            <br>


                            <div class="dropdown ">
                                <button type="button" class="btn btn-danger btn-block dropdown-toggle" data-toggle="dropdown" style="color: white">
                                    <i class="fa fa-plus" aria-hidden="true"></i>
                                    HR<span class="badge badge-primary" id="apnoti"></span>
                                </button>
                                <div class="dropdown-menu" style="background:#2c3e50;">

                                    <a class="btn btn-danger btn-block" style="color: white" href="/CMC/Executive/AddResignationExecutive.jsp">
                                        <i class="fa fa-plus-square-o" aria-hidden="true"></i> Add Resignation</a>
                                    <a class="btn btn-danger btn-block" style="color: white" href="/CMC/Executive/AddLeaveManagementExecutive.jsp">
                                        <i class="fa fa-plus-square-o" aria-hidden="true"></i> Add Leave</a>


                                </div>
                            </div> 


                            
                               <div class="dropdown ">
                                <button type="button" class="btn btn-danger btn-block dropdown-toggle" data-toggle="dropdown" style="color: white">
                                    <i class="fa fa-plus" aria-hidden="true"></i>
                                   Micro Credit<span class="badge badge-primary"></span>
                                </button>
                                <div class="dropdown-menu" style="background:#2c3e50;">
  <a class="btn btn-danger btn-block" style="color: white" href="/CMC/Executive/addCenter.jsp">
                                <i class="fa fa-plus-square-o" aria-hidden="true"></i> Add Center</a>
                            <a class="btn btn-danger btn-block" style="color: white" href="/CMC/Executive/addLoan.jsp">
                                <i class="fa fa-plus-square-o" aria-hidden="true"></i> Add Loan</a>
                            <a class="btn btn-danger btn-block" style="color: white" href="/CMC/Executive/addMember.jsp">
                                <i class="fa fa-plus-square-o" aria-hidden="true"></i> Add Member</a>
                            <a class="btn btn-danger btn-block" style="color: white" href="/CMC/Executive/addcashDenimation.jsp">
                                <i class="fa fa-plus-square-o" aria-hidden="true"></i> Add Denimation</a>
                            <a class="btn btn-danger btn-block" style="color: white" href="/CMC/Executive/addRepayment.jsp">
                                <i class="fa fa-plus-square-o" aria-hidden="true"></i> Add Repayment</a>
                            <a class="btn btn-danger btn-block" style="color: white" href="/CMC/Executive/viewLoan.jsp">
                                <i class="fa fa-plus-square-o" aria-hidden="true"></i> View Loan</a>
                            <a class="btn btn-danger btn-block" style="color: white" href="/CMC/Executive/viewRepayments.jsp">
                                <i class="fa fa-plus-square-o" aria-hidden="true"></i> View Repayment</a>
                            <a class="btn btn-danger btn-block" style="color: white" href="/CMC/Executive/viewCollectionSummery.jsp">
                                <i class="fa fa-plus-square-o" aria-hidden="true"></i> View Collection Summery</a>
                            <a class="btn btn-danger btn-block" style="color: white" href="/CMC/Executive/viewDisbursement.jsp">
                                <i class="fa fa-plus-square-o" aria-hidden="true"></i> View Loan Disbrustment</a>
                            <a class="btn btn-danger btn-block" style="color: white" href="/CMC/Executive/viewRepaymentSheet.jsp">
                                <i class="fa fa-plus-square-o" aria-hidden="true"></i> View Repayment Sheet</a>

                                </div>
                            </div> 
                            
                            

                          

                        </div>
                    </div>

                </div>
                <div class="col-md-10 ml-md-auto">
                    <!--<div class="col-md-10 offset-md-2" style="background:#ffff">-->







