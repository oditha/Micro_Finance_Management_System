<%@page import="Singleton.dateFormat"%>

<%

    PageTitleSet.getTitle().setPAGE_TITLE("Loan Stock");
    
    try {
        if (!session.getAttribute("UserType").toString().equals("Manager")) {

            response.sendRedirect("/CMC/errorPage/401Unauthorized.html");

        }
    } catch (Exception e) {
    }




%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/header.jsp"/>
<%@page import="Singleton.PageTitleSet"%>
<style>
    form .container{
        padding-top: 30px;
    }
    .btn-primary{
        color: white;
    }


</style>
<script>
    $('#collapseOne').collapse("hide");


</script>
<div style="height: 10px"></div>

<div style="height: 10px;"></div>
<div class="card">
    <div class="card-block">
        
        <div class="container">
            <div class="row">



                <div class="col-md-3">

                </div>

                <div class="col-md-3">
                    <div class="form-group">
                        <label for="formGroupExampleInput">Total Collection</label>
                        <input type="text" class="form-control" id="collection" placeholder="Total Collection" name="collection" disabled="">

                    </div>
                  

                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="formGroupExampleInput">Total NP Collection</label>
                        <input type="text" class="form-control" id="npcollection" placeholder="Total NP Collection" name="npcollection" disabled="">
                    </div>
              
                </div>
                <div class="col-md-3">
                    
                    
              
                </div>
               
            </div>
        </div>
      
    </div>

</div>





<jsp:include page="/footer.jsp"/>
