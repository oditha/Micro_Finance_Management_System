package Servlets.MicroFinance;

import ORM.Loan;
import ORM.Loancancellation;

import Singleton.dateFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;

@WebServlet(name = "RequestLoanCancellation", urlPatterns = {"/RequestLoanCancellation"})
public class RequestLoanCancellation extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            try {
                
                String user = request.getSession().getAttribute("userName").toString();
                
                String loanid = request.getParameter("idloan");
                String reason = request.getParameter("reason");           
                
                
                Session session = PoolManager.getSessionFactory().openSession();
                Transaction beginTransaction = session.beginTransaction();
                
                Loan loan = new Loan();
                loan.setIdLoan(Integer.parseInt(loanid));
                
                Loancancellation lc = new Loancancellation();
                
                lc.setCreaedBy(user);
                lc.setDate(dateFormat.DateFullCurrent());
                lc.setReason(reason);
                lc.setLoan(loan);
                lc.setIsActive("Active");
                lc.setIsAproved("Pending");
                
                session.save(lc);
                beginTransaction.commit();
                
                session.close();
                out.write("OK");
            } catch (Exception e) {
            
                out.write("error");
                
                e.printStackTrace();
                
            }
            
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
