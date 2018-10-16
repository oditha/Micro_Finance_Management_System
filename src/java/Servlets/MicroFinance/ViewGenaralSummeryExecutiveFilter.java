package Servlets.MicroFinance;

import ORM.Center;
import ORM.CenterHasStaff;
import ORM.Loan;
import ORM.Members;
import ORM.Repayment;

import Singleton.decimalFormat;
import Srcs.PoolManager;
import Srcs.WeeksCount;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
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

@WebServlet(name = "ViewGenaralSummeryExecutiveFilter", urlPatterns = {"/ViewGenaralSummeryExecutiveFilter"})
public class ViewGenaralSummeryExecutiveFilter extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {

                String executiveid = request.getParameter("executiveid");

                Session s = PoolManager.getSessionFactory().openSession();

                Criteria cr = s.createCriteria(Center.class);

                cr.add(Restrictions.eq("isActive", "Active"));

                List<Center> list = cr.list();
                JSONArray ja = new JSONArray();
                int activeMembers = 0;
                double activeLoans = 0;
                double Recovery = 0;
                double LOAN = 0;
                double inter = 0;
                double rate = 0;
                double futureRecovery = 0;
                double futureCapital = 0;
                double arr = 0;
                double futureInter = 0;

                double arries = 0;
                double Expire = 0;

                double loanAmount = 0;
                double ExptotalPaid = 0;

                double ArrPaid = 0;
                double ArrRepayAmount = 0;

                double arresage = 0;

                double presentage = 0;

                double totinstallment = 0;

                for (Center cen : list) {

                    Iterator iterator = cen.getCenterHasStaffs().iterator();
                    while (iterator.hasNext()) {
                        CenterHasStaff next = (CenterHasStaff) iterator.next();

                        if (next.getStaff().getIdStaff() == Integer.parseInt(executiveid)) {

                            //   Center cen = (Center) cr.uniqueResult();
                            Iterator it = cen.getMemberses().iterator();
                            while (it.hasNext()) {
                                Members mem = (Members) it.next();
                                if (mem.getIsActive().equals("Active")) {

                                    activeMembers++;

                                }

                                Iterator it2 = mem.getLoans().iterator();
                                while (it2.hasNext()) {

                                    Loan loan = (Loan) it2.next();

                                    if (loan.getIsActive().equals("Active") && loan.getIsAprove().equals("Approve") && loan.getStatus().equals("Unpaid")) {

                                        activeLoans += loan.getLoanAmount() + loan.getLoanInterest();

                                        inter += loan.getLoanInterest();
                                        LOAN += loan.getLoanAmount();
                                        totinstallment += loan.getLoanInstallment();
                                        Set<Repayment> set = loan.getRepayments();
                                        int size = set.size();
                                        Iterator it3 = set.iterator();

                                        int weeksCount = WeeksCount.weeksCount(loan.getIssueDate(), loan.getRepaymentDay());
                                        if (loan.getLoanPeriod() < weeksCount) {

                                            loanAmount += loan.getLoanAmount();
                                            Iterator it13 = loan.getRepayments().iterator();
                                            while (it13.hasNext()) {

                                                Repayment repay = (Repayment) it13.next();
                                                if (repay.getIsActive().equals("Active") && repay.getIsAproved().equals("Approve")) {
                                                    ExptotalPaid += repay.getPaidAmount();
                                                }
                                            }
                                        } else if (loan.getLoanPeriod() > weeksCount) {

                                            Iterator iter = loan.getRepayments().iterator();
                                            ArrRepayAmount = loan.getLoanInstallment() * size;

                                            while (iter.hasNext()) {

                                                Repayment repay = (Repayment) iter.next();
                                                if (repay.getIsActive().equals("Active") && repay.getIsAproved().equals("Approve")) {
                                                    ArrPaid += repay.getPaidAmount();
                                                }
                                            }

                                        }

                                        while (it3.hasNext()) {
                                            Repayment re = (Repayment) it3.next();
                                            if (re.getIsActive().equalsIgnoreCase("Active")) {
                                                if (re.getIsActive().equals("Active") && re.getIsAproved().equals("Approve")) {
                                                    Recovery += re.getPaidAmount();
                                                }
                                            }

                                        }

                                    }

                                }

                            }

                            futureRecovery = activeLoans - Recovery;
                            rate = inter * 100 / LOAN;

                            futureInter = futureRecovery * rate / 100;
                            double cap = 100 - rate;

                            futureCapital = futureRecovery * cap / 100;

                            arries = ArrRepayAmount - ArrPaid;

                            if (arries > 0) {

                                arr = arries;

                            }

                            Expire = loanAmount - ExptotalPaid;

                            double totalarr = arr + Expire;

                            arresage = totalarr / totinstallment;

                            presentage = Recovery / activeLoans * 100;

                        }

                    }

                }
                JSONObject jo = new JSONObject();

                jo.put("activemembers", activeMembers);
                jo.put("activeloans", decimalFormat.setAmount(activeLoans));
                jo.put("activerecovery", decimalFormat.setAmount(Recovery));
                jo.put("futureRecovery", decimalFormat.setAmount(futureRecovery));
                jo.put("futurecapital", decimalFormat.setAmount(futureCapital));
                jo.put("futureInterest", decimalFormat.setAmount(futureInter));
                jo.put("arrears", decimalFormat.setAmount(arr));
                jo.put("Expire", decimalFormat.setAmount(Expire));
                jo.put("age", decimalFormat.setAmount(arresage));
                jo.put("pre", Math.round(presentage) + "%");

                ja.put(jo);
                s.close();
                out.write(ja.toString());
            } catch (Exception e) {

                out.write("error");

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
