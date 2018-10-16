package Servlets.MicroFinance;

import ORM.Loan;
import ORM.Repayment;
import Singleton.dateFormat;

import Singleton.decimalFormat;
import Srcs.CompareDates;
import Srcs.GetActualDate;
import Srcs.PoolManager;
import Srcs.WeeksCount;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.TreeMap;
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

@WebServlet(name = "ViewLedgerReportLoan", urlPatterns = {"/ViewLedgerReportLoan"})
public class ViewLedgerReportLoan extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                double loanwithintrest = 0.0;
                String index = request.getParameter("index");
                String iDloan = request.getParameter("idLoan");
                Session openSession = PoolManager.getSessionFactory().openSession();
                Criteria createCriteria = openSession.createCriteria(Loan.class);

                createCriteria.add(Restrictions.eq("idLoan", Integer.parseInt(iDloan)));
//                createCriteria.add(Restrictions.eq("loanIndex", index));
                Loan loan = (Loan) createCriteria.uniqueResult();
                loanwithintrest = loan.getLoanAmount() + loan.getLoanInterest();

                int installmentcount = 0;

                double arreas = 0.00;

                double totPaid = 0;

                String repaymentDay = loan.getRepaymentDay();
                String issueDate = loan.getIssueDate();

                Set repayments = loan.getRepayments();

                int size = repayments.size();

                List ActualDays = GetActualDate.ActualDays(issueDate, repaymentDay, size);

                int i = 0;
                int i2 = 1;
                double age;
                String loanCloseDate = null;

                Iterator iterator = repayments.iterator();
                JSONArray jsonArray = new JSONArray();

                while (iterator.hasNext()) {

                    Repayment re = (Repayment) iterator.next();
                    if (re.getIsActive().equals("Active")) {

                        TreeMap<Integer, String> treeMap = new TreeMap<>();

                        totPaid += re.getPaidAmount();

                        installmentcount++;
                        JSONObject jsonObject = new JSONObject();
                        jsonObject.put("dates", re.getDate());
                        jsonObject.put("id", re.getIdRePayment());
                        jsonObject.put("ActualDays", ActualDays.get(i++));
                        jsonObject.put("paid", decimalFormat.setAmount(re.getPaidAmount()));
                        jsonObject.put("count", i2++);
                        jsonObject.put("receipt", re.getRecieptNo());

                        //  jsonObject.put("loanwithintrest", loanwithintrest);
                        jsonArray.put(jsonObject);

                        if (loan.getStatus().equals("Paid")) {

                            treeMap.put(re.getIdRePayment(), re.getDate());
                            Integer lastKey = treeMap.lastKey();

                            loanCloseDate = treeMap.get(lastKey);

                        } else {

                            loanCloseDate = "Loan Not Closed";

                        }

                    }

                }
                double balance = loanwithintrest - totPaid;
                String type = "N/A";
                if (totPaid < loanwithintrest) {
                    double defaultpay = 0.00;
                    int weeksCount = WeeksCount.weeksCount(loan.getIssueDate(), loan.getRepaymentDay());

                    if (weeksCount > loan.getLoanPeriod()) {
                        System.out.println("True");
                        
                        arreas = balance;
                        type = "Expired";
                    } else {
                        System.out.println("FALSE");
                        defaultpay = weeksCount * loan.getLoanInstallment();
                        arreas = defaultpay - totPaid;
                        type = "Ongoing";
                    }

                    age = arreas / loan.getLoanInstallment();

                } else {

                    arreas = 0;
                    age = 0;
                }

                int  remain = loan.getLoanPeriod() - installmentcount;
                
                openSession.close();

                out.write(decimalFormat.setAmount(loan.getLoanAmount()) + "&" + loan.getIssueDate() + "&"
                        + loan.getContractNo() + "&" + decimalFormat.setAmount(totPaid) + "&"
                        + loan.getLoanInterest() + "&" + loan.getGaranter1() + "&" + loan.getGaranter2()
                        + "&" + loanCloseDate + "&" + balance + "&" + arreas + "&" + age +"&"+type+"&"+installmentcount+"&"+remain+"&"+loan.getLoanPeriod()+ "$" + jsonArray);

            } catch (Exception e) {

                out.write("" + e);
                System.out.println(e);

            }
            PoolManager.getSessionFactory().openSession().close();
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
