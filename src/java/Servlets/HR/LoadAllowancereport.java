/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.HR;

import ORM.StaffHasAllowance;

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
 * @author iamarshrx
 */
@WebServlet(name = "LoadAllowancereport", urlPatterns = {"/LoadAllowancereport"})
public class LoadAllowancereport extends HttpServlet {

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

            String id = request.getParameter("id");
            String year = request.getParameter("year");
            String month = request.getParameter("month");
            String date = month + "/" + year;

            Session sess = PoolManager.getSessionFactory().openSession();
            Criteria cr = sess.createCriteria(StaffHasAllowance.class);
//            cr.createAlias("staff", "s");
//            cr.add(Restrictions.eq("s", "idStaff"));
            cr.add(Restrictions.like("date", "%" + date));
            cr.createAlias("staff", "s");
            cr.add(Restrictions.eq("s.idStaff", Integer.parseInt(id)));

            List<StaffHasAllowance> list = cr.list();

            int i = 0;

            JSONArray arr = new JSONArray();
            for (StaffHasAllowance staffHasAllowance : list) {

                JSONObject jo = new JSONObject();
                jo.put("no", i++);
                jo.put("name", staffHasAllowance.getAllowance().getAllowancName());
                jo.put("date", staffHasAllowance.getDate());
                jo.put("amount", staffHasAllowance.getAmount());
                arr.put(jo);

            }
            sess.close();

            out.write(arr.toString());


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
