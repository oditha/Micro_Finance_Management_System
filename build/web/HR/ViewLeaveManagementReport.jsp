<%-- 
    Document   : LeaveManagement
    Created on : Nov 22, 2017, 2:20:39 PM
    Author     : iamarshrx
--%>

<%@page import="Singleton.dateFormat"%>
<%@page import="Singleton.PageTitleSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }

    PageTitleSet.getTitle().setPAGE_TITLE("Leave Management Report");%>
<jsp:include page="/header.jsp"/>


<!--<div style="height: 30px;"></div>-->



<!--<div style="height: 30px;"></div>-->

<div class="card">
    <div class="">

    </div>
    <div class="card-block">



        <div class="container">
            <div class="row">
                <div class="col-md-4">

                    <div class="form-group">
                        <label for="exampleSelect1">Select Month</label>
                        <select class="form-control" id="montselect">
                            <option value="00">Select Month</option>
                            <option value="01">January</option>
                            <option value="02">February</option>
                            <option value="03">March</option>
                            <option value="04">April</option>
                            <option value="05">May</option>
                            <option value="06">June</option>
                            <option value="07">July</option>
                            <option value="08">Augest</option>
                            <option value="09">September</option>
                            <option value="10">October</option>
                            <option value="11">November</option>
                            <option value="12">December</option>



                        </select>
                        <p style="color: red;" id="err">Please Select month</p>
                    </div>




                </div>
                <div class="col-md-4">

                    <div class="form-group">
                        <label for="formGroupExampleInput">Enter Year</label>
                        <input type="number" class="form-control" id="year" placeholder="Example input" value="<%=dateFormat.YearOnly()%>">
                    </div>
                    <div class="text-right">  <input type="submit" name="" id="Search" value="Search" class="btn btn-primary">   </div>

                </div>
                <div class="col-md-4">

                </div>
            </div>
        </div>







        <div class=" table-responsive ">          
            <table class="table table-stripped" id="leavetable">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Name</th>
                        <th>NIC</th>


                        <th>Total Days</th>

                        <th>View</th>



                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>



            <!--<div style="height: 30px;"></div>-->



        </div>
    </div>



</div>

<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="ldmodel">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Modal title</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <div class="table-responsive">          
                        <table class="table" id="viewtable">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Name</th>
                                    <th>Nic</th>
                                    <th>Leave type</th>
                                    <th>Requested Date</th>
                                    <th>From</th>
                                    <th>To</th>
                                    <th>Total Days</th>
                                    <th>Reason</th>
                                </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                    </div>
                </div>





            </div>
            <div class="modal-footer">







                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script>





    $(document).ready(function () {
        $('#leavetable').DataTable();




        $("#Search").click(function () {

            var month = $('#montselect').val();
            var year = $('#year').val();


            if (month != 00) {

                $('#err').hide();

                if (year.length <= 4 && year.length != 0) {



                    $.ajax({
                        type: 'POST',
                        url: '../LeaveReportServlet',

                        data: {month: month, year: year},
                        success: function (responseText) {


                            var json = JSON.parse(responseText);

                            if ($.fn.dataTable.isDataTable('#leavetable')) {
                                table = $('#leavetable').DataTable();
                                table.destroy();
                            }


                            $("#leavetable").DataTable({
                                data: json,
                                columns: [
                                    {data: 'id'},
                                    {data: 'nic'},
                                    {data: 'name'},
                                    {data: 'total'},
                                    {data: 'view'}


                                ]



                            });

                            $("#leavetable").css('width', '');

                        }

                    });










                }





            } else {
                $('#err').show();
            }




        });











    });






////$(document).ready(function() {
//
////     $( "button" ).on( "click", function() {
////  alert( "ED" );
////});
//
//
//
//    // $("button").click(function (e) {
//
//
    function ldk(stfid) {




        //var stfid = $(this).attr("stfid");
        var date = $('.cls').attr("date");
//            //var stfid  =$('.cls').attr('stfid');
        // var stfid =this.getAttribute("stfid");

//var stfid = obj.stfid;
       





            $.ajax({
                type: 'POST',
                url: '../LeavereportModalAjax',

                data: {id: stfid, date: date},
                success: function (responseText) {


                    var json = JSON.parse(responseText);

                    if ($.fn.dataTable.isDataTable('#viewtable')) {
                        table = $('#viewtable').DataTable();
                        table.destroy();
                    }


                    $("#viewtable").DataTable({
                        data: json,
                        columns: [
                            {data: 'id'},
                            {data: 'nic'},
                            {data: 'name'},
                            {data: 'ltype'},
                            {data: 'reqdate'},
                            {data: 'startdate'},
                            {data: 'finishdate'},
                            {data: 'total'},

                            {data: 'reason'}


                        ]



                    });

                    $("#leavetable").css('width', '');

                }

            });




       $('#ldmodel').modal('show');





        //  });


    }
//
//
//
////});








</script>



<jsp:include page="/footer.jsp"/>
