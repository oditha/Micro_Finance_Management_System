/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.HR;

import ORM.Resignation;
import ORM.Staff;

import Singleton.dateFormat;
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
@WebServlet(name = "AddResignation", urlPatterns = {"/AddResignation"})
public class AddResignation extends HttpServlet {

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

            String date = request.getParameter("date");
            String Username = request.getParameter("Username");
            String reason = request.getParameter("reason");
            String id = request.getParameter("id");
            String nic = request.getParameter("nic");

            int id1 = Integer.parseInt(id);

            String Pending = "Pending";

            try {
                HttpSession session = request.getSession();
                Session sess = PoolManager.getSessionFactory().openSession();
                Transaction tr = sess.beginTransaction();

                Staff staff = new Staff();
                staff.setIdStaff(id1);

                Resignation reg = new Resignation();

                reg.setResihnationDate(dateFormat.setDateFull(date));
                reg.setReason(reason);
                reg.setCreatedBy(Username);
                reg.setIsAproved(Pending);
                reg.setIsActive("Active");
                reg.setStaff(staff);
                reg.setRequestDate(dateFormat.DateFullCurrent());
                reg.setCreatedBy(session.getAttribute("userName").toString());

                sess.save(reg);

                tr.commit();

                if (tr.wasCommitted()) {

                    response.sendRedirect("HR/AddResignation.jsp?save=success");

                }
                sess.close();
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
