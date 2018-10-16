package Servlets.MicroFinance;

import ORM.Center;
import ORM.Loan;
import ORM.Members;
import ORM.Repayment;

import Srcs.PoolManager;
import Srcs.WeeksCount;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.Map;
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

@WebServlet(name = "RepaymentSheetServlet", urlPatterns = {"/RepaymentSheetServlet"})
public class RepaymentSheetServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {

                Map<String, String> hm = new TreeMap<String, String>();
                System.out.println(request.getParameter("idCenter"));
                int idCenter = Integer.parseInt(request.getParameter("idCenter").split("-")[0]);

                String group = "";
                String memNo = "";
                String memName = "";
                String contact = "";
                double loanAmount = 0;
                double interest = 0;
                double rental = 0;
                double paid = 0;
                double Remain = 0;
                double arrears = 0;
                double defau = 0;
                JSONArray ja = new JSONArray();
                JSONObject joEmpty = new JSONObject();
                joEmpty.put("memNo", "");
                joEmpty.put("memName", "");
                joEmpty.put("interest", "");
                joEmpty.put("loanAmount", "");
                joEmpty.put("rental", "");
                joEmpty.put("Remain", "Payment Date");
                joEmpty.put("contact", "");
                joEmpty.put("group", "");
                joEmpty.put("week1", "");
                joEmpty.put("week2", "");
                joEmpty.put("week3", "");
                joEmpty.put("week4", "");
                joEmpty.put("week5", "");

                ja.put(joEmpty);
                Session openSession = PoolManager.getSessionFactory().openSession();

                Criteria cr = openSession.createCriteria(Center.class);
                cr.add(Restrictions.eq("idCenter", idCenter));

                Center cen = (Center) cr.uniqueResult();

                Iterator it = cen.getMemberses().iterator();
                while (it.hasNext()) {
                    Members mem = (Members) it.next();
                    memNo = "";
                    memName = "";
                    loanAmount = 0;
                    rental = 0;
                    Remain = 0;
                    contact = "";
                    group = "";
                    paid = 0;
                    if (mem.getIsActive().equals("Active") && mem.getAproved().equals("Approve")) {

                        Iterator it1 = mem.getLoans().iterator();

                        while (it1.hasNext()) {
                            Loan loan = (Loan) it1.next();
                            if (loan.getStatus().equals("Unpaid") && loan.getIsActive().equals("Active")
                                    && loan.getIsAprove().equals("Approve")) {

                                Iterator it2 = loan.getRepayments().iterator();
                                int weeksCount = WeeksCount.weeksCount(loan.getIssueDate(), loan.getRepaymentDay());
                                defau = weeksCount * loan.getLoanInstallment();
                                while (it2.hasNext()) {

                                    Repayment re = (Repayment) it2.next();
                                    if (re.getIsActive().equals("Active") && re.getIsAproved().equals("Approve")) {

                                        paid += re.getPaidAmount();

                                    }

                                }

                                memNo = mem.getMemberNo();
                                memName = mem.getNameWithInitials();
                                loanAmount = loan.getLoanAmount();
                                interest = loan.getLoanInterest();
                                rental = loan.getLoanInstallment();
                                Remain = (loanAmount + interest) - paid;
                                contact = mem.getContactNo();
                                group = mem.getGroupId();

                                if (weeksCount > loan.getLoanPeriod()) {
                                    
                                    arrears = (loanAmount + interest) - paid;
                                }else{
                                
                                    arrears = defau - paid;
                                
                                }
                                
                                
                                JSONObject jo = new JSONObject();
                                jo.put("memNo", memNo);
                                jo.put("memName", memName);
                                jo.put("interest", interest);
                                jo.put("loanAmount", loanAmount);
                                jo.put("rental", rental);
                                jo.put("Remain", Remain);
                                jo.put("contact", contact);
                                jo.put("group", group);
                                jo.put("week1", "");
                                jo.put("week2", "");
                                jo.put("week3", "");
                                jo.put("week4", "");
                                jo.put("week5", "");
//                                jo.put("week6", "");
//                                jo.put("week7", "");
//                                jo.put("week8", "");

                                ja.put(jo);

                            }
                        }

                    }

                }

                JSONObject end = new JSONObject();
                end.put("memNo", "Total");
                end.put("memName", "");
                end.put("interest", "");
                end.put("loanAmount", "");
                end.put("rental", "");
                end.put("Remain", "Total Paid");
                end.put("contact", "");
                end.put("group", "");
                end.put("week1", "");
                end.put("week2", "");
                end.put("week3", "");
                end.put("week4", "");
                end.put("week5", "");

                ja.put(end);

                openSession.close();
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
