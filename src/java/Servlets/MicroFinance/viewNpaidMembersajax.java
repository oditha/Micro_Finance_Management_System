/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.MicroFinance;

import ORM.CenterHasStaff;
import ORM.Repayment;
import Singleton.dateFormat;
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

@WebServlet(name = "viewNpaidMembersajax", urlPatterns = {"/viewNpaidMembersajax"})
public class viewNpaidMembersajax extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {

            PrintWriter out = response.getWriter();
            String date = request.getParameter("date");
            String exeid = request.getParameter("exeid");
            String datf = dateFormat.setDateFull(date);

            Session sess = PoolManager.getSessionFactory().openSession();

            Criteria cr = sess.createCriteria(Repayment.class);
            cr.add(Restrictions.eq("isActive", "Active"));
            cr.add(Restrictions.eq("date", datf));

            List<Repayment> list = cr.list();

            JSONArray arr = new JSONArray();

            for (Repayment repayment : list) {

                Iterator it = repayment.getLoan().getMembers().getCenter().getCenterHasStaffs().iterator();
                while (it.hasNext()) {
                    CenterHasStaff next = (CenterHasStaff) it.next();
                    System.out.println(next.getStaff().getName());

                    if (next.getStaff().getIdStaff() == Integer.parseInt(exeid)) {

                        if (!repayment.getActualDay().equals(dateFormat.DayOnlyString(datf))) {

                            JSONObject jo = new JSONObject();
                            jo.put("memberNo", repayment.getLoan().getMembers().getMemberNo());
                            jo.put("memberName", repayment.getLoan().getMembers().getNameWithInitials());
                            jo.put("centerName", repayment.getLoan().getMembers().getCenter().getCenterName());
                            jo.put("LoanAmount", repayment.getLoan().getLoanAmount());
                            jo.put("paidAmount", repayment.getPaidAmount());
                            jo.put("type", repayment.getArreas());
                            arr.put(jo);

                        } else {

                        }
                    }

                }

            }

            out.write(arr.toString());

            sess.close();

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
