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
 * @author arshak
 */
@WebServlet(name = "LoadCentertables", urlPatterns = {"/LoadCentertables"})
public class LoadCentertables extends HttpServlet {

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
            
            int i = 1;
            
            Session ss = PoolManager.getSessionFactory().openSession();
            Criteria crr = ss.createCriteria(Center.class);
            crr.add(Restrictions.eq("isActive", "Active"));
            crr.add(Restrictions.eq("isApprove", "Approve"));
            
            List<Center> li = crr.list();
            
            JSONArray arr = new JSONArray();
            
            for (Center el : li) {                
                
                JSONObject jo = new JSONObject();
                jo.put("CenterNo", el.getCenterNo());
                jo.put("CenterName", el.getCenterName());
                jo.put("Centerday", el.getCenterDay());
                jo.put("Centertime", el.getCentertime());
                
//                CenterHasStaff next = (CenterHasStaff) el.getCenterHasStaffs().iterator().next();
//                            out.print(next.getStaff().getNameWithinitials());
                
               // jo.put("handledby", next.getStaff().getNameWithinitials());
                jo.put("createdby", el.getCreatedBy());
                jo.put("members", el.getMemberses().size());
                arr.put(jo);
//%>
//
//                    <tr>
//                        <th scope="row"><%= i++%></th>
//                        <td><%= el.getCenterNo()%></td>
//                        <td><%= el.getCenterName()%></td>
//                        <td><%= el.getCenterDay()%></td>
//                        <td><%= el.getCentertime()%></td>
//                        <td><%
//
//                            CenterHasStaff next = (CenterHasStaff) el.getCenterHasStaffs().iterator().next();
//                            out.print(next.getStaff().getNameWithinitials());
//
//                            %></td>
//                        <td><%= el.getCreatedBy()%></td>
//                        <td><%= el.getMemberses().size()%></td>
//
//
                // <td><button type="button" id="modal" class="btn btn-info btn-sm bt-mod btn-opn" idCenter="<%= el.getIdCenter()%>">Modify</button></td>
            }
            ss.close();
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
