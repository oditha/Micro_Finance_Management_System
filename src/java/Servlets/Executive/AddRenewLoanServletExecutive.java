package Servlets.Executive;

import ORM.AccruedIncomeAccount;
import ORM.CashInHandAcc;
import ORM.InterestAccount;
import Servlets.MicroFinance.*;
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

@WebServlet(name = "AddRenewLoanServletExecutive", urlPatterns = {"/AddRenewLoanServletExecutive"})
public class AddRenewLoanServletExecutive extends HttpServlet {

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
                System.out.println("Loan Issue " + LoanIssue);
                String date = dateFormat.DateFullCurrent();

                Session session = PoolManager.getSessionFactory().openSession();
                Transaction beginTransaction = session.beginTransaction();

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
                loan.setIsActive("Pending");
                loan.setIsAprove("Pending");
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
                r.setIsActive("Renew");
                r.setIsAproved("Renew");
                r.setLoan(loan1);
                r.setPaidAmount(Double.parseDouble(paid));
                r.setRepaymentAmount(Double.parseDouble(Installment));
                String rno = dateFormat.ContractNo() + "#" + request.getSession().getAttribute("id") + x;
                r.setRecieptNo(rno);
                r.setArreas("ExePayment");
                
                session.save(r);

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
