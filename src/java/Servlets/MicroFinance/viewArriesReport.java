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
import Singleton.decimalFormat;
import Srcs.NPmemHolder;
import Srcs.PoolManager;
import Srcs.WeeksCount;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
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

@WebServlet(name = "viewArriesReport", urlPatterns = {"/viewArriesReport"})
public class viewArriesReport extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HashMap<String, NPmemHolder> hm = new HashMap<>();

        try {
            PrintWriter out = response.getWriter();

            String exeid = request.getParameter("exeid");
            String type = request.getParameter("type");

            Date Current;

            Session sess = PoolManager.getSessionFactory().openSession();
            Criteria cr = sess.createCriteria(Center.class);
            cr.add(Restrictions.eq("isActive", "Active"));
            cr.add(Restrictions.eq("isApprove", "Approve"));
            hm.clear();
            List<Center> list = cr.list();

            JSONArray arr = new JSONArray();
            
            if (type.equals("EXE")) {

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

                                        double paidamount = 0.00;
                                        double loantotal = loan.getLoanAmount() + loan.getLoanInterest();
                                        double arries = 0.00;
                                        double installment = loan.getLoanInstallment();
                                        int weeksCount = WeeksCount.weeksCount(loan.getIssueDate(), loan.getRepaymentDay());

                                        if (weeksCount > loan.getLoanPeriod()) {

                                            Iterator it3 = loan.getRepayments().iterator();
                                            while (it3.hasNext()) {
                                                Repayment repayments = (Repayment) it3.next();

                                                paidamount += repayments.getPaidAmount();

                                            }

                                            arries = loantotal - paidamount;

                                        } else {

                                            Iterator it3 = loan.getRepayments().iterator();
                                            while (it3.hasNext()) {
                                                Repayment repayments = (Repayment) it3.next();

                                                paidamount += repayments.getPaidAmount();

                                            }

                                            arries = (loan.getLoanInstallment() * weeksCount) - paidamount;

                                        }

                                        if (arries > 0) {

                                            JSONObject jo = new JSONObject();
                                            jo.put("memberNo", loan.getMembers().getMemberNo());
                                            jo.put("memberName", loan.getMembers().getNameWithInitials());
                                            jo.put("contact", loan.getMembers().getContactNo());
                                            jo.put("centerName", loan.getMembers().getCenter().getCenterNo());
                                            jo.put("LoanAmount", decimalFormat.setAmount(loan.getLoanAmount()));
                                            jo.put("arr", decimalFormat.setAmount(arries));
                                            jo.put("arrage", decimalFormat.setAmount(arries / installment));
                                            arr.put(jo);

                                        }

                                    }

                                }

                            }

                        }
                    }

                }

            } else if (type.equals("ALL")) {

                for (Center center : list) {

                    Iterator it = center.getMemberses().iterator();
                    while (it.hasNext()) {
                        Members next = (Members) it.next();

                        Iterator it2 = next.getLoans().iterator();
                        while (it2.hasNext()) {
                            Loan loan = (Loan) it2.next();

                            if (loan.getIsActive().equals("Active") && loan.getIsAprove().equals("Approve") && loan.getStatus().equals("Unpaid")) {

                                double paidamount = 0.00;
                                double loantotal = loan.getLoanAmount() + loan.getLoanInterest();
                                double arries = 0.00;
                                double installment = loan.getLoanInstallment();
                                int weeksCount = WeeksCount.weeksCount(loan.getIssueDate(), loan.getRepaymentDay());

                                if (weeksCount > loan.getLoanPeriod()) {

                                    Iterator it3 = loan.getRepayments().iterator();
                                    while (it3.hasNext()) {
                                        Repayment repayments = (Repayment) it3.next();

                                        paidamount += repayments.getPaidAmount();

                                    }

                                    arries = loantotal - paidamount;

                                } else {

                                    Iterator it3 = loan.getRepayments().iterator();
                                    while (it3.hasNext()) {
                                        Repayment repayments = (Repayment) it3.next();

                                        paidamount += repayments.getPaidAmount();

                                    }

                                    arries = (loan.getLoanInstallment() * weeksCount) - paidamount;

                                }

                                if (arries > 0) {

                                    JSONObject jo = new JSONObject();
                                    jo.put("memberNo", loan.getMembers().getMemberNo());
                                    jo.put("memberName", loan.getMembers().getNameWithInitials());
                                    jo.put("contact", loan.getMembers().getContactNo());
                                    jo.put("centerName", loan.getMembers().getCenter().getCenterNo());
                                    jo.put("LoanAmount", decimalFormat.setAmount(loan.getLoanAmount()));
                                    jo.put("arr", decimalFormat.setAmount(arries));
                                    jo.put("arrage", decimalFormat.setAmount(arries / installment));

                                    arr.put(jo);

                                }

                            }

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
