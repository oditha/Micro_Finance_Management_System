/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.MicroFinance;

import ORM.Center;
import ORM.Members;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Objects;
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
 * @author arshak
 */
@WebServlet(name = "LoadAddloanBulk", urlPatterns = {"/LoadAddloanBulk"})
public class LoadAddloanBulk extends HttpServlet {

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
                int idcenter = Integer.parseInt(request.getParameter("value"));
                Session sess = PoolManager.getSessionFactory().openSession();
                Criteria cr = sess.createCriteria(Center.class);
                cr.add(Restrictions.eq("idCenter", idcenter));
                Center uniqueResult = (Center) cr.uniqueResult();
                JSONArray arr = new JSONArray();
                if (uniqueResult != null) {
                    // String group
                    Iterator it = uniqueResult.getMemberses().iterator();
                    while (it.hasNext()) {

                        Members next = (Members) it.next();
                        String groupId = next.getGroupId();
                        Integer idMembers = next.getIdMembers();
                        Set loans = next.getLoans();

                        if (loans.size() > 0) {

                        } else {

                            Criteria c = sess.createCriteria(Members.class);
                            c.createAlias("center", "c");
                            c.add(Restrictions.eq("c.idCenter", idcenter));
                            c.add(Restrictions.eq("groupId", groupId));

                            String Gar = "";

                            List<Members> l = c.list();

                            for (Members members : l) {

                                if (!Objects.equals(members.getIdMembers(), idMembers)) {

                                    Gar += members.getMemberNo() + " - " + members.getNameWithInitials() + "+";

                                }

                            }

                            JSONObject jo = new JSONObject();
                            
                            jo.put("memberid", next.getIdMembers());
                            jo.put("memberno", next.getMemberNo());
                            jo.put("membername", next.getNameWithInitials());
                            jo.put("centerday", uniqueResult.getCenterDay());
                            //  jo.put("memberno",next.getNameWithInitials() );
                            jo.put("memberfee", "350");
                            jo.put("loanamount", "  <input type=\"text\" class=\"form-control\" id=\"loanamount\"  value=\"10000.00\" >");
                            jo.put("interest", "  <input type=\"text\" class=\"form-control\" id=\"inetrest\"  value=\"30000.00\" >");
                            jo.put("period", "  <input type=\"text\" class=\"form-control\" id=\"period\"  value=\"13\" >");
                            jo.put("installment", "  <input type=\"text\" class=\"form-control\" id=\"period\"  value=\"1000.00\" >");
                            jo.put("loanindex", "  <input type=\"text\" class=\"form-control\" id=\"loanindex\"  value=\"001\" >");
                            jo.put("g1", Gar);
                           // jo.put("check", <input class=" + "form-check-input" + " type=" + "checkbox" + " id=" + "invalidCheck" + ">");

                            arr.put(jo);

                        }

                    }

                }
sess.close();
                out.write(arr.toString());

            } catch (Exception e) {
                e.printStackTrace();
            }

            //  out.write(request.getParameter("value"));
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
