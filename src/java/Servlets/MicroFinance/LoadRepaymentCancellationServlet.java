/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.MicroFinance;

import ORM.CenterHasStaff;
import ORM.Repaymentcancellation;
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
@WebServlet(name = "LoadRepaymentCancellationServlet", urlPatterns = {"/LoadRepaymentCancellationServlet"})
public class LoadRepaymentCancellationServlet extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            PrintWriter out = response.getWriter();

            Session sess = PoolManager.getSessionFactory().openSession();

            Criteria cr = sess.createCriteria(Repaymentcancellation.class);
//                cr.add(Restrictions.eq("isActive", "Active"));
            cr.add(Restrictions.eq("isAproved", "Pending"));

            List<Repaymentcancellation> l = cr.list();

            JSONArray arr = new JSONArray();
            String exe = null;
            for (Repaymentcancellation la : l) {
                    
                Iterator<CenterHasStaff> iterator = la.getRepayment().getLoan().getMembers().getCenter().getCenterHasStaffs().iterator();
                while (iterator.hasNext()) {
                    CenterHasStaff next = iterator.next();
                    exe = next.getStaff().getNameWithinitials();
                }
                JSONObject jo = new JSONObject();

                jo.put("contarctNo", la.getRepayment().getRecieptNo());
                jo.put("namwid", la.getRepayment().getLoan().getMembers().getNameWithInitials());
                jo.put("nic", la.getRepayment().getLoan().getMembers().getMemberNo()); 
                jo.put("paidamount", la.getRepayment().getPaidAmount());
                jo.put("center", la.getRepayment().getLoan().getMembers().getCenter().getCenterName());
                jo.put("executive", exe);
                jo.put("date", la.getDate());
                
                jo.put("btn", "<a class=\"btn btn-success btn-sm\"   id=\""+la.getIdRepaymentCancellation()+"\" onclick=\"clk(this.id)\">View</a>");

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
