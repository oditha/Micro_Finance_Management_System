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
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
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
 * @author danushka
 */
@WebServlet(name = "RepaymentExecutivefilter", urlPatterns = {"/RepaymentExecutivefilter"})
public class RepaymentExecutivefilter extends HttpServlet {

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
            String stfid = request.getParameter("idCenter");

            Session sess = PoolManager.getSessionFactory().openSession();
            Criteria cr = sess.createCriteria(Staff.class);
            cr.add(Restrictions.eq("idStaff", Integer.parseInt(stfid)));

            Staff uniqueResult = (Staff) cr.uniqueResult();
            JSONArray arr = new JSONArray();

            if (uniqueResult != null) {

                Iterator it = uniqueResult.getCenterHasStaffs().iterator();

                while (it.hasNext()) {
                    CenterHasStaff next = (CenterHasStaff) it.next();

                    Iterator it2 = next.getCenter().getMemberses().iterator();

                    while (it2.hasNext()) {
                        Members next1 = (Members) it2.next();

                        Iterator it3 = next1.getLoans().iterator();
                        while (it3.hasNext()) {
                            Loan next2 = (Loan) it3.next();

                            if (next2.getStatus().equals("Unpaid")) {

                                Iterator it4 = next2.getRepayments().iterator();

                                while (it4.hasNext()) {
                                    Repayment next3 = (Repayment) it4.next();

                                    JSONObject jo = new JSONObject();
                                    jo.put("memno", next1.getMemberNo());
                                    jo.put("memname", next1.getNameWithInitials());
                                    jo.put("ContractNo", next2.getContractNo());
                                    jo.put("ReceiptNo", next3.getRecieptNo());
                                    jo.put("Loanamount", next2.getLoanAmount());
                                    jo.put("date", next3.getDate());
                                    jo.put("paidamount", next3.getPaidAmount());
                                    jo.put("center", next.getCenter().getCenterName());
                                    jo.put("btn", "<a class=\"dropdown-item cancel\" memna =\" " + next1.getNameWithInitials() + "\" cno =\"" + next2.getContractNo() + "\"  idrepay = \"" + next3.getIdRePayment() + "\" >Request Cancellation</a>\n"
                                            + "                        <a class=\"dropdown-item cancel\" memna =\" " + next1.getNameWithInitials() + "\" cno =\"" + next2.getContractNo() + "\"  idrepay = \"" + next3.getIdRePayment() + "\" hidden=\"\" >Reprint Reciept</a>\n"
                                            + "");
                                    arr.put(jo);

                                }
                            }

                        }

                    }

                }

            }

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
