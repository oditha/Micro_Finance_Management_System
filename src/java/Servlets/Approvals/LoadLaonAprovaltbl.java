/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Approvals;

import ORM.CenterHasStaff;
import ORM.Loan;
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
@WebServlet(name = "LoadLaonAprovaltbl", urlPatterns = {"/LoadLaonAprovaltbl"})
public class LoadLaonAprovaltbl extends HttpServlet {

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

                Criteria cr = sess.createCriteria(Loan.class);
                cr.add(Restrictions.eq("isActive", "Pending"));
                cr.add(Restrictions.eq("isAprove", "Pending"));

                List<Loan> l = cr.list();

                JSONArray arr = new JSONArray();

                String exe = null;
                for (Loan la : l) {

                    Iterator<CenterHasStaff> iterator = la.getMembers().getCenter().getCenterHasStaffs().iterator();
                    while (iterator.hasNext()) {
                        CenterHasStaff next = iterator.next();

                        exe = next.getStaff().getNameWithinitials();

                    }
                    JSONObject jo = new JSONObject();

                    jo.put("memno", la.getMembers().getMemberNo());
                    jo.put("name", la.getMembers().getNameWithInitials());
                    jo.put("nic", la.getMembers().getNic());
                    jo.put("loanAmount", la.getLoanAmount());

                    jo.put("exective", exe);
                    jo.put("center", la.getMembers().getCenter().getCenterName());
                    jo.put("request", la.getLoanDate());
                    jo.put("btn", "<a class=\"btn btn-success btn-sm\"   id=\"" + la.getIdLoan() + "\" onclick=\"clk(this.id)\">View</a>");
                    arr.put(jo);

                    //  <td></td>
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
