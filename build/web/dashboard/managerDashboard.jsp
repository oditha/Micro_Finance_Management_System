<%-- 
    Document   : managerDashboard
    Created on : May 30, 2018, 1:49:52 PM
    Author     : danushka
--%>

<%@page import="Singleton.PageTitleSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }
    PageTitleSet.getTitle().setPAGE_TITLE("Manager DashBoard");

    try {
        if (!session.getAttribute("UserType").toString().equals("Manager")) {

            response.sendRedirect("/CMC/errorPage/401Unauthorized.html");

        }
    } catch (Exception e) {
    }


%>

<div class="container">
    <div class="row">

        <div class="col-md-12">

            <div class="card ">
                <div class="card-header bg-primary text-white">
                    Center vise members count
                </div>
                <div class="card-body">




                    <canvas id="centerMembers" height="70" ></canvas>
                    <script>

                        $(document).ready(function () {

                            $.ajax({

                                method: "post",
                                url: "MembersCount",
                                success: function (response) {

                                    var center = [];
                                    var count = [];
                                    data = response.trim();
                                    data = JSON.parse(response);

                                    for (var i in data) {
                                        center.push(data[i].Center);
                                        count.push(data[i].count);
                                    }

                                    var chartdata = {
                                        labels: center,
                                        datasets: [
                                            {
                                                label: 'Members Count',
                                                backgroundColor: 'rgba(54, 162, 235, 0.5)',
                                                borderColor: 'rgba(200, 200, 200, 0.1)',
                                                hoverBackgroundColor: 'rgba(153, 102, 255, 0.5)',
                                                hoverBorderColor: 'rgba(200, 200, 200, 1)',
                                                data: count
                                            }
                                        ]
                                    };

                                    var ctx = document.getElementById("centerMembers").getContext('2d');
                                    var myChart = new Chart(ctx, {
                                        type: 'bar',
                                        data: chartdata,
                                        options: {
                                            scales: {
                                                yAxes: [{
                                                        ticks: {
                                                            beginAtZero: true
                                                        }
                                                    }]
                                            }
                                        }
                                    });

                                }

                            });

                        });


                    </script>

                </div>
            </div>

        </div>



    </div>
<!--    <div style="height: 10px"></div>-->
    <div class="row">


        <div class="col-md-6">

            <div class="card">
                <div class="card-header bg-primary text-white">Executive vise Members</div>
                <div class="card-body">
                    <canvas id="exeMembers" height="150" ></canvas>

                    <script>

                        $(document).ready(function () {

                            $.ajax({

                                method: "post",
                                url: "ExeViceCount",
                                success: function (response) {

                                    var exe = [];
                                    var count = [];
                                    var color = [];
                                   
                                    data = response.trim();
                                    data = JSON.parse(response);

                                    for (var i in data) {
                                        exe.push(data[i].staff);
                                        count.push(data[i].count);
                                        color.push(data[i].color);
                                       
                                    }

                                    var chartdata = {
                                        labels: exe,
                                        datasets: [
                                            {

                                                backgroundColor: color,

                                                

                                                data: count
                                            }
                                        ]
                                    };

                                    var ctx = document.getElementById("exeMembers").getContext('2d');


                                    var myPieChart = new Chart(ctx, {
                                        type: 'pie',
                                        data: chartdata,

                                    });

                                }


                            });

                        });




                    </script>


                </div>

            </div>


        </div>

        <div class="col-md-6">

            <div class="card">
                <div class="card-header bg-primary text-white">Executive vise loans</div>
                <div class="card-body">
                    <canvas id="exeLoans" height="150" ></canvas>

                    <script>

                        $(document).ready(function () {

                            $.ajax({

                                method: "post",
                                url: "ExeViceLoans",
                                success: function (response) {

                                    var exe = [];
                                    var count = [];
                                    var color = [];
                                   
                                    data = response.trim();
                                    data = JSON.parse(response);

                                    for (var i in data) {
                                        exe.push(data[i].staff);
                                        count.push(data[i].count);
                                        color.push(data[i].color);
                                       
                                    }

                                    var chartdata = {
                                        labels: exe,
                                        datasets: [
                                            {

                                                label: 'Total Loans',
                                                backgroundColor: color,

                                                

                                                data: count
                                            }
                                        ]
                                    };

                                    var ctx = document.getElementById("exeLoans").getContext('2d');


                                    var myPieChart = new Chart(ctx, {
                                        type: 'bar',
                                        data: chartdata,
                                        options: {
                                            scales: {
                                                yAxes: [{
                                                        ticks: {
                                                            beginAtZero: true
                                                        }
                                                    }]
                                            }
                                        }

                                    });

                                }


                            });

                        });




                    </script>
                </div>

            </div>


        </div>

    </div>

</div>