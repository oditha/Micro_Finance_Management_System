/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.HR;

import ORM.Staff;
import ORM.Staffleave;

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
@WebServlet(name = "LeaveReportServlet", urlPatterns = {"/LeaveReportServlet"})
public class LeaveReportServlet extends HttpServlet {

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

                    Set staffleaves = staff.getStaffleaves();
                    Iterator it = staffleaves.iterator();

                    while (it.hasNext()) {

                        Staffleave sl = (Staffleave) it.next();

                        if (sl.getIsActive().equals("Active") && sl.getIsAprove().equals("Aproved")) {

                            if (sl.getStartDate().endsWith(date)) {

                                total += Integer.parseInt(sl.getTotalDays());

                            }

                        }

                    ///total += Integer.parseInt(sl.getTotalDays());
                        //  System.out.println(total + sl.getStaff().getNic());
                    }
                    System.out.println(total);
                    // String button="<button class=\"btn btn-primary cls\"  stfid="+staff.getIdStaff()+" date="+date+" id=\"cds\" onclick=\"ldk();\" > View</button>";
                    String button = "<button class=\"btn btn-primary cls\"  stfid=" + staff.getIdStaff() + " date=" + date + " id=" + staff.getIdStaff() + " onclick=\"ldk(this.id);\" > View</button>";

                    JSONObject jo = new JSONObject();
                    jo.put("id", i++);
                    jo.put("nic", staff.getNic());
                    jo.put("name", staff.getName());
                    jo.put("total", total);
                    jo.put("view", button);
                    arr.put(jo);
               // System.out.println(jo.toString());

                // int id=staff.getIdStaff();
//                Session ses2 = DB.getsession();
//                Criteria cr2 = ses2.createCriteria(Staffleave.class);
//                cr2.createAlias("staff", "s");
//
//                cr2.add(Restrictions.like("startDate", "%" + "12" + "/" + "2017"));
//                cr2.add(Restrictions.eq("s.idStaff", id));
//
//                List<Staffleave> l2 = cr2.list();
//                for (Staffleave staffleave : l2) {
//                    
//                    total+=Integer.parseInt(staffleave.getTotalDays());
//                    
//                    
//                }
                }
                sess.close();
                out.write(arr.toString());
                // System.out.println(arr.toString());
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
