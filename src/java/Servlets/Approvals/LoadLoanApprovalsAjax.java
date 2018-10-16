/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Approvals;

import ORM.Loan;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author arshak
 */
@WebServlet(name = "LoadLoanApprovalsAjax", urlPatterns = {"/LoadLoanApprovalsAjax"})
public class LoadLoanApprovalsAjax extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            PrintWriter out = response.getWriter();
            int id =Integer.parseInt(request.getParameter("ID"));
           
            Session sess = PoolManager.getSessionFactory().openSession();
            Criteria cr = sess.createCriteria(Loan.class);
            cr.add(Restrictions.eq("idLoan", id));
            
            List<Loan> l = cr.list();
            JSONArray arr = new JSONArray();
            
            for (Loan loan : l) {
                
                Set<Loan> loans = loan.getMembers().getLoans();
                
                loans.size();
                
                JSONObject jo = new JSONObject();
                
                jo.put("memberid", loan.getMembers().getMemberNo());
                jo.put("membername", loan.getMembers().getNameWithInitials());
                jo.put("ContractNo", loan.getContractNo());
                jo.put("Loanindex", loan.getLoanIndex());
                jo.put("Loaninterest", loan.getLoanInterest());
                jo.put("Loaninstallment", loan.getLoanInstallment());
                jo.put("LoanPeriod", loan.getLoanPeriod());
                jo.put("LoanAmount", loan.getLoanAmount());
                
                jo.put("MemberFee", loan.getMemberfee());
                jo.put("LoanDate", loan.getLoanDate());
                jo.put("RepaymentDay", loan.getRepaymentDay());
                jo.put("Guarantor1", loan.getGaranter1());
                jo.put("Guarantor2", loan.getGaranter2());
                jo.put("renewAmount", loan.getRenewAmount());
                jo.put("issuedate", loan.getIssueDate());
                
                arr.put(jo);
                
                
                
                
                
                
                
            }
            
            
            sess.close();
            out.print(arr.toString());
            
            
        } catch (Exception e) {
            
            
            throw  new ServletException(e);
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
