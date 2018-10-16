/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Executive;

import Servlets.HR.*;
import ORM.Staff;
import ORM.Staffleave;

import Singleton.dateFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author iamarshrx
 */
@WebServlet(name = "AddLeaveServletExecutive", urlPatterns = {"/AddLeaveServletExecutive"})
public class AddLeaveServletExecutive extends HttpServlet {

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

            String Leavetype = request.getParameter("Leavetype");
            String StartDate = request.getParameter("StartDate");
            String EndDate = request.getParameter("EndDate");

            String Tdays = request.getParameter("Tdays");
            String reason = request.getParameter("reason");
            String id = request.getParameter("id");
            int id1 = Integer.parseInt(id);

            try {

                Session sess =PoolManager.getSessionFactory().openSession();
               
                Transaction tr=sess.beginTransaction();
                
                Staffleave staffleave = new Staffleave();
                Staff staff = new Staff();
                staff.setIdStaff(id1);
                staffleave.setLeaveType(Leavetype);
                staffleave.setStartDate(dateFormat.setDateFull(StartDate));
                staffleave.setTotalDays(Tdays);
                staffleave.setEndDate(dateFormat.setDateFull(EndDate));
                staffleave.setReason(reason);
                staffleave.setRequestedDate(dateFormat.DateFullCurrent());
                
                staffleave.setIsActive("Active");
                staffleave.setIsAprove("Pending");
                
                staffleave.setStaff(staff);
                
                sess.save(staffleave);
                
                tr.commit();
                
                
                sess.close();
                    response.sendRedirect("Executive/AddLeaveManagementExecutive.jsp?save=success");
                
                
            
            
            
            
            } catch (Exception e) {

                throw new HibernateException(e);

            }

        } catch (Exception e) {
            throw new ServletException(e);
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
