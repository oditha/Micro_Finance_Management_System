<%-- 
    Document   : PreviewReceipt
    Created on : Mar 9, 2018, 10:08:38 AM
    Author     : oditha
--%>

<%@page import="Servlets.MicroFinance.AddRepaymentServlet"%>
<%@page import="Singleton.DBJasper"%>
<%@page import="Servlets.LoginServlet"%>
<%@page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="net.sf.jasperreports.engine.JasperFillManager"%>

<%@page import="net.sf.jasperreports.engine.JasperReport"%>
<%@page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="application/pdf"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Print Preview</title>
    </head>
    <body>
        <%

            try {

                Map<String, Object> mp = new HashMap();
                mp.put("Repaymentmicrocredit", AddRepaymentServlet.id);

                System.err.println(mp);

                JasperPrint jp = JasperFillManager.fillReport(LoginServlet.jr, mp, DBJasper.getCon());
                JasperExportManager.exportReportToPdfStream(jp, response.getOutputStream());

            } catch (Exception e) {

                e.printStackTrace();

            }

        %>
        
        <script>
            
            $(document).ready(function () { window.print(); });

            
        </script>
        
        
        
    </body>
</html>
