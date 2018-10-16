/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.MicroFinance;

import ORM.CenterHasStaff;
import ORM.Loan;
import ORM.Members;
import ORM.Repayment;
import ORM.Staff;
import Singleton.dateFormat;
import Singleton.decimalFormat;
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

@WebServlet(name = "RepaymentOfficeFilter", urlPatterns = {"/RepaymentOfficeFilter"})
public class RepaymentOfficeFilter extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            PrintWriter out = response.getWriter();
            String date = request.getParameter("date");
            JSONArray arr = new JSONArray();

            String setDateFull = dateFormat.setDateFull(date);

            Session sess = PoolManager.getSessionFactory().openSession();
            Criteria cr = sess.createCriteria(Repayment.class);
            cr.add(Restrictions.eq("date", setDateFull));
            cr.add(Restrictions.eq("arreas", "CashierPayment"));
            List<Repayment> list = cr.list();
            for (Repayment re : list) {

                JSONObject jo = new JSONObject();
                jo.put("memno", re.getLoan().getMembers().getMemberNo());
                jo.put("memname", re.getLoan().getMembers().getNameWithInitials());
                jo.put("receipt", re.getRecieptNo());
                jo.put("date", re.getDate());
                jo.put("paidamount", decimalFormat.setAmount(re.getPaidAmount()));
                jo.put("center", re.getLoan().getMembers().getCenter().getCenterName());
                
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
