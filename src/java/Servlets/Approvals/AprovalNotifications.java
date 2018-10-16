/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Approvals;

import ORM.Loan;
import ORM.Resignation;
import ORM.Staffleave;

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


@WebServlet(name = "AprovalNotifications", urlPatterns = {"/AprovalNotifications"})
public class AprovalNotifications extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            PrintWriter out = response.getWriter();
            int resignation = 0;
            int leave = 0;
            int loannot = 0;

            Session sess = PoolManager.getSessionFactory().openSession();
            Criteria cr = sess.createCriteria(Resignation.class);
            cr.add(Restrictions.eq("isAproved", "Pending"));
            cr.add(Restrictions.eq("isActive", "Active"));

            List<Resignation> list = cr.list();

            resignation = list.size();

            
            Criteria cr2 = sess.createCriteria(Staffleave.class);
            cr2.add(Restrictions.eq("isAprove", "Pending"));
            cr2.add(Restrictions.eq("isActive", "Active"));
            List<Staffleave> list1 = cr2.list();

            leave = list1.size();

            Criteria cr3 = sess.createCriteria(Loan.class);
            cr3.add(Restrictions.eq("isActive", "Active"));
            cr3.add(Restrictions.eq("isAprove", "Pending"));

            List<Loan> loan = cr3.list();

            loannot = loan.size();
            
            

            JSONArray arr = new JSONArray();

            JSONObject jo = new JSONObject();

            jo.put("leave", leave);

            jo.put("res", resignation);
            jo.put("loan", loannot);
            arr.put(jo);

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
