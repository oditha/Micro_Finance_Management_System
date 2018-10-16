/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.HR;

import ORM.Deductions;
import ORM.Staff;
import ORM.StaffHasDeductions;

import Singleton.dateFormat;
import Singleton.decimalFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author iamarshrx
 */
@WebServlet(name = "AddDeductionAjaxServlet", urlPatterns = {"/AddDeductionAjaxServlet"})
public class AddDeductionAjaxServlet extends HttpServlet {

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
            
            HttpSession session = request.getSession();
            
            String staffid = request.getParameter("staffid");
            String tdtype = request.getParameter("tdtype");
            String tDamount = request.getParameter("tDamount");
            
            try {
                
                Session sess = PoolManager.getSessionFactory().openSession();
                
                Transaction tr = sess.beginTransaction();
                
                Deductions d = new Deductions();
                Staff staff = new Staff();
                StaffHasDeductions std = new StaffHasDeductions();
                
                d.setIdDeductions(Integer.parseInt(tdtype));
                staff.setIdStaff(Integer.parseInt(staffid));
                
                std.setStaff(staff);
                std.setDeductions(d);
                std.setDate(dateFormat.DateFullCurrent());
                std.setAmount(decimalFormat.setAmount(Double.parseDouble(tDamount)));
                std.setIsActive("Active");
                std.setIsaprove("aprove");
                std.setCreatedBy(session.getAttribute("userName").toString());
                
                sess.save(std);
                
                tr.commit();
                
                if (tr.wasCommitted()) {
                    out.write("success");
                }
                sess.close();
            } catch (Exception e) {
                
                throw new HibernateException(e);
                
            }
            
        } catch (Exception e) {
            throw new ServletException();
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
