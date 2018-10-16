<%-- 
    Document   : ResignationAproval
    Created on : Dec 24, 2017, 3:22:30 PM
    Author     : iamarshrx
--%>

<%@page import="Srcs.PoolManager"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="ORM.Resignation"%>
<%@page import="org.hibernate.Session"%>

<%@page import="Singleton.PageTitleSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    if (session.getAttribute("userName") == null) {

        response.sendRedirect("../newlogin.jsp");

    }
    PageTitleSet.getTitle().setPAGE_TITLE("Resignation Aprovals");

    try {
        if (!session.getAttribute("UserType").toString().equals("Manager")) {

            response.sendRedirect("/CMC/errorPage/401Unauthorized.html");

        }
    } catch (Exception e) {
    }


%> 
<jsp:include page="/header.jsp"/>




<%    if (request.getParameter("status") != null) {
%>

<script>

    swal("Success!", "you have Approved a Resignation request", "success");


</script>




<%
    }


%>
<%    if (request.getParameter("rejected") != null) {
%>

<script>


    swal("Successfully Rejected", "you have Successfully Rejected a Resignation", "error");


</script>




<%
    }


%>


<!--<div class="card">
    <div class="card-block">-->

        <table class="table">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Nic</th>
                    <th>Requested Date</th>
                    <th>Resignation Date</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%                    Session sess = PoolManager.getSessionFactory().openSession();
                    Criteria cr = sess.createCriteria(Resignation.class);
                    cr.add(Restrictions.eq("isActive", "Active"));
                    cr.add(Restrictions.eq("isAproved", "Pending"));

                    List<Resignation> l = cr.list();

                    for (Resignation r : l) {%>


                <tr>
                    <td><%=r.getStaff().getName()%></td>
                    <td><%=r.getStaff().getNic()%></td>
                    <td><%=r.getRequestDate()%></td>
                    <td><%=r.getResihnationDate()%></td>
                    <td><a class="btn btn-success btn-sm"   id="<%=r.getIdResignation()%>" onclick="clk(this.id)">View</a></td>

                </tr>







                <%

                    }
                    sess.close();

                %>
            </tbody>
        </table>
<!--    </div>
</div>-->



<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="mym">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">


            <div class="modal-body">

                <form action="action">


                    <div class="form-group">
                        <label for="formGroupExampleInput">Requested Date</label>
                        <input type="text" class="form-control" id="reqdate" placeholder="Example input">
                    </div>
                    <div class="form-group">
                        <label for="formGroupExampleInput">Resignation Date</label>
                        <input type="text" class="form-control" id="resdate" placeholder="Example input">
                    </div>
                    <div class="form-group">
                        <label for="formGroupExampleInput">Reason</label>

                        <textarea class="form-control" id="reason">
                            

                        </textarea>
                    </div>




                </form>

            </div>
            <div class="modal-footer">

                <form action="../AproveResignationServlet">    
                    <input type="text"   id="hid" class="hid " name="hid" hidden="">
                    <input type="submit" value="Approve" class="btn btn-success">


                </form>
                <form action="../RejectResignation">   


                    <input type="text"   id="hid" class="hid " name="hid" hidden="">
                    <input type="submit" value="Reject" class="btn btn-danger">





                </form>


            </div>





        </div>
    </div>
</div>







<script>

    function clk(sid) {







        $.ajax({
            url: '../AproveResignation',
            data: {ID: sid},
            success: function (responseText) {



                var json = JSON.parse(responseText);



                for (var i = 0; i < json.length; i++) {

                    var nic = json[i].nic;
                    var name = json[i].name;
                    var reqdate = json[i].reqdate;
                    var resdate = json[i].resdate;
                    var reason = json[i].reason;






                }

                $('#reqdate').val(reqdate);
                $('#resdate').val(resdate);
                $('#reason').val(reason);
                $('.hid').val(sid);









            }


        });



        $('#mym').modal('show');







    }









</script>




<jsp:include page="/footer.jsp"/>