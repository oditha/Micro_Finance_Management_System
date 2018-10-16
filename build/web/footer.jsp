<%-- 
    Document   : newfooter
    Created on : May 29, 2018, 7:33:55 PM
    Author     : danushka
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="Modals.jsp"/>
</div>
</section>
<footer class="main-footer">
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-6">
                <p>Micro Credit V1.0 &copy; 2017-2019</p>
            </div>
            <div class="col-sm-6 text-right">
                <p>Developed by <a href="https://miraclesolutions.lk" class="external">MS | 0771981680</a></p>
                <!-- Please do not remove the backlink to us unless you support further theme's development at https://bootstrapious.com/donate. It is part of the license conditions and it helps me to run Bootstrapious. Thank you for understanding :)-->
            </div>
        </div>
    </div>
</footer>
</div>

<!-------------------------Loading Image---------------------------------->
<div id="wait" style="display:none;width:69px;height:89px;border:none;position:absolute;top:50%;left:50%;padding:2px; background: white">
    <img src='/CMC/Preloader_8.gif' width="128" height="128" />
</div>
<script>

    //-----------------------------Automatic logout---------------------------------

    $(document).ready(function () {

        setInterval(function () {

            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {

                    if (this.responseText === "logout") {

                        window.location.replace("/CMC/newlogin.jsp");
                    }

                }
            };
            xmlhttp.open("GET", "/CMC/AutomaticLogout", true);
            xmlhttp.send();


        }, 1000);

    });

    $(document).ready(function () {
        // show the alert
        setTimeout(function () {
            $(".alert").alert('close');
        }, 5000);
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

    function sendReq() {
        //Validate Brouser Version
        var xmlHttp;
        if (window.XMLHttpRequest) {
            xmlHttp = new XMLHttpRequest();
        } else if (window.ActiveXObject) {
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        } else {
            alert("Browser Not Supported");
        }

        if (xmlHttp !== null) {

            xmlHttp.onreadystatechange = function () {
//                        alert(xmlHttp.readyState);
                if (xmlHttp.readyState === 4) {
                    if (xmlHttp.status === 200) {
                        var res = xmlHttp.responseText;


                        var json = JSON.parse(res);

                        for (var i = 0; i < json.length; i++) {
                            var res1 = json[i].res;
                            var leave = json[i].leave;
                            var loan = json[i].loan;


                        }

                        document.getElementById("resap").innerHTML = res1;
                        document.getElementById("leaveap").innerHTML = leave;
                        document.getElementById("Loanaprovel").innerHTML = loan;
                        document.getElementById("apnoti").innerHTML = parseInt(res1) + parseInt(leave) + parseInt(loan);

                    }
                }

            };

            //ajax function code

            xmlHttp.open("POST", "AprovalNotifications", true);
            xmlHttp.setRequestHeader("Content-Type", "application/x-www-from-urlencoded");
            xmlHttp.send(null);
        }
    }

    $(document).ready(function startTimer() {


        //setInterval('sendReq()', 1000);

    });



    $(document).ready(function () {
        $('select').not('.yourExcludeClass').select2({

//            width: '100%',
//            theme: "classic"
//            theme: "bootstrap"

        });
    });

//------------------Repayment Sheet --------------

    $(".repayment").click(function () {
        $("#centerselect").empty();
        $("#centerselect").append('<option>Select</option>');
        $.ajax({

            url: "/CMC/LoadCenterRepaymentSheet",
            method: "Post",
            success: function (data) {

                if (data !== "err") {

                    var json = JSON.parse(data);
                    for (var i = 0; i < json.length; i++) {

                        $('#centerselect').append($('<option>', {
                            value: json[i].id,
                            text: json[i].name
                        }))

                    }
                    $("#repaymentSheetModal").modal();

                } else {

                    swal("Oops!", "Something went wrong. Try again!", "error");

                }

            }


        });


    });

//---------------------------open Jasper-------------------------------------------------------

//    $(document).ready(function () {

    $("#requestsheet").click(function () {

        var id = $("#centerselect").find(":selected").val();


        $.ajax({

            url: "/CMC/RepaymentSheetJasper",
            method: "POST",
            data: {id: id},
            success: function (data) {

                if (data !== "error") {

                    window.open("/CMC/RepaymentSheet.jsp");

                } else {

                    swal("Oops!", "Something went wrong. Try again!", "error");

                }

            }


        });


    });


    //------------------Disbursement Sheet --------------

    $(".Disbursement").click(function () {
        $("#exeselect").empty();
        $("#exeselect").append('<option>Select</option>');
        $.ajax({

            url: "/CMC/LoadExecutiveDisbrustmentSheet",
            method: "Post",
            success: function (data) {

                if (data !== "err") {

                    var json = JSON.parse(data);
                    for (var i = 0; i < json.length; i++) {

                        $('#exeselect').append($('<option>', {
                            value: json[i].id,
                            text: json[i].name
                        }))

                    }
                    $("#DisbursementModal").modal();

                } else {

                    swal("Oops!", "Something went wrong. Try again!", "error");

                }

            }


        });


    });


    //---------------------------open Jasper-------------------------------------------------------

//    $(document).ready(function () {

    $("#Disbursementsheet").click(function () {

        var id = $("#exeselect").find(":selected").val();
        var idtext = $("#exeselect").find(":selected").text();;
        var date = $("#daysdis").val();

        if (idtext !== "Select" && date !== "") {


            $.ajax({

                url: "/CMC/ViewDisbursmentJasper",
                method: "POST",
                data: {stfid: id,dates:date, exe:idtext},
                
                success: function (data) {

                    if (data === "OK") {
//                        alert(data);
                        window.open("/CMC/DisbrustmentSheet.jsp");

                    } else {

                        swal("Oops!", "Something went wrong. Try again!", "error");

                    }

                }


            });

        } else {

            swal("Warning!", "Select Executive and Date!", "warning");


        }


    });


//    })
//--------------loding animation

//    $(window).load(function () {
//        // Animate loader off screen
//        $(".se-pre-con").css("display", "none");
//        ;
//    });

</script>

<!--     JavaScript files
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/popper.js/umd/popper.min.js"> </script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="js/grasp_mobile_progress_circle-1.0.0.min.js"></script>
    <script src="vendor/jquery.cookie/jquery.cookie.js"> </script>
    <script src="vendor/chart.js/Chart.min.js"></script>
    <script src="vendor/jquery-validation/jquery.validate.min.js"></script>
    <script src="vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min.js"></script>
     Main File
    <script src="js/front.js"></script>-->
</body>

<!--<div class="se-pre-con"></div>-->

</html>