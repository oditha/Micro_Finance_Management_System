/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Accounts;

import ORM.LoanAccount;
import Singleton.dateFormat;
import Singleton.decimalFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author arshak
 */
@WebServlet(name = "ViewLoanAccountsAjax", urlPatterns = {"/ViewLoanAccountsAjax"})
public class ViewLoanAccountsAjax extends HttpServlet {

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
            
            String from = request.getParameter("from");
            String to = request.getParameter("to");
            
            
            
            Session sess = PoolManager.getSessionFactory().openSession();
            Criteria cr = sess.createCriteria(LoanAccount.class);
            cr.add(Restrictions.eq("isActive", "Active"));
            cr.add(Restrictions.between("accDate", dateFormat.setDateFull(from), dateFormat.setDateFull(to)));
            List<LoanAccount> list = cr.list();
            
            
            JSONArray arr = new JSONArray();
            
            for (LoanAccount loanAccount : list) {
                
                JSONObject jo = new JSONObject();
                jo.put("date", loanAccount.getAccDate());
                jo.put("Description", loanAccount.getDescription());
                jo.put("Credit",decimalFormat.setAmount(loanAccount.getCredit()));
                jo.put("Debit",decimalFormat.setAmount(loanAccount.getDebit()));
                
                arr.put(jo);
                
                
                
                
            }
            sess.close();
           out.write( arr.toString());
            
            
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
