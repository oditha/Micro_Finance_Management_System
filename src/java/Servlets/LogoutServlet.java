/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import ORM.Staffattedence;

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
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author iamarshrx
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/LogoutServlet"})
public class LogoutServlet extends HttpServlet {

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

        Session sess2;
        int id = 0;
        Criteria cr2 = null;
        Transaction tr = null;

        try {
            PrintWriter out = response.getWriter();
            HttpSession session = request.getSession();

            try {
                id = Integer.parseInt(session.getAttribute("id").toString());

            } catch (Exception e) {
            }

            try {
                sess2 = PoolManager.getSessionFactory().openSession();
                cr2 = sess2.createCriteria(Staffattedence.class);
                tr = sess2.beginTransaction();
                cr2.createAlias("staff", "s");
                cr2.add(Restrictions.eq("s.idStaff", id));
                cr2.add(Restrictions.eq("date", dateFormat.DateFullCurrent()));

                Staffattedence staffattedence = (Staffattedence) cr2.uniqueResult();

                staffattedence.setOuttime(dateFormat.TimeCurrent());
                sess2.update(staffattedence);
                tr.commit();
            } catch (Exception e) {
            }

            session.removeAttribute("username");
            session.removeAttribute("type");
            session.invalidate();
            response.sendRedirect("/CMC/newlogin.jsp");

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
