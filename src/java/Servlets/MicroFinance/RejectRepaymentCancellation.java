package Servlets.MicroFinance;

import ORM.Repaymentcancellation;

import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

@WebServlet(name = "RejectRepaymentCancellation", urlPatterns = {"/RejectRepaymentCancellation"})
public class RejectRepaymentCancellation extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            try {
                 PrintWriter out = response.getWriter();
            Session sess = PoolManager.getSessionFactory().openSession();
            Criteria cr = sess.createCriteria(Repaymentcancellation.class);
            cr.add(Restrictions.eq("idRepaymentCancellation", Integer.parseInt(request.getParameter("hid"))));
            Repaymentcancellation uniqueResult = (Repaymentcancellation) cr.uniqueResult();
            Transaction tr = sess.beginTransaction();
            
            
            if (uniqueResult!=null) {
                
                uniqueResult.setIsAproved("Rejected");
                //uniqueResult.getRepayment().setIsActive("Deactive");
                tr.commit();
             
                
              if (tr.wasCommitted()) {
                    response.sendRedirect("../CMC/Approvals/LoanRepaymentCancellationAprovel.jsp?reject=success");
                }
                
                
            }
            
              
            
            
               sess.close();
            } catch (Exception e) {
            
            e.printStackTrace();
            
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
