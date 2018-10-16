/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.HR;

import ORM.Staff;
import ORM.Staffsalary;

import Singleton.dateFormat;
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
@WebServlet(name = "ValidateSalaryPaid", urlPatterns = {"/ValidateSalaryPaid"})
public class ValidateSalaryPaid extends HttpServlet {

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
            String nic = request.getParameter("ID");

            Session sess = PoolManager.getSessionFactory().openSession();

            Criteria cr = sess.createCriteria(Staff.class);
            cr.add(Restrictions.eq("nic", nic));

            Staff staff = (Staff) cr.uniqueResult();

            Session sess2 = PoolManager.getSessionFactory().openSession();
            Criteria cr2 = sess2.createCriteria(Staffsalary.class);
            cr2.createAlias("staff", "s");
            cr2.add(Restrictions.eq("s.idStaff", staff.getIdStaff()));
            cr.add(Restrictions.like("date", "%/" + dateFormat.MonthOnly()));

            Staffsalary ss = (Staffsalary) cr2.uniqueResult();
           
            JSONArray arr = new JSONArray();
            if (ss!=null) {
//                JSONObject jo = new JSONObject();
//                jo.put("etf", ss.getEtf());
//                jo.put("epf", ss.getEpf());
//                arr.put(jo);
                
                out.write("yes");
                
            
            }else{
            
                
                
                out.write("no");
            
            
            
            
            }
            
            sess.close();
           
            
            
            
//            for (Staffsalary staffsalary : list) {
//
//                if (list.size() > 0) {
//
//                    JSONObject jo = new JSONObject();
//                    jo.put("etf", staffsalary.getEtf());
//                    jo.put("epf", staffsalary.getEtf());
//                    arr.put(jo);
//
//                    out.write(arr.toString());
//
//                } else {
//
//                    out.write("no");
//
//                }
//
//            }

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
