/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Approvals;

import ORM.CenterHasStaff;
import ORM.Loancancellation;
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
 * @author arshak
 */
@WebServlet(name = "LoadLoancancellationtable", urlPatterns = {"/LoadLoancancellationtable"})
public class LoadLoancancellationtable extends HttpServlet {

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
            
            try {
                Session sess = PoolManager.getSessionFactory().openSession();

             
                
                Criteria cr = sess.createCriteria(Loancancellation.class);
                JSONArray arr = new JSONArray();
         
                cr.add(Restrictions.eq("isAproved", "Pending"));
                
                List<Loancancellation> l = cr.list();
               
                String exe = null;
                
                for (Loancancellation la : l) {
                   
                    Iterator<CenterHasStaff> iterator = la.getLoan().getMembers().getCenter().getCenterHasStaffs().iterator();
                    while (iterator.hasNext()) {
                        CenterHasStaff next = iterator.next();
                        exe = next.getStaff().getNameWithinitials();
                    }
                    JSONObject jo = new JSONObject();
                    
                    jo.put("contractNo", la.getLoan().getContractNo());
                    jo.put("namewidin", la.getLoan().getMembers().getNameWithInitials());
                    jo.put("memno", la.getLoan().getMembers().getMemberNo());
                    jo.put("center", la.getLoan().getMembers().getCenter().getCenterName());
                    
                    jo.put("nic", la.getLoan().getMembers().getNic());
                    jo.put("amount", la.getLoan().getLoanAmount());
                    jo.put("period", la.getLoan().getLoanPeriod());
                    jo.put("Aprove", exe);
                    jo.put("date", la.getDate());
                    jo.put("btn", "<a class=\"btn btn-success btn-sm\"   id=\"+"+la.getIdLoanCancellation()+"\" onclick=\"clk(this.id)\">View</a>");
                    
                    arr.put(jo);

                    //  <a class="btn btn-success"   id="<%= la.getIdLoanCancellation()%>" onclick="clk(this.id)">View</a>
                }
                
                sess.close();
                out.write(arr.toString());
                
              
                
                
                
            } catch (Exception e) {
                e.printStackTrace();
            }
            
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
