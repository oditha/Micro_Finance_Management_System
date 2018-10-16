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
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author iamarshrx
 */
@WebServlet(name = "LoadUnpaidSalary", urlPatterns = {"/LoadUnpaidSalary"})
public class LoadUnpaidSalary extends HttpServlet {

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





            Session sess =PoolManager.getSessionFactory().openSession();

            Criteria cr = sess.createCriteria(Staff.class);

            List<Staff> list = cr.list();
            JSONArray arr = new JSONArray();
            for (Staff staff : list) {

                Set ss = staff.getStaffsalaries();

                Iterator it = ss.iterator();

                int id = 0;
                while (it.hasNext()) {
                    Staffsalary ss1 = (Staffsalary) it.next();

                    if (ss1.getDate().endsWith(dateFormat.MonthOnly()) && ss1.getIsDelete().equals("Paid")&& ss1.getStaff().getIdStaff().equals("")) {

                        id = ss1.getStaff().getIdStaff();

                    } else {

                    }

                }

                if (id != staff.getIdStaff()) {

                    // System.out.println(staff.getNic());
                    JSONObject jo = new JSONObject();
                   jo.put("nic",staff.getNic() );
                   arr.put(jo);
                   
                   

                }

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
