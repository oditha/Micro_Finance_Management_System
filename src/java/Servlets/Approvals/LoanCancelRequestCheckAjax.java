/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Approvals;

import ORM.Loan;
import ORM.Loancancellation;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author arshak
 */
@WebServlet(name = "LoanCancelRequestCheckAjax", urlPatterns = {"/LoanCancelRequestCheckAjax"})
public class LoanCancelRequestCheckAjax extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
     
        try {
            
           PrintWriter out = response.getWriter();
            
            Session sess = PoolManager.getSessionFactory().openSession();
            
            Criteria cr = sess.createCriteria(Loan.class);
           //cr.createAlias("Loan", "l");
//            cr.add(Restrictions.eq("idLoan",Integer.parseInt(request.getParameter("idloan"))));
//              Loancancellation uniqueResult = (Loancancellation) cr.uniqueResult();
            Loan uniqueResult = (Loan) cr.uniqueResult();
            
            
            if (uniqueResult != null) {
                
               Set loancancellations = uniqueResult.getLoancancellations();
                
                if (loancancellations.size()>0) {
                    out.write("OK");
                }else{
                
                
                out.write("OK");
                
                }
                
                
                
            }
            
            
            
          //  out.write(""+Integer.parseInt(request.getParameter("idloan")));
         // out.write(""+list.size());
            
            
            
            
            
            out.write("OK");
            sess.close();
            
            
            
            
            
            
        } catch (Exception e) {
            response.getWriter().print("OK");
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
