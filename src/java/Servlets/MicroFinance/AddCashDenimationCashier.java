package Servlets.MicroFinance;

import ORM.Center;
import ORM.CenterHasStaff;
import ORM.Loan;
import ORM.Members;
import ORM.Repayment;

import Singleton.dateFormat;
import Singleton.decimalFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
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

@WebServlet(name = "AddCashDenimationCashier", urlPatterns = {"/AddCashDenimationCashier"})
public class AddCashDenimationCashier extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            double collection = 0;
            double NPcollection = 0;
            double memberfee = 0;
            double totalLoan = 0;

            try {

                String date0 = request.getParameter("date");
                String idStaff = request.getParameter("idStaff");

                collection = 0.00;
                NPcollection = 0.00;
                memberfee = 0.00;
                totalLoan = 0.00;

                Session openSession = PoolManager.getSessionFactory().openSession();

                Criteria createCriteria = openSession.createCriteria(Repayment.class);
                createCriteria.add(Restrictions.eq("date", dateFormat.setDateFull(date0)));
                createCriteria.add(Restrictions.eq("arreas", "CashierPayment"));
                List<Repayment> list1 = createCriteria.list();
                for (Repayment repayment : list1) {

                    String actualDay = repayment.getActualDay();
                    String currentDay = repayment.getCurrentDay();

                    if (actualDay.equals(currentDay)) {

                        if (repayment.getArreas().equals("CashierPayment")) {

                            collection += repayment.getPaidAmount();

                        }
                    } else if (!(actualDay.equals(currentDay))) {

                        if (repayment.getArreas().equals("CashierPayment")) {

                            NPcollection += repayment.getPaidAmount();

                        }
                    }

                }

                double total = collection + NPcollection + memberfee + totalLoan;
                JSONArray jsonArray = new JSONArray();
                JSONObject jo = new JSONObject();

                jo.put("CenterCollection", decimalFormat.setAmount(collection));
                jo.put("npCollection", decimalFormat.setAmount(NPcollection));
                jo.put("MemberFees", decimalFormat.setAmount(memberfee));
                jo.put("ExchangeCash", decimalFormat.setAmount(totalLoan));
                jo.put("TotalAmount", decimalFormat.setAmount(total));

                jsonArray.put(jo);

                openSession.close();
                out.write(jsonArray.toString());
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
