<%-- 
    Document   : Login
    Created on : Nov 27, 2017, 12:27:17 AM
    Author     : iamarshrx
--%>

<%@page import="net.sf.jasperreports.engine.JasperReport"%>
<%@page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@page import="java.io.InputStream"%>
<%@page import="Singleton.PageTitleSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

  
    if (session.getAttribute("userName") != null) {

        response.sendRedirect("/CMC/index.jsp");

    }

    PageTitleSet.getTitle().setPAGE_TITLE("Login");

%>



<!DOCTYPE html>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.2.1.js" integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE=" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
        <!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>-->
        <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">-->

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
            body{
                background-color: #2c3e50;

            }



        </style>
        <script src="https://use.fontawesome.com/b609a141a6.js"></script>
    </head>


    <body onload="">

        <style>

            .card{
                border: none;
                /*box-shadow: 5px 5px 5px #888888;*/
                /* border: solid 1px #0099ff;*/


            }
            .card-header{
                background-color:  #0099ff;
                color: white;
            }




        </style>


        <div class="container">
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">

                    <div style="height: 100px;"></div>

                    <div class="card">
                        <div class="card-header text-center">
                            Login
                        </div>
                        <div class="card-block">




                            <%

                                try {

                                    if (request.getParameter("error").equals("ok")) { %>

                            <div class="alert alert-danger" role="alert">
                                <strong>Warning!</strong> invalid username/password.
                            </div>

                            <% }

                                } catch (Exception e) {
                                }

                            %>

                            <form action="LoginServlet" method="Post">

                                <div class="form-group">
                                    <label for="formGroupExampleInput">Username:</label>
                                    <input required="" autofocus="true" type="text" name="user" id="" class="form-control" id="formGroupExampleInput" placeholder="Enter Username">
                                </div>


                                <div class="form-group">
                                    <label for="formGroupExampleInput2">Password:</label>
                                    <input type="password" name="pass" id="" class="form-control" required="">
                                </div>

                                <div class="text-right"> <input type="submit" value="Login" class="btn btn-primary"></div> 

                            </form>

                        </div>
                    </div></div>
                <div class="col-md-4"></div>
            </div>
        </div>


        <div id="wait" style="display:none;width:69px;height:89px;border:none;position:absolute;top:50%;left:50%;padding:2px; background: white">
            <img src='../preloader.gif' width="128" height="128" />
        </div>
        <script>
            $(document).ready(function () {
                // show the alert
                setTimeout(function () {
                    $(".alert").alert('close');
                }, 2000);
            });

            $(document).ready(function () {
                $(document).ajaxStart(function () {

                    $("#wait").css("display", "block");

                });
                $(document).ajaxComplete(function () {

                    $("#wait").css("display", "none");
                });

            });

            //---------------------------SORT JSON ARRAY------------------------------------

            var sort_by = function (field, reverse, primer) {

                var key = primer ?
                        function (x) {
                            return primer(x[field])
                        } :
                        function (x) {
                            return x[field]
                        };

                reverse = !reverse ? 1 : -1;

                return function (a, b) {
                    return a = key(a), b = key(b), reverse * ((a > b) - (b > a));
                }
            }

        </script>
    </body>
</html>

