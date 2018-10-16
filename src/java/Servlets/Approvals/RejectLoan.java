/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Approvals;

import ORM.Loan;
import ORM.Repayment;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author arshak
 */
@WebServlet(name = "RejectLoan", urlPatterns = {"/RejectLoan"})
public class RejectLoan extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            
            int id = Integer.parseInt(request.getParameter("hid"));
            
            Session sess = PoolManager.getSessionFactory().openSession();
            
            Transaction tr = sess.beginTransaction();
            
            Criteria cr = sess.createCriteria(Loan.class);
            
            cr.add(Restrictions.eq("idLoan", id));
            
            Loan loan = (Loan) cr.uniqueResult();
            loan.setIsAprove("Rejected");
            loan.setIsActive("Deactive");
            loan.setStatus("Paid");
            sess.update(loan);
            
            Iterator<Loan> iterator = loan.getMembers().getLoans().iterator();
            while (iterator.hasNext()) {
                Loan l = iterator.next();
                Iterator<Repayment> itt = l.getRepayments().iterator();
                while (itt.hasNext()) {
                    Repayment re = itt.next();
                    String isActive = re.getIsActive();
                    String isAproved = re.getIsAproved();
                    
                    if (isActive.equals("Renew") && isAproved.equals("Renew")) {
                        
                        re.setIsActive("Deactive");
                        sess.update(re);
                        
                    }
                }
            }
            
            tr.commit();
            
            out.write("ok");
            sess.close();
            
        } catch (Exception e) {
            out.write("error");
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
