package Servlets.MicroFinance;

import Holders.PayReceiptHolder;
import ORM.AccruedIncomeAccount;
import ORM.CashInHandAcc;
import ORM.InterestAccount;
import ORM.Loan;
import ORM.LoanAccount;
import ORM.Repayment;

import Singleton.dateFormat;
import Singleton.decimalFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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

@WebServlet(name = "AddRepaymentServlet", urlPatterns = {"/AddRepaymentServlet"})
public class AddRepaymentServlet extends HttpServlet {

    public static Map<String, Object> mapReceipt = new HashMap();
    public static int id;
    public static List<PayReceiptHolder> holder = new ArrayList<>();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {
                int x = 0;
                String user = request.getSession().getAttribute("userName").toString();

                String installment = request.getParameter("installment");
                String loanAmount = request.getParameter("loanamount");
                String paid = request.getParameter("Paid");
                String dday = request.getParameter("dday");
                String idLoan = request.getParameter("IdLoan");
                String Arrears = request.getParameter("Arrears");

                String memno = request.getParameter("memberNo");
                String memname = request.getParameter("memberName");
                String contractno = request.getParameter("contractNo");
                String Center = request.getParameter("Center");
                String Balance = request.getParameter("Balance");

                String DateFullCurrent = dateFormat.DateFullCurrent();
                String DayOnly = dateFormat.DayOnly();
                double paidAmount = Double.parseDouble(paid);
                double Loanamount = 0.0;
                double interest = 0.0;
                double interestIncome = 0.0;
                double installmentloan = 0.0;
                double persontageintrestIncome = 0.0;
                double finalintrest = 0.0;
                int period = 0;
                String contractNo = null;

//                Session sess = PoolManager.getSessionFactory().openSession();
                Session session = PoolManager.getSessionFactory().openSession();
                Criteria cr7 = session.createCriteria(Loan.class);

                cr7.add(Restrictions.eq("idLoan", Integer.parseInt(idLoan)));
                Loan uniqueResult1 = (Loan) cr7.uniqueResult();

                if (uniqueResult1 != null) {

                    Loanamount = uniqueResult1.getLoanAmount();
                    interest = uniqueResult1.getLoanInterest();
                    period = uniqueResult1.getLoanPeriod();
                    installmentloan = uniqueResult1.getLoanInstallment();

                    interestIncome = interest / period;

                    System.out.println("interestIncome" + interestIncome);

                    persontageintrestIncome = (interestIncome * 100) / installmentloan;
                    persontageintrestIncome = Math.round(persontageintrestIncome);
                    System.out.println("persontage income" + persontageintrestIncome);
                    finalintrest = Double.parseDouble(paid) * persontageintrestIncome / 100;
                    finalintrest = Math.round(finalintrest);
                    System.out.println("finalintrest" + finalintrest);
                    contractNo = uniqueResult1.getContractNo();

                }

                Transaction beginTransaction = session.beginTransaction();
                Criteria cr5 = session.createCriteria(Repayment.class);
                List<Repayment> list5 = cr5.list();
                x = list5.size();
                x++;
                Loan loan = new Loan();
                loan.setIdLoan(Integer.parseInt(idLoan));

                Repayment repayment = new Repayment();

                repayment.setCreatedBy(user);
                repayment.setRepaymentAmount(Double.parseDouble(installment));
                repayment.setPaidAmount(Double.parseDouble(paid));
                repayment.setActualDay(dday);
                repayment.setLoan(loan);
                repayment.setDate(DateFullCurrent);
                repayment.setActualDay(dday);
                repayment.setCurrentDay(DayOnly);
                repayment.setIsActive("Active");
                repayment.setIsAproved("Approve");
                String rno = dateFormat.ContractNo() + "#" + request.getSession().getAttribute("id") + x;

                repayment.setRecieptNo(rno);
                repayment.setArreas("ExePayment");
                session.save(repayment);
                System.out.println("Repayment Saved");

                LoanAccount la = new LoanAccount();
                la.setAccDate(DateFullCurrent);
                la.setCredit(paidAmount - finalintrest);
                la.setDebit(0.0);
                la.setDescription("Repayment for Loan #" + contractNo);
                la.setIsActive("Active");
                session.save(la);

                InterestAccount ia = new InterestAccount();
                ia.setAccDate(DateFullCurrent);
                ia.setCredit(finalintrest);
                ia.setDebit(0.0);
                ia.setDescription("Repayment for Loan #" + contractNo);
                ia.setIsActive("Active");
                session.save(ia);

                AccruedIncomeAccount acc = new AccruedIncomeAccount();
                acc.setAccDate(DateFullCurrent);
                acc.setDebit(paidAmount);
                acc.setCredit(0.0);
                acc.setDescription("Repayment for Loan #" + contractNo);
                acc.setIsActive("Active");
                session.save(acc);

                CashInHandAcc cash = new CashInHandAcc();

                cash.setAccDate(DateFullCurrent);
                cash.setDebit(paidAmount);
                cash.setCredit(0.0);
                cash.setDescription("Repayment for Loan #" + contractNo);
                cash.setIsActive("Active");
                session.save(cash);

                beginTransaction.commit();
                session.close();
                System.out.println("Loan Data Saved");

                System.out.println("Start Search Repayment");
                Session sess = PoolManager.getSessionFactory().openSession();
                Criteria cr = sess.createCriteria(Repayment.class);
                cr.createAlias("loan", "l");
                cr.add(Restrictions.eq("l.idLoan", Integer.parseInt(idLoan)));
                cr.add(Restrictions.eq("isActive", "Active"));
                cr.setProjection(Projections.sum("paidAmount"));
                List list = cr.list();

                double totalPaid = 0;

                try {
                    if (!list.isEmpty()) {

                        totalPaid = Double.parseDouble(list.get(0).toString());
                    }

                } catch (Exception e) {
                }

                double loanAmo = Double.parseDouble(loanAmount);
                System.out.println("Repayment Searched");
                if (totalPaid == loanAmo) {
                    System.out.println("Loan Settled");
                    Criteria createCriteria = sess.createCriteria(Loan.class);
                    createCriteria.add(Restrictions.eq("idLoan", Integer.parseInt(idLoan)));
                    Loan uniqueResult = (Loan) createCriteria.uniqueResult();
                    uniqueResult.setStatus("Paid");
                    sess.update(uniqueResult);
                    sess.beginTransaction().commit();

                    System.out.println("Loan Settle saved");
                }

                sess.close();

                holder.clear();
                PayReceiptHolder pay = new PayReceiptHolder();
                pay.setCashier(user);
                pay.setMembername(memname);
                pay.setMemberno(memno.toUpperCase());
                pay.setCenter(Center);
                pay.setContractno(contractNo);
                pay.setReceiptno(rno);
                pay.setLoan(decimalFormat.setAmount(Double.parseDouble(loanAmount)));
                pay.setPaid(decimalFormat.setAmount(paidAmount));

                if (Double.parseDouble(Arrears) == 0 || Double.parseDouble(Arrears) < 0) {

                    pay.setArreas("0.00");
                } else {

                    pay.setArreas(decimalFormat.setAmount(Double.parseDouble(Arrears) - paidAmount));

                }

                pay.setPrebalance(decimalFormat.setAmount(Double.parseDouble(Balance)));
                pay.setNewbalance(decimalFormat.setAmount(Double.parseDouble(Balance) - paidAmount));

                holder.add(pay);

                response.sendRedirect("MicroFinance/addRepayment.jsp?save=done");

            } catch (Exception e) {

                response.sendRedirect("MicroFinance/addRepayment.jsp?save=error");

                out.write("" + e);
                System.out.println(e);
            }

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
