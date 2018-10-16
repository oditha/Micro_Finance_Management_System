/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.HR;

import ORM.Staff;
import ORM.Staffattedence;

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
import org.hibernate.criterion.Restrictions;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author iamarshrx
 */
@WebServlet(name = "AttendenceReportServlet", urlPatterns = {"/AttendenceReportServlet"})
public class AttendenceReportServlet extends HttpServlet {

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
            int i = 0;

            String month = request.getParameter("month");
            String year = request.getParameter("year");

            String date = month + "/" + year;

            try {

                Session sess = PoolManager.getSessionFactory().openSession();
                Criteria cr = sess.createCriteria(Staff.class);
                cr.add(Restrictions.eq("isActive", "Active"));

                JSONArray arr = new JSONArray();

                List<Staff> list = cr.list();

                for (Staff staff : list) {
                    int total = 0;
                    Set staffattedences = staff.getStaffattedences();
                    Iterator it = staffattedences.iterator();

                    while (it.hasNext()) {
                        Staffattedence sa = (Staffattedence) it.next();

                        if (sa.getIsActive().equals("Active") && sa.getIsAprove().equals("Aproved")) {

                            if (sa.getDate().endsWith(date)) {

                                total += Integer.parseInt(sa.getSpecialnote());

                            }

                        }

                    }
                    // String button="<button class=\"btn btn-primary view\" data-toggle=\"modal\" data-target=\".bd-example-modal-lg\"   > <a stfid="+staff.getIdStaff()+" date="+date+" class=\"vat\">View</a></button>";
                    String button = "<button class=\"btn btn-primary cls\"  stfid=" + staff.getIdStaff() + " date=" + date + " id=" + staff.getIdStaff() + " onClick=\"reply_click(this.id)\" > View</button>";

                    JSONObject jo = new JSONObject();
                    jo.put("id", i++);
                    jo.put("nic", staff.getNic());
                    jo.put("name", staff.getName());
                    jo.put("total", total);
                    jo.put("view", button);
                    arr.put(jo);

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
