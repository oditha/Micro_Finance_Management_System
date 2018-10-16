
<%@page contentType="text/html" pageEncoding="UTF-8"%>



<!--<footer class="footer">
    
      <div class="container">
          <div style="height: 15px"></div>
          <span class="text-right text-md-right float-right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;© 2018 Copyright: <a style="color: white" href="http://www.MiracleSolutions.lk" target="blank">MiracleSolutions.lk</a></span>
      </div>
    
</footer>-->
</div>
</div>
</div>

<!-------------------------Loading Image---------------------------------->
<div id="wait" style="display:none;width:69px;height:89px;border:none;position:absolute;top:50%;left:50%;padding:2px; background: white">
    <img src='../preloader.gif' width="128" height="128" />
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






</script>
</body>
</html>