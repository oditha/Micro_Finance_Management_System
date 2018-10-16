/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.HR;

import ORM.Staffsalary;

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
@WebServlet(name = "StaffSalaryreportoneLoad", urlPatterns = {"/StaffSalaryreportoneLoad"})
public class StaffSalaryreportoneLoad extends HttpServlet {

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
            
            
          int id=Integer.parseInt(request.getParameter("id"));
            
         
            Session sess=PoolManager.getSessionFactory().openSession();
            
            Criteria cr = sess.createCriteria(Staffsalary.class);
            
            cr.add(Restrictions.eq("idStaffSalary", id));
            
            List<Staffsalary> list = cr.list();
            JSONArray arr=new JSONArray();
            
            
            for (Staffsalary staffsalary : list) {
                
                
                JSONObject jo = new JSONObject();
                 
                
                jo.put("date", staffsalary.getDate());
                jo.put("Basic", staffsalary.getBasicSalary());
                jo.put("Totalsalary", staffsalary.getTotalSalary());
                jo.put("allowance", staffsalary.getTotalAllowance());
                jo.put("deduction", staffsalary.getTotalDeductions());
                jo.put("payment", staffsalary.getTotalPayments());
                jo.put("etf", staffsalary.getEtf());
                jo.put("epf", staffsalary.getEpf());
                jo.put("netsalary", staffsalary.getNetSalary());
                jo.put("status", staffsalary.getIsDelete());
                
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
