<%-- 
    Document   : test
    Created on : Apr 5, 2018, 8:42:45 PM
    Author     : arshak
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"/>

<table border="1">
    <thead>
        <tr>
            <th>No</th>
            <th>Name</th>
        </tr>
    </thead>
    <tbody>
        <%

            for (int i = 0; i < 10; i++) {

        %>
        <tr> <td><%= "ab"+i++%></td>
            <td><%= "bc"+i--%></td>
        </tr>
        <%

            }


        %>

    <a class="btnsave">sss</a>

</tbody>
</table>




<script>


    $(document).ready(function () {


        $(".btnsave").click(function () {


            var table = document.getElementsByTagName("table")[0];
            var tbody = table.getElementsByTagName("tbody")[0];
            var data = [];
//e = e || window.event;
            var data = [];
            //var target = e.srcElement || e.target;


            var cells = tbody.getElementsByTagName("td");
            for (var i = 0; i < cells.length; i++) {
                data.push(cells[i].innerHTML);


            }

            alert(data);
//
//            var table = $("table td");
//            jsonObject = [];
//
//
//            table.find("tr").each(function (i) {
//
//                var $tds = $(this).find("td");
//                memid = $tds.eq(1).text();
//                
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


<jsp:include page="footer.jsp"/>
