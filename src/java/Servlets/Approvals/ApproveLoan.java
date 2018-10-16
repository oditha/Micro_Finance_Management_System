/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.Approvals;

import ORM.AccruedIncomeAccount;
import ORM.CashInHandAcc;
import ORM.InterestAccount;
import ORM.Loan;
import ORM.LoanAccount;
import ORM.Login;
import ORM.OtherIncomeAcc;
import ORM.Repayment;
import Singleton.dateFormat;
import Singleton.decimalFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

@WebServlet(name = "ApproveLoan", urlPatterns = {"/ApproveLoan"})
public class ApproveLoan extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
        try {
            // int hid=Integer.parseInt(request.getParameter("hid"));
            int id = Integer.parseInt(request.getParameter("hid"));
            String date = request.getParameter("issue");
            String setDateFull = dateFormat.setDateFull(date);
            System.out.println(id);

            Session sess = PoolManager.getSessionFactory().openSession();

            Transaction tr = sess.beginTransaction();

            Criteria cr = sess.createCriteria(Loan.class);

            cr.add(Restrictions.eq("idLoan", id));

            Loan loan = (Loan) cr.uniqueResult();

            if (loan != null) {
                int idRepayment = 0;

                Iterator iterator = loan.getMembers().getLoans().iterator();
                while (iterator.hasNext()) {
                    Loan lo = (Loan) iterator.next();

                    if (lo.getIsActive().equals("Active")) {

                        Iterator<Repayment> itt = lo.getRepayments().iterator();
                        while (itt.hasNext()) {
                            Repayment next = itt.next();
                            String isActive = next.getIsActive();
                            String isAproved = next.getIsAproved();

                            if (isActive.equals("Renew") && isAproved.equals("Renew")) {

                                idRepayment = next.getIdRePayment();

                            }

                        }
                    }
                }

                Criteria repay = sess.createCriteria(Repayment.class);
                repay.add(Restrictions.eq("idRePayment", idRepayment));
                Repayment re = (Repayment) repay.uniqueResult();
                if (re != null) {

                    re.setIsActive("Active");
                    re.setIsAproved("Approve");
                    re.getLoan().setStatus("Paid");
                    sess.update(re);
                }

                double Loanamount = loan.getLoanAmount();
                double interest = loan.getLoanInterest();
                double period = loan.getLoanPeriod();
                double installmentloan = loan.getLoanInstallment();

                double interestIncome = interest / period;

                double persontageintrestIncome = (interestIncome * 100) / installmentloan;
                persontageintrestIncome = Double.parseDouble(decimalFormat.setAmount(persontageintrestIncome));
                System.out.println("persontage income" + persontageintrestIncome);
                double finalintrest = (Loanamount - loan.getRenewAmount()) * persontageintrestIncome / 100;

                finalintrest = Double.parseDouble(decimalFormat.setAmount(finalintrest));

                loan.setIsAprove("Approve");
                loan.setIsActive("Active");
                loan.setIssueDate(setDateFull);
                sess.update(loan);

                String loanamount = "" + loan.getLoanAmount();
                String loanfee = "" + loan.getMemberfee();

                LoanAccount las = new LoanAccount();
                las.setAccDate(dateFormat.DateFullCurrent());
                las.setCredit((Loanamount - loan.getRenewAmount()) - finalintrest);
                las.setDebit(0.0);
                las.setDescription("Repayment for Loan #");
                las.setIsActive("Active");

                InterestAccount ia = new InterestAccount();
                ia.setAccDate(dateFormat.DateFullCurrent());
                ia.setCredit(finalintrest);
                ia.setDebit(0.0);
                ia.setDescription("Repayment for Loan #");
                ia.setIsActive("Active");

                AccruedIncomeAccount acc = new AccruedIncomeAccount();
                acc.setAccDate(dateFormat.DateFullCurrent());
                acc.setDebit((Loanamount - loan.getRenewAmount()));
                acc.setCredit(0.0);
                acc.setDescription("Repayment for Loan #");
                acc.setIsActive("Active");

                CashInHandAcc cashs = new CashInHandAcc();

                cashs.setAccDate(dateFormat.DateFullCurrent());
                cashs.setDebit((Loanamount - loan.getRenewAmount()));
                cashs.setCredit(0.0);
                cashs.setDescription("Repayment for Loan #");
                cashs.setIsActive("Active");

                sess.save(cashs);
                sess.save(acc);
                sess.save(las);
                sess.save(ia);

                //-------------
                LoanAccount la = new LoanAccount();
                la.setAccDate(dateFormat.DateFullCurrent());
                la.setCredit(0.0);
                la.setDebit(Double.parseDouble(loanamount));
                la.setDescription("new  Loan #" + loan.getContractNo());
                la.setIsActive("Active");
                sess.save(la);

                //-----------------
                CashInHandAcc cash = new CashInHandAcc();
                cash.setAccDate(dateFormat.DateFullCurrent());
                cash.setDebit(0.0);
                cash.setCredit(Double.parseDouble(loanamount));
                cash.setDescription("new Loan #" + loan.getContractNo());
                cash.setIsActive("Active");
                sess.save(cash);

                CashInHandAcc cahmemberfee = new CashInHandAcc();
                cahmemberfee.setAccDate(dateFormat.DateFullCurrent());
                cahmemberfee.setDebit(Double.parseDouble(loanfee));
                cahmemberfee.setCredit(0.0);
                cahmemberfee.setDescription("Memberfee for Loan #" + loan.getContractNo());
                cahmemberfee.setIsActive("Active");
                sess.save(cahmemberfee);

                OtherIncomeAcc otherIncomeAcc = new OtherIncomeAcc();
                otherIncomeAcc.setAccDate(dateFormat.DateFullCurrent());
                otherIncomeAcc.setCredit(Double.parseDouble(loanfee));
                otherIncomeAcc.setDebit(0.0);
                otherIncomeAcc.setDescription("Memberfee for Loan #" + loan.getContractNo());
                otherIncomeAcc.setIsActive("Active");
                sess.save(otherIncomeAcc);

                tr.commit();

                sess.close();

                out.write("ok");
            }

        } catch (Exception e) {
            out.write("error");

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
