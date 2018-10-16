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

@WebServlet(name = "viewNPReport", urlPatterns = {"/viewNPReport"})
public class viewNPReport extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HashMap<String, NPmemHolder> hm = new HashMap<>();

        try {
            PrintWriter out = response.getWriter();
            String dstart = request.getParameter("startdate");
            String dend = request.getParameter("enddate");
            String exeid = request.getParameter("exeid");
            String type = request.getParameter("type");
            String startdate = dateFormat.setDateFull(dstart);
            String enddate = dateFormat.setDateFull(dend);

            Date parseStart = new SimpleDateFormat("dd/MM/yyyy").parse(startdate);
            Date parseEnd = new SimpleDateFormat("dd/MM/yyyy").parse(enddate);
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
                                    double paid = 0;

                                    if (loan.getIsActive().equals("Active") && loan.getIsAprove().equals("Approve") && loan.getStatus().equals("Unpaid")) {

                                        NPmemHolder holder = new NPmemHolder();
                                        holder.setMemno(loan.getMembers().getMemberNo());
                                        holder.setMemName(loan.getMembers().getNameWithInitials());
                                        holder.setCenterName(loan.getMembers().getCenter().getCenterName());
                                        holder.setLoan(loan.getLoanAmount());
                                        holder.setContact(loan.getMembers().getContactNo());
                                        holder.setBalance(loan.getLoanAmount() + loan.getLoanInterest());
                                        holder.setPaid(0.0);
                                        holder.setInstallment(loan.getLoanInstallment());

                                        hm.put(loan.getMembers().getMemberNo(), holder);

                                        Iterator it3 = loan.getRepayments().iterator();
                                        while (it3.hasNext()) {
                                            Repayment repayments = (Repayment) it3.next();
                                            if (repayments.getIsActive().equals("Active")) {
                                                paid += repayments.getPaidAmount();

                                                Current = new SimpleDateFormat("dd/MM/yyyy").parse(repayments.getDate());
                                                System.out.println(repayments.getLoan().getMembers().getMemberNo() + " " + repayments.getDate());
                                                if (Current.after(parseStart) && Current.before(parseEnd)) {
//                                                System.out.println("Current "+Current);
                                                    if (hm.get(repayments.getLoan().getMembers().getMemberNo()) != null) {
                                                        hm.remove(repayments.getLoan().getMembers().getMemberNo());
                                                        System.out.println("Have Payment for " + repayments.getLoan().getMembers().getMemberNo());
                                                    }

                                                }
                                            }
                                        }

                                        String memberNo = loan.getMembers().getMemberNo();

                                        if (hm.get(loan.getMembers().getMemberNo()) != null) {

                                            NPmemHolder get = hm.get(memberNo);
                                            get.setBalance(get.getBalance() - paid);
                                            get.setPaid(paid);

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
                            double paid = 0;
                            Loan loan = (Loan) it2.next();

                            if (loan.getIsActive().equals("Active") && loan.getIsAprove().equals("Approve") && loan.getStatus().equals("Unpaid")) {

                                NPmemHolder holder = new NPmemHolder();
                                holder.setMemno(loan.getMembers().getMemberNo());
                                holder.setMemName(loan.getMembers().getNameWithInitials());
                                holder.setCenterName(loan.getMembers().getCenter().getCenterName());
                                holder.setLoan(loan.getLoanAmount());
                                holder.setContact(loan.getMembers().getContactNo());
                                holder.setBalance(loan.getLoanAmount() + loan.getLoanInterest());
                                holder.setPaid(0.0);
                                holder.setInstallment(loan.getLoanInstallment());

                                
                                hm.put(loan.getMembers().getMemberNo(), holder);

                                Iterator it3 = loan.getRepayments().iterator();
                                while (it3.hasNext()) {
                                    Repayment repayments = (Repayment) it3.next();

                                    Current = new SimpleDateFormat("dd/MM/yyyy").parse(repayments.getDate());
                                    if (Current.after(parseStart) && Current.before(parseEnd)) {

                                        if (hm.get(repayments.getLoan().getMembers().getMemberNo()) != null) {
                                            hm.remove(repayments.getLoan().getMembers().getMemberNo());

                                        }

                                    }

                                }

                                String memberNo = loan.getMembers().getMemberNo();

                                if (hm.get(loan.getMembers().getMemberNo()) != null) {

                                    NPmemHolder get = hm.get(memberNo);
                                    get.setBalance(get.getBalance() - paid);
                                    get.setPaid(paid);

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
                jo.put("LoanAmount", decimalFormat.setAmount(value.getLoan()));
                jo.put("paidAmount", value.getContact());
                jo.put("paid", decimalFormat.setAmount(value.getPaid()));
                jo.put("balance", decimalFormat.setAmount(value.getBalance()));
                jo.put("installment", decimalFormat.setAmount(value.getInstallment()));

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
