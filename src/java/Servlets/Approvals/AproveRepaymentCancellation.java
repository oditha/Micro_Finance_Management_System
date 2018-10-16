package Servlets.Approvals;

import ORM.AccruedIncomeAccount;
import ORM.CashInHandAcc;
import ORM.InterestAccount;
import ORM.Loan;
import ORM.LoanAccount;
import ORM.Repayment;
import ORM.Repaymentcancellation;
import Servlets.MicroFinance.RepaymentCancellation;
import Singleton.dateFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

@WebServlet(name = "AproveRepaymentCancellation", urlPatterns = {"/AproveRepaymentCancellation"})
public class AproveRepaymentCancellation extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            PrintWriter out = response.getWriter();

            double paid1 = 0.0;
            double Loanamount = 0.0;
            double interest = 0.0;
            double interestIncome = 0.0;
            double installmentloan = 0.0;
            double persontageintrestIncome = 0.0;
            double finalintrest = 0.0;
            int period = (int) 0.0;
            int idloan = 0;
            String contractNo = null;
            String DateFullCurrent = dateFormat.DateFullCurrent();

            try {
                Session sess = PoolManager.getSessionFactory().openSession();
                Transaction tr = sess.beginTransaction();
                Criteria cr = sess.createCriteria(Repaymentcancellation.class);
                cr.add(Restrictions.eq("idRepaymentCancellation", Integer.parseInt(request.getParameter("hid"))));
                Repaymentcancellation uniqueResult = (Repaymentcancellation) cr.uniqueResult();
                // Repaymentcancellation uniqueResult1 = (Repaymentcancellation) cr.uniqueResult();

                if (uniqueResult != null) {
                    contractNo = uniqueResult.getRepayment().getLoan().getContractNo();
                    paid1 = uniqueResult.getRepayment().getPaidAmount();
                    System.out.println(paid1);
                    Loanamount = uniqueResult.getRepayment().getLoan().getLoanAmount();
                    interest = uniqueResult.getRepayment().getLoan().getLoanInterest();
                    installmentloan = uniqueResult.getRepayment().getLoan().getLoanInstallment();
                    period = uniqueResult.getRepayment().getLoan().getLoanPeriod();
                    idloan = uniqueResult.getRepayment().getLoan().getIdLoan();

                    System.out.println("interest" + interest);
                    System.out.println("installment" + installmentloan);

                    interestIncome = interest / period;

                    System.out.println("interestincome" + interestIncome);

                    persontageintrestIncome = (interestIncome * 100) / installmentloan;
                    persontageintrestIncome = Math.round(persontageintrestIncome);
                    System.out.println("persontage income" + persontageintrestIncome);
                    finalintrest = (paid1 * persontageintrestIncome) / 100;

                    finalintrest = Math.round(finalintrest);

                    System.out.println("final interest" + finalintrest);

                    LoanAccount la = new LoanAccount();
                    la.setAccDate(DateFullCurrent);
                    la.setDebit(paid1 - finalintrest);
                    la.setCredit(0.0);
                    la.setDescription("payment cancel #" + contractNo);
                    la.setIsActive("Active");

                    InterestAccount ia = new InterestAccount();
                    ia.setAccDate(DateFullCurrent);
                    ia.setDebit(finalintrest);
                    ia.setCredit(0.0);
                    ia.setDescription("payment cancel #" + contractNo);
                    ia.setIsActive("Active");

                    AccruedIncomeAccount acc = new AccruedIncomeAccount();
                    acc.setAccDate(DateFullCurrent);
                    acc.setCredit(paid1);
                    acc.setDebit(0.0);
                    acc.setDescription("payment cancel #" + contractNo);
                    acc.setIsActive("Active");

                    CashInHandAcc cash = new CashInHandAcc();

                    cash.setAccDate(DateFullCurrent);
                    cash.setCredit(paid1);
                    cash.setDebit(0.0);
                    cash.setDescription("Payment cancel #" + contractNo);
                    cash.setIsActive("Active");

                    uniqueResult.setIsAproved("Approve");
                    uniqueResult.getRepayment().setIsActive("Deactive");
                    uniqueResult.getRepayment().getLoan().setStatus("Unpaid");
                    sess.update(uniqueResult);
                    sess.save(cash);
                    sess.save(acc);
                    sess.save(la);
                    sess.save(ia);

                    tr.commit();
                    // out.write("" + tr.wasCommitted());
                }

                if (tr.wasCommitted()) {

                    try {

                        System.out.println("Start search payments");
                        Session openSession = PoolManager.getSessionFactory().openSession();

                        double loanAmo = interest + Loanamount;

                        Criteria cr0 = openSession.createCriteria(Repayment.class);
                        cr0.createAlias("loan", "l");
                        cr0.add(Restrictions.eq("l.idLoan", idloan));
                        cr0.add(Restrictions.eq("isActive", "Active"));
                        cr0.setProjection(Projections.sum("paidAmount"));
                        List list = cr.list();

                        double totalPaid = 0;

                        try {
                            if (!list.isEmpty()) {

                                totalPaid = Double.parseDouble(list.get(0).toString());
                            }

                        } catch (Exception e) {
                        }

                        System.out.println("Checking Loan");
                        if (totalPaid == loanAmo) {
                            System.out.println("Loan Setteld");
//                            Session session1 = PoolManager.getSessionFactory().openSession();
                            Criteria createCriteria = openSession.createCriteria(Loan.class);
                            createCriteria.add(Restrictions.eq("idLoan", idloan));
                            Loan uq = (Loan) createCriteria.uniqueResult();
                            uq.setStatus("Paid");
                            openSession.update(uq);
                            openSession.beginTransaction().commit();
                            System.out.println("Settement saved");
                        } else if (totalPaid > loanAmo) {

                            System.out.println("Loan Setteld");
//                            Session session1 = PoolManager.getSessionFactory().openSession();
                            Criteria createCriteria = openSession.createCriteria(Loan.class);
                            createCriteria.add(Restrictions.eq("idLoan", idloan));
                            Loan uq = (Loan) createCriteria.uniqueResult();
                            uq.setStatus("Paid");
                            openSession.update(uq);
                            openSession.beginTransaction().commit();
                            System.out.println("Settement saved");

                        } else if (totalPaid < loanAmo) {

                            System.out.println("Loan Not Setteld");
//                            Session session1 = PoolManager.getSessionFactory().openSession();
                            Criteria createCriteria = openSession.createCriteria(Loan.class);
                            createCriteria.add(Restrictions.eq("idLoan", idloan));
                            Loan uq = (Loan) createCriteria.uniqueResult();
                            uq.setStatus("Unpaid");
                            openSession.update(uq);
                            openSession.beginTransaction().commit();
                            System.out.println("Settement saved");

                        }

                        openSession.close();

                    } catch (Exception e) {
                    }

                    response.sendRedirect("../CMC/Approvals/LoanRepaymentCancellationAprovel.jsp?Aprove=success");
                } else {

                    out.write("err");

                }

                sess.close();

                //    
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
