/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.MicroFinance;

import ORM.Center;
import ORM.CenterHasStaff;
import ORM.Loan;
import ORM.Members;
import ORM.Repayment;
import Singleton.dateFormat;
import Srcs.NPmemHolder;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
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

@WebServlet(name = "viewNotpaidMembersajax", urlPatterns = {"/viewNotpaidMembersajax"})
public class viewNotpaidMembersajax extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HashMap<String, NPmemHolder> hm = new HashMap<>();

        try {
            PrintWriter out = response.getWriter();
            String date = request.getParameter("date");
            String datf = dateFormat.setDateFull(date);

            Session sess = PoolManager.getSessionFactory().openSession();
            String exeid = request.getParameter("exeid");
            Criteria cr = sess.createCriteria(Center.class);
            cr.add(Restrictions.eq("isActive", "Active"));
            cr.add(Restrictions.eq("isApprove", "Approve"));
            cr.add(Restrictions.eq("centerDay", dateFormat.DayOnlyString(datf)));
            hm.clear();
            List<Center> list = cr.list();

            JSONArray arr = new JSONArray();

            for (Center center : list) {

                Iterator it5 = center.getCenterHasStaffs().iterator();

                while (it5.hasNext()) {

                    CenterHasStaff chs = (CenterHasStaff) it5.next();

                    if (chs.getStaff().getIdStaff() == Integer.parseInt(exeid)) {

                        Iterator it = center.getMemberses().iterator();
                        while (it.hasNext()) {
                            Members next = (Members) it.next();

                            Iterator it2 = next.getLoans().iterator();
                            while (it2.hasNext()) {
                                Loan loan = (Loan) it2.next();

                                if (loan.getIsActive().equals("Active") && loan.getIsAprove().equals("Approve") && loan.getStatus().equals("Unpaid")) {

                                    NPmemHolder holder = new NPmemHolder();
                                    holder.setMemno(loan.getMembers().getMemberNo());
                                    holder.setMemName(loan.getMembers().getNameWithInitials());
                                    holder.setCenterName(loan.getMembers().getCenter().getCenterName());
                                    holder.setLoan(loan.getLoanAmount());
                                    holder.setContact(loan.getContractNo());

                                    hm.put(loan.getMembers().getMemberNo(), holder);

                                    Iterator it3 = loan.getRepayments().iterator();
                                    while (it3.hasNext()) {
                                        Repayment repayments = (Repayment) it3.next();

                                        if (repayments.getDate().equals(datf)) {

                                            if (hm.get(repayments.getLoan().getMembers().getMemberNo()) != null) {
                                                hm.remove(repayments.getLoan().getMembers().getMemberNo());

                                            }

                                        }

                                    }

                                }

                            }

                        }

                    }
                }

            }

            for (Map.Entry<String, NPmemHolder> entry : hm.entrySet()) {
                String key = entry.getKey();
                NPmemHolder value = entry.getValue();

                JSONObject jo = new JSONObject();
                jo.put("memberNo", value.getMemno());
                jo.put("memberName", value.getMemName());
                jo.put("centerName", value.getCenterName());
                jo.put("LoanAmount", value.getLoan());
                jo.put("paidAmount", "0.00");
                jo.put("type", "N/A");

                arr.put(jo);

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
