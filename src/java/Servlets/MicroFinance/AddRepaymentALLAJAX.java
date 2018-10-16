package Servlets.MicroFinance;

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
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet(name = "AddRepaymentALLAJAX", urlPatterns = {"/AddRepaymentALLAJAX"})
public class AddRepaymentALLAJAX extends HttpServlet {

    public static Map<String, String> RepaymentMap = new HashMap<String, String>();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {

                String user = request.getSession().getAttribute("userName").toString();

                String parameter = request.getParameter("json");

                JSONArray ja = new JSONArray(parameter);

                System.out.println(ja);

                int x = 0;

                for (int i = 0; i < ja.length(); i++) {

                    JSONObject jsonObject = ja.getJSONObject(i);
                    String installment = jsonObject.get("repayment").toString();
                    String Paid = jsonObject.get("Paid").toString();
                    String acDay = jsonObject.get("acDay").toString();
                    String idLoan = jsonObject.get("idLoan").toString();
                    String Loan = jsonObject.get("Loan").toString();
                    String DateFullCurrent = dateFormat.DateFullCurrent();
                    String DayOnly = dateFormat.DayOnly();
                    double Loanamount = 0.0;
                    double interest = 0.0;
                    double interestIncome = 0.0;
                    double installmentloan = 0.0;
                    double persontageintrestIncome = 0.0;
                    double finalintrest = 0.0;
                    int period = 0;
                    String contractNo = "";
                    if (!Paid.equals("")) {

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
                            finalintrest = Double.parseDouble(Paid) * persontageintrestIncome / 100;
                            finalintrest = Math.round(finalintrest);
                            System.out.println("finalintrest" + finalintrest);
                            contractNo = uniqueResult1.getContractNo();

                        }

                        //-------------------------------------------------------    
                        Transaction beginTransaction = session.beginTransaction();
                        Criteria cr5 = session.createCriteria(Repayment.class);
                        List<Repayment> list5 = cr5.list();
                        x = list5.size();
                        x++;
                        Loan loan = new Loan();
                        loan.setIdLoan(Integer.parseInt(idLoan));

                        Repayment repayment = new Repayment();

                        try {
                            repayment.setCreatedBy(user);
                            repayment.setRepaymentAmount(Double.parseDouble(installment));
                            repayment.setPaidAmount(Double.parseDouble(Paid));
                            repayment.setActualDay(acDay);
                            repayment.setLoan(loan);
                            repayment.setDate(DateFullCurrent);
                            repayment.setActualDay(acDay);
                            repayment.setCurrentDay(DayOnly);
                            repayment.setIsActive("Active");
                            repayment.setIsAproved("Approve");
                            String rno = dateFormat.ContractNo() + "#" + request.getSession().getAttribute("id") + x;
                            repayment.setRecieptNo(rno);
                            repayment.setArreas("ExePayment");
                        } catch (Exception e) {
                        }
                        session.save(repayment);

                        LoanAccount la = new LoanAccount();
                        la.setAccDate(DateFullCurrent);
                        la.setCredit(Double.parseDouble(Paid) - finalintrest);
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
                        acc.setDebit(Double.parseDouble(Paid));
                        acc.setCredit(0.0);
                        acc.setDescription("Repayment for Loan #" + contractNo);
                        acc.setIsActive("Active");
                        session.save(acc);

                        CashInHandAcc cash = new CashInHandAcc();

                        cash.setAccDate(DateFullCurrent);
                        cash.setDebit(Double.parseDouble(Paid));
                        cash.setCredit(0.0);
                        cash.setDescription("Repayment for Loan #" + contractNo);
                        cash.setIsActive("Active");

                        session.save(cash);

                        beginTransaction.commit();
                        session.close();

                        System.out.println("Start search payments");
                        Session openSession = PoolManager.getSessionFactory().openSession();
                        Criteria cr = openSession.createCriteria(Repayment.class);
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
                        

                        double loanAmo = Double.parseDouble(Loan);
                        System.out.println("Checking Loan");
                        if (totalPaid == loanAmo) {
                            System.out.println("Loan Setteld");
//                            Session session1 = PoolManager.getSessionFactory().openSession();
                            Criteria createCriteria = openSession.createCriteria(Loan.class);
                            createCriteria.add(Restrictions.eq("idLoan", Integer.parseInt(idLoan)));
                            Loan uniqueResult = (Loan) createCriteria.uniqueResult();
                            uniqueResult.setStatus("Paid");
                            openSession.update(uniqueResult);
                            openSession.beginTransaction().commit();
                            System.out.println("Settement saved");
                        } else if (totalPaid > loanAmo) {

                            System.out.println("Loan Setteld");
//                            Session session1 = PoolManager.getSessionFactory().openSession();
                            Criteria createCriteria = openSession.createCriteria(Loan.class);
                            createCriteria.add(Restrictions.eq("idLoan", Integer.parseInt(idLoan)));
                            Loan uniqueResult = (Loan) createCriteria.uniqueResult();
                            uniqueResult.setStatus("Paid");
                            openSession.update(uniqueResult);
                            openSession.beginTransaction().commit();
                            System.out.println("Settement saved");

                        }
                        openSession.close();

                    }

                }

                out.write("ok");
//            PoolManager.getSessionFactory().openSession().close();
            } catch (Exception e) {

                out.write("" + e);
                e.printStackTrace();

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
