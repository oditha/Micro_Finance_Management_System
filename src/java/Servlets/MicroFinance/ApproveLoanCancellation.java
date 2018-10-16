package Servlets.MicroFinance;

import ORM.CashInHandAcc;
import ORM.LoanAccount;
import ORM.Loancancellation;
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
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

@WebServlet(name = "ApproveLoanCancellation", urlPatterns = {"/ApproveLoanCancellation"})
public class ApproveLoanCancellation extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {

            PrintWriter out = response.getWriter();

            Session sess = PoolManager.getSessionFactory().openSession();
            Criteria cr = sess.createCriteria(Loancancellation.class);
            cr.add(Restrictions.eq("idLoanCancellation", Integer.parseInt(request.getParameter("hid"))));
            Transaction tr = sess.beginTransaction();

            Loancancellation uq = (Loancancellation) cr.uniqueResult();

            if (uq != null) {

                uq.setIsAproved("Aproved");
                uq.getLoan().setIsActive("Deactive");
                uq.getLoan().setStatus("Paid");

                LoanAccount la = new LoanAccount();
                la.setAccDate(dateFormat.DateFullCurrent());
                la.setCredit(uq.getLoan().getLoanAmount());
                la.setDebit(0.0);
                la.setDescription("Loan cancellactin for Loan #" + uq.getLoan().getContractNo());
                la.setIsActive("Active");

                //-----------------
                CashInHandAcc cash = new CashInHandAcc();
                cash.setAccDate(dateFormat.DateFullCurrent());
                cash.setDebit(uq.getLoan().getLoanAmount());
                cash.setCredit(0.0);
                cash.setDescription("Loan cancellation for Loan #" + uq.getLoan().getContractNo());
                cash.setIsActive("Active");

                CashInHandAcc cahmemberfee = new CashInHandAcc();
                cahmemberfee.setAccDate(dateFormat.DateFullCurrent());
                cahmemberfee.setDebit(0.0);
                cahmemberfee.setCredit(uq.getLoan().getLoanAmount());
                cahmemberfee.setDescription(" loan Memberfee for Loan #" + uq.getLoan().getContractNo());
                cahmemberfee.setIsActive("Active");

                OtherIncomeAcc otherIncomeAcc = new OtherIncomeAcc();
                otherIncomeAcc.setAccDate(dateFormat.DateFullCurrent());
                otherIncomeAcc.setCredit(0.0);
                otherIncomeAcc.setDebit(uq.getLoan().getLoanAmount());
                otherIncomeAcc.setDescription("loan Memberfee for Loan #" + uq.getLoan().getContractNo());
                otherIncomeAcc.setIsActive("Active");

                sess.save(otherIncomeAcc);

                sess.save(cahmemberfee);
                sess.save(cash);
                sess.save(la);

                sess.update(uq);

                tr.commit();

                sess.close();
                response.sendRedirect("../CMC/Approvals/LoanCancellationAprovel.jsp?aprovel=success");

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
