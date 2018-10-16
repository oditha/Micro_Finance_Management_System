package Servlets.MicroFinance;

import ORM.Loan;
import ORM.Members;

import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
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

@WebServlet(name = "viewLedgerReportSearch", urlPatterns = {"/viewLedgerReportSearch"})
public class viewLedgerReportSearch extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String Restric = "memberNo";
            double loanwithintrest = 0.0;

            try {

                String id = request.getParameter("member");

                char charAt = id.charAt(0);

                if (!id.contains("/")) {

                    Restric = "nic";

                } else {

                    Restric = "memberNo";

                }
                Session openSession = PoolManager.getSessionFactory().openSession();

                Criteria createCriteria = openSession.createCriteria(Members.class);
                createCriteria.add(Restrictions.eq(Restric, id));
                createCriteria.add(Restrictions.eq("isActive", "Active"));
                Members ur = (Members) createCriteria.uniqueResult();

                if (ur != null) {

                    String name = ur.getNameWithInitials();
                    String contactNo = ur.getContactNo();
                    String centerName = ur.getCenter().getCenterName();

                    JSONArray ja0 = new JSONArray();
                    JSONObject jo0 = new JSONObject();

                    jo0.put("memberName", name);
                    jo0.put("cname", centerName);
                    jo0.put("contactNo", contactNo);

                    ja0.put(jo0);

                    Set loans = ur.getLoans();
                    Iterator it0 = loans.iterator();
                    List list = new ArrayList();
                    while (it0.hasNext()) {

                        Loan loan = (Loan) it0.next();

                        if (loan.getIsActive().equals("Active")) {

                            String loanIndex = loan.getLoanIndex() + "-" + loan.getIdLoan();

                            list.add(loanIndex);
                            loanwithintrest = loan.getLoanAmount() + loan.getLoanInterest();

                        }

                    }
                    Collections.sort(list);
                    JSONArray ja1 = new JSONArray();

                    for (int i = 0; i < list.size(); i++) {

                        JSONObject jo = new JSONObject();
                        jo.put("index", list.get(i).toString().split("-")[0]);
                        jo.put("idLoan", list.get(i).toString().split("-")[1]);

                        ja1.put(jo);

                    }

                    out.write(ja0.toString() + "_" + ja1.toString());

                } else {
                    out.write("SearchError");
                }
                openSession.close();

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
