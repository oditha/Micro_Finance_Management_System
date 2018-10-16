package Servlets.MicroFinance;

import ORM.Loan;
import ORM.Members;
import ORM.Repayment;

import Singleton.dateFormat;
import Singleton.decimalFormat;
import Srcs.PoolManager;
import Srcs.WeeksCount;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.List;
import java.util.Objects;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.SimpleExpression;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet(name = "SearchRepaymentDataAJAX", urlPatterns = {"/SearchRepaymentDataAJAX"})
public class SearchRepaymentDataAJAX extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {

                String Restric = "nic";
                String parameter = request.getParameter("value");
                char charAt = parameter.charAt(0);

                if (!parameter.contains("/")) {

                    Restric = "nic";

                } else {

                    Restric = "memberNo";

                }
                Session openSession = PoolManager.getSessionFactory().openSession();
                Criteria createCriteria = openSession.createCriteria(Members.class);
                createCriteria.add(Restrictions.eq(Restric, parameter));
                createCriteria.add(Restrictions.eq("isActive", "Active"));
                Members ur = (Members) createCriteria.uniqueResult();

                if (ur != null) {

                    String nameWithInitials = ur.getNameWithInitials();
                    Integer idMembers = ur.getIdMembers();

                    Criteria cr = openSession.createCriteria(Loan.class);
                    cr.createAlias("members", "m");
                    cr.add(Restrictions.eq("m.idMembers", idMembers));
                    cr.add(Restrictions.eq("status", "Unpaid"));
                    cr.add(Restrictions.eq("isActive", "Active"));

                    Loan uq = (Loan) cr.uniqueResult();

                    if (uq != null) {

                        int weeksCount = 0;

                        try {
                            weeksCount = WeeksCount.weeksCount(uq.getIssueDate(), uq.getRepaymentDay());
                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                        double installment = 0.0;
                        int loanID = 0;
                        String day;
                        double loan = 0;
                        String contractNo;
                        double inter = 0;
                        double amount = 0;
                        double bal = 0;
                        String center;
                        double Arrears = 0.0;

                        try {

                            installment = uq.getLoanInstallment();
                            loanID = uq.getIdLoan();
                            day = uq.getRepaymentDay();
                            loan = uq.getLoanAmount();
                            contractNo = uq.getContractNo();
                            inter = uq.getLoanInterest();
                            center = uq.getMembers().getCenter().getCenterName();
                            String toString = null;
                            amount = loan + inter;

                            Criteria c = openSession.createCriteria(Repayment.class);
                            c.createAlias("loan", "l");
//                        c.add(Restrictions.eq("l.idLoan", loanID));
//                        c.add(Restrictions.eq("isActive", "Active"));
                            SimpleExpression active = Restrictions.eq("isActive", "Active");
                            SimpleExpression lid = Restrictions.eq("l.idLoan", loanID);
                            c.add(Restrictions.and(lid, active));
                            c.setProjection(Projections.sum("paidAmount"));
                            List list = c.list();
                            System.out.println(list);
                            System.out.println(list.size());
                            try {

                                if (list.get(0) != null) {
                                    toString = list.get(0).toString();

                                } else {

                                    toString = "0.00";

                                }

                            } catch (Exception e) {
                                e.printStackTrace();
                            }

                            if (toString != null) {

                                bal = amount - Double.parseDouble(toString);

                                System.out.println("Bal " + bal);

                            } else {

                                bal = amount;
                                System.out.println("Bal " + bal);

                            }

                            Arrears = (installment * weeksCount) - Double.parseDouble(toString);
                            ///out.write("" + Arrears);

                            JSONArray jsonArray = new JSONArray();
                            JSONObject js = new JSONObject();

                            js.put("memberName", nameWithInitials);
                            js.put("dday", day);
                            js.put("loanamount", amount);
                            js.put("IdLoan", loanID);
                            js.put("installment", installment);
                            js.put("contractNo", contractNo);
                            js.put("balance", bal);
                            js.put("center", center);
                            js.put("Arrears", Arrears);
                            js.put("balance", (amount - Double.parseDouble(toString)));

                            jsonArray.put(js);

                            openSession.close();
                            out.write(jsonArray.toString());
                        } catch (Exception e) {

                            e.printStackTrace();

                        }
                    } else {

                        out.write("noAny");

                    }
                } else {
                    out.write("SearchError");
                }

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
