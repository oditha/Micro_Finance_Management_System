<%@page import="java.util.List"%>
<%@page import="ORM.Center"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="org.hibernate.Session"%>
<%@page import="Srcs.PoolManager"%>
<%@page import="Srcs.PoolManager"%>
<%@page import="Singleton.PageTitleSet"%>
<%
    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }
    PageTitleSet.getTitle().setPAGE_TITLE("Add Loan All");
    try {
        if (!session.getAttribute("UserType").toString().equals("Manager")) {

            response.sendRedirect("/CMC/errorPage/401Unauthorized.html");

        }
    } catch (Exception e) {
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/header.jsp"/>
<div style="height: 10px;"></div>
<div class="container">
    <div class="row">
        <div class="col-md-4">
            <div class="form-group">
                <label for="exampleFormControlSelect1">Select Center</label>
                <select class="form-control" id="center">
                    <option value="0">Select</option>
                    <%                                //

                        Session sess = PoolManager.getSessionFactory().openSession();

                        Criteria cr = sess.createCriteria(Center.class);
                        //Criteria cr = PoolManager.getSessionFactory().openSession().createCriteria(Center.class);
                        cr.add(Restrictions.eq("isActive", "Active"));
                        cr.add(Restrictions.eq("isApprove", "Approve"));

                        List<Center> l = cr.list();

                        for (Center c : l) {%>

                    <option value="<%= c.getIdCenter()%>"><%= c.getCenterNo() + " - " + c.getCenterName()%></option>

                    <%    }
                        sess.close();


                    %>
                </select>
            </div>



        </div>
        <div class="col-md-4">

            <div class="form-group">
                <label for="exampleFormControlSelect1">Example select</label>
                <input type="date" class="form-control" id="date" placeholder="">
            </div>



        </div>
        <div class="col-md-4"><button id="filter" class="btn btn-primary">Filter</button></div>

        <div class="container">

            <div class=" table-responsive ">          
                <table class="table table-stripped" id="repayTable">
                    <thead>
                        <tr>
<!--                            <th>Checked</th>-->
                            <th >member id</th>
                            <th >Contract No</th>
                            <th >Loan Date</th>
                            <th >Member No</th>
                            <th>Member name</th>
                            <th>Loan Index</th>
                            <th>Loan Amount</th>
                            <th>Interest</th>
                            <th>Period</th>
                            <th>Installment</th>
                            <th>Repayment Day</th>
                            <th>Member fee</th>
                            <th>Guaranteer 1</th>
                            <th>Guaranteer 2</th>

                        </tr>
                    </thead>
                    <tbody id="bd">







                    </tbody>
                </table>

                <div style="height: 10px;"></div>

            </div>

            <div class="text-right"><button class="btn btn-primary btnsave">Save</button></div>  
        </div>
    </div>
</div>


<script>

    //------------------------------------Generate Contract No----------------------
    var val;
    $(document).ready(function () {


$(document).ready(function() {
    $('table').DataTable( {
        dom: 'Bfrtip',
        buttons: [
            'copy', 'csv', 'excel', 'pdf', 'print'
        ]
    } );
} );






        setInterval(function () {

            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {

//            alert(this.responseText);

                    val = this.responseText;


                    //   $(".contractNo").val(val);



                }
            };
            xmlhttp.open("GET", "../GenContractNO", true);
//            xmlhttp.setRequestHeader("Content-Type", "application/x-www-from-urlencoded");

            xmlhttp.send();


        }, 1000);

    });


    $(document).ready(function () {



        $('#center').select2({
            
            width:'100%',
            
        });

        $('#filter').click(function () {

            //$("#bd tr").remove();
            $("tbody").children().remove();

            var center = $('#center :selected').val();
            var date = $('#date').val();



            if (center != 0 && date != "") {





                $.ajax({
                    method: 'post',
                    url: '../LoadAddloanBulk',
                    data: {value: center},
                    success: function (response) {

                        var jr = JSON.parse(response);
//alert(response);

                        for (var i = 0; i < jr.length; i++) {

                            $('#bd').append("<tr>");

                         //   $('#bd').append("<td>" + "<input class=" + "form-check-input" + " type=" + "checkbox" + " id=" + "invalidCheck" + ">" + "</td>");
                            $('#bd').append("<td id=" + "idmember" + " memid=" + jr[i].memberid + "   class=" + "cls" + " >" + jr[i].memberid + "</td>");
                            $('#bd').append("<td >" + val + "</td>");
                            $('#bd').append("<td >" + $('#date').val() + "</td>");
                            $('#bd').append("<td >" + jr[i].memberno + "</td>");
                            $('#bd').append("<td>" + jr[i].membername + "</td>");
                            $('#bd').append("<td>" + jr[i].loanindex + "</td>");
                            $('#bd').append("<td>" + jr[i].loanamount + "</td>");
                            $('#bd').append("<td>" + jr[i].interest + "</td>");
                            $('#bd').append("<td>" + jr[i].period + "</td>");
                            $('#bd').append("<td>" + jr[i].installment + "</td>");
                            $('#bd').append("<td>" + jr[i].centerday + "</td>");
                            $('#bd').append("<td>" + jr[i].memberfee + "</td>");
                            //  $('#bd').append("<td>" + jr[i].g1 + "</td>");
                            $('#bd').append("<td>" + jr[i].g1.split("+")[0] + "</td>");
                            $('#bd').append("<td>" + jr[i].g1.split("+")[1] + "</td>");
// //var gr2 =jr[i]. Gar.split("+")[1];



                            $('#bd').append("</tr>");
                            //   alert(jr[i].memberno);


  if ($.fn.dataTable.isDataTable('#tableView')) {
                        table = $('#tableView').DataTable();
                        table.destroy();
                    }


                    $("#tableView").DataTable({
                        dom: 'Bfrtip',
                        "order": [[1, "asc"]],
                        buttons: [
                            'copy',
                            {
                                extend: 'excel',
                                messageTop: 'The information in this table is copyright to Sirius Cybernetics Corp.'
                            },
                            {
                                extend: 'pdf',
                                messageBottom: null
                            },
                            {
                                extend: 'print',
                                title: '<div class=' + 'text-center' + '><h4>Canto Micro Commercial Investment (Pvt) Ltd <br> Disbursement Sheet</h4>  </div>',
                                messageTop: '<div class=' + 'text-center' + '>Center: ' + Center + '</div>'
                                ,
                                messageBottom: null
                            }
                        ],
                        data: json,
                        columns: [
                            {data: 'Count'},
                            {data: 'MemNO'},
                            {data: 'MemName'},
                            {data: 'Memberfee'},
                            {data: 'Loanamo'},
                            {data: 'paidAmo'},
                            {data: 'Installment'},
                            {data: 'sign'}
                        ]

                    });

                        }







                        //     alert(response);






                    }



                });

            }


        });
//
        $(".btnsave").click(function () {


            jsonObject = [];


            var table = document.getElementsByTagName("table")[0];
            var tbody = table.getElementsByTagName("tbody")[0];
            var data = [];
//e = e || window.event;
            //var data = [];
            //var target = e.srcElement || e.target;


            var cells = tbody.getElementsByTagName("tr");
            var c = tbody.getElementsByTagName("td");
            for (var i = 0; i < cells.length; i++) {

                for (var j = 0; j < c.length; j++) {


                if (j=2) {
    


                    data.push(c[j].innerHTML);

}
                }



            }

            alert(data);




//            var table = $("#bd");
//
//
//            table.find("tr").each(function (i) {
//
//                var $tds = $(this).find("td");
//                memid = $tds.eq(2).text();
//     stringify(jsonObject);
////        
//            alert(json);           
//
//                item = {};
//                item["memid"] = memid;
//
//
//                jsonObject.push(item);
//
//
//
//
//            });
//
//   var json = JSON.stringify(jsonObject);
////        
//            alert(json);


        });



    });
</script>


<jsp:include page="/footer.jsp"/>
