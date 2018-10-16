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
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author iamarshrx
 */
@WebServlet(name = "UsermodallAjaxServlet", urlPatterns = {"/UsermodallAjaxServlet"})
public class UsermodallAjaxServlet extends HttpServlet {

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

            String id = request.getParameter("ID");

            int idd = Integer.parseInt(id);

            try {
                // out.write(id);
                Session sess = PoolManager.getSessionFactory().openSession();

                Criteria cr = sess.createCriteria(Login.class);

                JSONArray arr = new JSONArray();

                //At restrictions(Where clause)
                cr.add(Restrictions.eq("idLogin", idd));
//        cr.add(Restrictions.eq("idLogin", id));
                List<Login> l = cr.list();

                for (Login login : l) {
                    //out.write(login.getUserName());

                    //out.write( login.getUserName());
                    JSONObject js = new JSONObject();

                    js.put("name", login.getStaff().getName());
                    js.put("username", login.getUserName());
                    js.put("password", login.getPassword());

                    arr.put(js);

                }

                sess.close();
                out.write(arr.toString());

            } catch (Exception e) {
                throw new HibernateException(e);
                // out.print(e);
            }

            //  out.write("jkhb");
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
