/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.HR;

import ORM.Login;

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
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author iamarshrx
 */
@WebServlet(name = "editUserServlet", urlPatterns = {"/editUserServlet"})
public class editUserServlet extends HttpServlet {

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
            String id = request.getParameter("hid");
            String username = request.getParameter("muname");
            String mpass = request.getParameter("mpass");
            String rempass = request.getParameter("rempass");

            if (mpass.equals(rempass)) {

                try {
                    Session s = PoolManager.getSessionFactory().openSession();

                    Transaction tr = s.beginTransaction();

                    Criteria cr = s.createCriteria(Login.class);

                    cr.add(Restrictions.eq("idLogin", Integer.parseInt(id)));

                    Login l = (Login) cr.uniqueResult();

//                Login login=new  Login();
                    // l.setPassword(mpass);
                    l.setPassword(mpass);
                    l.setLoginBlock("unblock");
                    s.update(l);
                    tr.commit();

                    if (tr.wasCommitted()) {

                        response.sendRedirect("HR/AddUser.jsp?success=okupdate");
                    }
                    s.close();
                } catch (Exception e) {
                    throw new HibernateException(e);
                }

            } else {

                response.sendRedirect("HR/AddUser.jsp?err=passnm");

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
