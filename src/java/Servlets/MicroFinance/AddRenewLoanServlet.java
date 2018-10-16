package Servlets.MicroFinance;

import ORM.AccruedIncomeAccount;
import ORM.CashInHandAcc;
import ORM.InterestAccount;
import ORM.Loan;
import ORM.LoanAccount;
import ORM.Members;
import ORM.OtherIncomeAcc;
import ORM.Repayment;

import Singleton.dateFormat;
import Singleton.decimalFormat;
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
import org.hibernate.criterion.Restrictions;

@WebServlet(name = "AddRenewLoanServlet", urlPatterns = {"/AddRenewLoanServlet"})
public class AddRenewLoanServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {

                String user = request.getSession().getAttribute("userName").toString();

                String contractNo = request.getParameter("contractNo");
                String LoanIndex = request.getParameter("lindex");
                String idMembers = request.getParameter("memberid");
                String loanamount = request.getParameter("amount");
                String loanInterest = request.getParameter("Interest");
                String loanPeriod = request.getParameter("Period");
                String loanInstallment = request.getParameter("Installment");
                String loancenterDay = request.getParameter("reDay");
                String loanfee = request.getParameter("fee");
                String loanGuarantor1 = request.getParameter("Guarantor1");
                String loanGuarantor2 = request.getParameter("Guarantor2");
                String balance = request.getParameter("Balance");
                String Installment = request.getParameter("ins");
                String loanId = request.getParameter("loanid");
                String paid = request.getParameter("pLoan");
                String LoanIssue = request.getParameter("LoanIssue1");
                System.out.println(LoanIssue);
                String date = dateFormat.DateFullCurrent();
                String contractNo1 = null;
                double Loanamount = 0.0;
                double interest = 0.0;
                double interestIncome = 0.0;
                double installmentloan = 0.0;
                double persontageintrestIncome = 0.0;
                double finalintrest = 0.0;
                int period = (int) 0.0;

                Session session = PoolManager.getSessionFactory().openSession();
                Transaction beginTransaction = session.beginTransaction();
                Criteria cr7 = session.createCriteria(Loan.class);

                cr7.add(Restrictions.eq("idLoan", Integer.parseInt(loanId)));
                Loan uniqueResult1 = (Loan) cr7.uniqueResult();

                if (uniqueResult1 != null) {

                    uniqueResult1.setStatus("Paid");
                    session.update(uniqueResult1);

                    Loanamount = uniqueResult1.getLoanAmount();
                    interest = uniqueResult1.getLoanInterest();
                    period = uniqueResult1.getLoanPeriod();
                    installmentloan = uniqueResult1.getLoanInstallment();

                    interestIncome = interest / period;

                    persontageintrestIncome = (interestIncome * 100) / installmentloan;
                    persontageintrestIncome = Double.parseDouble(decimalFormat.setAmount(persontageintrestIncome));
                    System.out.println("persontage income" + persontageintrestIncome);
                    finalintrest = Double.parseDouble(paid) * persontageintrestIncome / 100;

                    finalintrest = Double.parseDouble(decimalFormat.setAmount(finalintrest));

                    System.out.println("finalintrest" + finalintrest);
                    //contractNo=uniqueResult1.getContractNo()d

                }

                Criteria cr5 = session.createCriteria(Repayment.class);
                List<Repayment> list5 = cr5.list();
                int x = list5.size();
                x++;

                Members members = new Members();
                members.setIdMembers(Integer.parseInt(idMembers));

                Loan loan = new Loan();

                loan.setContractNo(contractNo);
                loan.setLoanIndex(LoanIndex);
                loan.setLoanAmount(Double.parseDouble(loanamount));
                loan.setLoanInterest(Double.parseDouble(loanInterest));
                loan.setLoanPeriod(Integer.parseInt(loanPeriod));
                loan.setLoanInstallment(Double.parseDouble(loanInstallment));
                loan.setRepaymentDay(loancenterDay);
                loan.setMemberfee(loanfee);
                loan.setGaranter1(loanGuarantor1);
                loan.setGaranter2(loanGuarantor2);
                loan.setLoanDate(date);
                loan.setMembers(members);
                loan.setStatus("Unpaid");
                loan.setCreateBy(user);
                loan.setIsActive("Active");
                loan.setIsAprove("Approve");
                loan.setRenewAmount(Double.parseDouble(balance));
                loan.setIssueDate(dateFormat.setDateFull(LoanIssue));

                session.save(loan);

                Loan loan1 = new Loan();
                loan1.setIdLoan(Integer.parseInt(loanId));

                Repayment r = new Repayment();

                r.setActualDay(loancenterDay);
                r.setCreatedBy(user);
                r.setCurrentDay(dateFormat.DayOnly());
                r.setDate(date);
                r.setIsActive("Active");
                r.setIsAproved("Renew");
                r.setLoan(loan1);
                r.setPaidAmount(Double.parseDouble(paid));
                r.setRepaymentAmount(Double.parseDouble(Installment));
                String rno = dateFormat.ContractNo() + "#" + request.getSession().getAttribute("id") + x;
                r.setRecieptNo(rno);
                r.setArreas("ExePayment");

                //---------------------------------------------------
                LoanAccount la = new LoanAccount();
                la.setAccDate(dateFormat.DateFullCurrent());
                la.setCredit(Double.parseDouble(paid) - finalintrest);
                la.setDebit(0.0);
                la.setDescription("Repayment for Loan #" + contractNo1);
                la.setIsActive("Active");

                InterestAccount ia = new InterestAccount();
                ia.setAccDate(dateFormat.DateFullCurrent());
                ia.setCredit(finalintrest);
                ia.setDebit(0.0);
                ia.setDescription("Repayment for Loan #" + contractNo1);
                ia.setIsActive("Active");

                AccruedIncomeAccount acc = new AccruedIncomeAccount();
                acc.setAccDate(dateFormat.DateFullCurrent());
                acc.setDebit(Double.parseDouble(paid));
                acc.setCredit(0.0);
                acc.setDescription("Repayment for Loan #" + loan.getContractNo());
                acc.setIsActive("Active");

                CashInHandAcc cash = new CashInHandAcc();

                cash.setAccDate(dateFormat.DateFullCurrent());
                cash.setDebit(Double.parseDouble(paid));
                cash.setCredit(0.0);
                cash.setDescription("Repayment for Loan #" + contractNo1);
                cash.setIsActive("Active");

                session.save(cash);
                session.save(acc);
                session.save(la);
                session.save(ia);

                //-------------------
                LoanAccount la1 = new LoanAccount();
                la.setAccDate(dateFormat.DateFullCurrent());
                la.setCredit(0.0);
                la.setDebit(Double.parseDouble(loanamount));
                la.setDescription("Repayment for Loan #" + contractNo);
                la.setIsActive("Active");

                //-----------------
                CashInHandAcc cash1 = new CashInHandAcc();
                cash.setAccDate(dateFormat.DateFullCurrent());
                cash.setDebit(0.0);
                cash.setCredit(Double.parseDouble(loanamount));
                cash.setDescription("Repayment for Loan #" + contractNo);
                cash.setIsActive("Active");
//------------

                CashInHandAcc cahmemberfee = new CashInHandAcc();
                cahmemberfee.setAccDate(dateFormat.DateFullCurrent());
                cahmemberfee.setDebit(Double.parseDouble(loanfee));
                cahmemberfee.setCredit(0.0);
                cahmemberfee.setDescription("Memberfee for Loan #" + loan.getContractNo());
                cahmemberfee.setIsActive("Active");

                OtherIncomeAcc otherIncomeAcc = new OtherIncomeAcc();
                otherIncomeAcc.setAccDate(dateFormat.DateFullCurrent());
                otherIncomeAcc.setCredit(Double.parseDouble(loanfee));
                otherIncomeAcc.setDebit(0.0);
                otherIncomeAcc.setDescription("Memberfee for Loan #" + loan.getContractNo());
                otherIncomeAcc.setIsActive("Active");

                session.save(otherIncomeAcc);

                session.save(cahmemberfee);

                session.save(cash1);
                session.save(la1);

                session.save(r);

                beginTransaction.commit();

                session.close();
                response.sendRedirect("MicroFinance/addLoan.jsp?save=done");
            } catch (Exception e) {

                response.sendRedirect("MicroFinance/addLoan.jsp?save=error");

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
