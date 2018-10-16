package Servlets.MicroFinance;

import ORM.Loan;
import ORM.Members;
import Holders.LoanIndexHolder;

import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
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

@WebServlet(name = "ViewLoanIndexReport", urlPatterns = {"/ViewLoanIndexReport"})
public class ViewLoanIndexReport extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {

                String cenID = request.getParameter("center");
                String month = request.getParameter("month");
                String year = request.getParameter("year");
                Session openSession = PoolManager.getSessionFactory().openSession();

                Criteria cr = openSession.createCriteria(Members.class);
                cr.createAlias("center", "c");
                cr.add(Restrictions.eq("c.idCenter", Integer.parseInt(cenID)));
                cr.add(Restrictions.eq("isActive", "Active"));
                cr.add(Restrictions.eq("aproved", "Approve"));

                List<Members> list = cr.list();

           
                Map<String, LoanIndexHolder> lih = new HashMap<>();

                for (Members mem : list) {

                    Set loans = mem.getLoans();
                    Iterator iterator = loans.iterator();

                    while (iterator.hasNext()) {

                        Loan loan = (Loan) iterator.next();

                        if (loan.getIsActive().equals("Active") && loan.getIsAprove().equals("Approve")) {

                            if (loan.getIssueDate().split("/")[1].equals(month) && loan.getIssueDate().split("/")[2].equals(year)) {

                                String loanIndex = loan.getLoanIndex();

                                if (lih.get(loanIndex) == null) {

                                    LoanIndexHolder li = new LoanIndexHolder();
                                    li.setCount(1);
                                    li.setTotal(loan.getLoanAmount());
                                    lih.put(loanIndex, li);

                                } else {

                                    LoanIndexHolder get = lih.get(loanIndex);
                                    get.setCount(get.getCount() + 1);
                                    get.setTotal(get.getTotal() + loan.getLoanAmount());

                                }

                            }

                        }

                    }

                }

                openSession.close();

                JSONArray ja = new JSONArray();

                for (Map.Entry<String, LoanIndexHolder> entry : lih.entrySet()) {

                    String key = entry.getKey();
                    LoanIndexHolder value = entry.getValue();

                    JSONObject jo = new JSONObject();

                    jo.put("index", key);
                    jo.put("count", value.getCount());
                    jo.put("total", value.getTotal());
                    ja.put(jo);

                }

                out.write(ja.toString());

            } catch (Exception e) {

                out.write("err");

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
