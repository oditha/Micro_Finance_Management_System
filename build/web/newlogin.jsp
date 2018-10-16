<%@page import="net.sf.jasperreports.engine.JasperReport"%>
<%@page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@page import="java.io.InputStream"%>
<%@page import="Singleton.PageTitleSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%

    if (session.getAttribute("userName") != null) {

        response.sendRedirect("/CMC/index.jsp");

    }

    PageTitleSet.getTitle().setPAGE_TITLE("Login");

%>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>MicroCredit V1.0</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="robots" content="all,follow">
        <!-- Bootstrap CSS-->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">

        <!-- Font Awesome CSS-->
        <link rel="stylesheet" href="res/vendor/font-awesome/css/font-awesome.min.css">
        <!-- Fontastic Custom icon font-->
        <link rel="stylesheet" href="res/css/fontastic.css">
        <!-- Google fonts - Roboto -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700">
        <!-- jQuery Circle-->
        <link rel="stylesheet" href="res/css/grasp_mobile_progress_circle-1.0.0.min.css">
        <!-- Custom Scrollbar-->
        <link rel="stylesheet" href="res/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.css">
        <!-- theme stylesheet-->
        <link rel="stylesheet" href="res/css/style.blue.css" id="theme-stylesheet">
        <!-- Custom stylesheet - for your changes-->
        <link rel="stylesheet" href="res/css/custom.css">
        <!-- Favicon-->
        <link rel="shortcut icon" href="res/img/favicon.ico">
        <!-- Tweaks for older IEs--><!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
            <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


    </head>
    <body>

        <%             try {

                if (request.getParameter("error").equals("ok")) { %>

        <script>


            swal("Oops", "Invalid Username or Password!", "error");


        </script>

        <% }

            } catch (Exception e) {
            }

        %>

        <div class="page login-page">
            <div class="container">
                <div class="form-outer text-center d-flex align-items-center">
                    <div class="form-inner">
                        <div class="logo text-uppercase"><strong class="text-primary">MicroCredit WEB</strong></div>
                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud.</p>
                        <form method="POST" class="text-left form-validate" action="LoginServlet">
                            <div class="form-group-material">
                                <input id="login-username" type="text" name="user" required data-msg="Please enter your username" class="input-material">
                                <label for="login-username" class="label-material">Username</label>
                            </div>
                            <div class="form-group-material">
                                <input id="login-password" type="password" name="pass" required data-msg="Please enter your password" class="input-material">
                                <label for="login-password" class="label-material">Password</label>
                            </div>
                            <div class="form-group text-center">
                                
                                <input type="submit" class="btn btn-primary" value="Login">
                                
                            </div>
                        </form>
                        <!--<a href="#" class="forgot-pass">Forgot Password?</a><small>Do not have an account? </small><a href="register.html" class="signup">Signup</a>-->
                    </div>
                    <div class="copyrights text-center">
                        <p>Design by <a href="https://miraclesolutions.lk" class="external">Miracle Solutions</a></p>
                        <!-- Please do not remove the backlink to us unless you support further theme's development at https://bootstrapious.com/donate. It is part of the license conditions. Thank you for understanding :)-->
                    </div>
                </div>
            </div>
        </div>
        <!-- JavaScript files-->
        <script src="res/vendor/jquery/jquery.min.js"></script>
        <script src="res/vendor/popper.js/umd/popper.min.js"></script>
        <script src="res/vendor/bootstrap/js/bootstrap.min.js"></script>
        <script src="res/js/grasp_mobile_progress_circle-1.0.0.min.js"></script>
        <script src="res/vendor/jquery.cookie/jquery.cookie.js"></script>
        <script src="res/vendor/chart.js/Chart.min.js"></script>
        <script src="res/vendor/jquery-validation/jquery.validate.min.js"></script>
        <script src="res/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
        <!-- Main File-->
        <script src="res/js/front.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    </body>
</html>