/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.MicroFinance;

import ORM.Center;
import ORM.CenterHasStaff;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
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
 * @author danushka
 */
@WebServlet(name = "LoadCenterRepaymentSheet", urlPatterns = {"/LoadCenterRepaymentSheet"})
public class LoadCenterRepaymentSheet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {
                JSONArray jsonArray = new JSONArray();
                Session openSession = PoolManager.getSessionFactory().openSession();
                Criteria createCriteria = openSession.createCriteria(Center.class);
                createCriteria.add(Restrictions.eq("isActive", "Active"));
                createCriteria.add(Restrictions.eq("isApprove", "Approve"));
                List<Center> list = createCriteria.list();
                for (Center center : list) {

                    if (request.getSession().getAttribute("UserType").toString().equals("Executive")) {

                        Iterator<CenterHasStaff> iterator = center.getCenterHasStaffs().iterator();
                        while (iterator.hasNext()) {
                            CenterHasStaff next = iterator.next();
                            if (next.getStaff().getIdStaff() == Integer.parseInt(request.getSession().getAttribute("id").toString())) {
                               
                                JSONObject jo = new JSONObject();
                                jo.put("id", center.getIdCenter());
                                jo.put("name", center.getCenterNo() + " - " + center.getCenterName());
                                jsonArray.put(jo);
                            
                            }
                        }
                    }else{
                    
                        JSONObject jo = new JSONObject();
                        jo.put("id", center.getIdCenter());
                        jo.put("name", center.getCenterNo() + " - " + center.getCenterName());
                        jsonArray.put(jo);
                    
                    }
                }
                openSession.close();
                out.write(jsonArray.toString());
            } catch (Exception e) {

                out.write("err");
                e.printStackTrace();

            }

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
