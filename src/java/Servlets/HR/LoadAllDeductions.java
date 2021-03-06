/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.HR;

import ORM.Staff;
import ORM.StaffHasAllowance;
import ORM.StaffHasDeductions;

import Singleton.dateFormat;
import Singleton.decimalFormat;
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
@WebServlet(name = "LoadAllDeductions", urlPatterns = {"/LoadAllDeductions"})
public class LoadAllDeductions extends HttpServlet {

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
            
            
            String nic=request.getParameter("ID");
            int id;
           
            
            Session sess1=PoolManager.getSessionFactory().openSession();
            Criteria cr1=sess1.createCriteria(Staff.class);
            cr1.add(Restrictions.eq("nic", nic));
            
            Staff s=(Staff) cr1.uniqueResult();
            
            id=s.getIdStaff();
            
            
            
            
            
           Session sess=PoolManager.getSessionFactory().openSession();
            
            Criteria cr=sess.createCriteria(StaffHasDeductions.class);
            cr.createAlias("staff", "s");
            cr.add(Restrictions.eq("s.idStaff", id));
             cr.add(Restrictions.eq("s.isActive", "Active"));
            cr.add(Restrictions.like("date", "%/"+dateFormat.MonthOnly()));
            
            //Staff staff=new Staff();
            
            List<StaffHasDeductions>l=cr.list();
            
            JSONArray arr=new JSONArray();
            
            for (StaffHasDeductions staffHasDeductions : l) {
                JSONObject jo=new JSONObject();
                jo.put("id", staffHasDeductions.getIdStaffHasDeductions());
                jo.put("date", staffHasDeductions.getDate());
                jo.put("amount", Double.parseDouble(staffHasDeductions.getAmount()));
                jo.put("type", staffHasDeductions.getDeductions().getDeductionType());
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
