package Servlets.Executive;

import ORM.CashInHandAcc;
import Servlets.MicroFinance.*;
import ORM.Loan;
import ORM.LoanAccount;
import ORM.Members;
import ORM.OtherIncomeAcc;

import Singleton.dateFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;

@WebServlet(name = "AddLoanServletExecutive", urlPatterns = {"/AddLoanServletExecutive"})
public class AddLoanServletExecutive extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {

                String user = request.getSession().getAttribute("userName").toString();

                String contractNo = request.getParameter("contractNo");
                String LoanIndex = request.getParameter("LoanIndex");
                String idMembers = request.getParameter("idMembers");
                String loanamount = request.getParameter("loanamount");
                String loanInterest = request.getParameter("loanInterest");
                String loanPeriod = request.getParameter("loanPeriod");
                String loanInstallment = request.getParameter("loanInstallment");
                String loancenterDay = request.getParameter("loancenterDay");
                String loanfee = request.getParameter("loanfee");
                String loanGuarantor1 = request.getParameter("loanGuarantor1");
                String loanGuarantor2 = request.getParameter("loanGuarantor2");
                String LoanIssue = request.getParameter("LoanIssue");

                String date = dateFormat.DateFullCurrent();

                Session session = PoolManager.getSessionFactory().openSession();
                Transaction beginTransaction = session.beginTransaction();

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
                loan.setIsActive("Pending");
                loan.setIsAprove("Pending");
                loan.setRenewAmount(Double.parseDouble(loanamount));
                loan.setIssueDate(dateFormat.setDateFull(LoanIssue));

                
                
                //-------------
                
//                
//                   LoanAccount la = new LoanAccount();
//                la.setAccDate(dateFormat.DateFullCurrent());
//                la.setCredit(0.0);
//                la.setDebit(Double.parseDouble(loanamount));
//                la.setDescription("Repayment for Loan #" + loan.getContractNo());
//                la.setIsActive("Active");
//
//                //-----------------
//                CashInHandAcc cash = new CashInHandAcc();
//                cash.setAccDate(dateFormat.DateFullCurrent());
//                cash.setDebit(0.0);
//                cash.setCredit(Double.parseDouble(loanamount));
//                cash.setDescription("Repayment for Loan #" + loan.getContractNo());
//                cash.setIsActive("Active");
//
//                CashInHandAcc cahmemberfee = new CashInHandAcc();
//                cahmemberfee.setAccDate(dateFormat.DateFullCurrent());
//                cahmemberfee.setDebit(Double.parseDouble(loanfee));
//                cahmemberfee.setCredit(0.0);
//                cahmemberfee.setDescription("Memberfee for Loan #" + loan.getContractNo());
//                cahmemberfee.setIsActive("Active");
//
//                OtherIncomeAcc otherIncomeAcc = new OtherIncomeAcc();
//                otherIncomeAcc.setAccDate(dateFormat.DateFullCurrent());
//                otherIncomeAcc.setCredit(Double.parseDouble(loanfee));
//                otherIncomeAcc.setDebit(0.0);
//                otherIncomeAcc.setDescription("Memberfee for Loan #" + loan.getContractNo());
//                otherIncomeAcc.setIsActive("Active");
//                
//                
//                session.save(otherIncomeAcc);
//
//                session.save(cahmemberfee);
//                session.save(cash);
//                session.save(la);
//                
                
                
                
                
                session.save(loan);
                beginTransaction.commit();

                session.close();
                response.sendRedirect("Executive/addLoan.jsp?save=done");
            } catch (Exception e) {

                response.sendRedirect("Executive/addLoan.jsp?save=error");

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
