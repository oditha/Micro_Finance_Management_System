<%-- 
    Document   : Resignation
    Created on : Nov 22, 2017, 5:02:46 PM
    Author     : iamarshrx
--%>

<%@page import="Singleton.PageTitleSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }

    PageTitleSet.getTitle().setPAGE_TITLE("Resignarion report");%>
<jsp:include page="/header.jsp"/>

<!--<div style="height: 10px;"></div>-->


<div class="card">
    <div class="">

    </div>
    <div class="card-block">

        

                <div class=" table-responsive ">          
                    <table class="table table-stripped" id="restable">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th>NIC</th>


                                <th>Request  Date</th>

                                <th>Resignation Date</th>



                                <th>Reason</th>



                            </tr>
                        </thead>
                        <tbody>





                        </tbody>
                    </table>



                    <!--<div style="height: 10px;"></div>-->




                </div>


            </div>
        </div>

   



        <script>

            $(document).ready(function () {


                $.ajax({
                    type: 'POST',
                    url: '../ResignationReportServlet',

                    success: function (responseText) {

//alert(responseText);
                        var json = JSON.parse(responseText);

                        if ($.fn.dataTable.isDataTable('#restable')) {
                            table = $('#restable').DataTable();
                            table.destroy();
                        }


                        $("#restable").DataTable({
                            data: json,
                            columns: [
                                {data: 'no'},
                                {data: 'nic'},
                                {data: 'name'},
                                {data: 'reqdate'},
                                {data: 'resdate'},
                                {data: 'reason'}



                            ]



                        });


                        $("#restable").css('width', '');

                    }

                });




            });



            $('#restable').DataTable();
        </script>



        <jsp:include page="/footer.jsp"/>