package Servlets.MicroFinance;

import ORM.Center;
import ORM.Loan;
import ORM.Members;

import Singleton.dateFormat;
import Singleton.decimalFormat;
import Srcs.PoolManager;
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

@WebServlet(name = "ViewDisbursment", urlPatterns = {"/ViewDisbursment"})
public class ViewDisbursment extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {

                String center = request.getParameter("cenID");
                String date = request.getParameter("dates");
                Session openSession = PoolManager.getSessionFactory().openSession();
                Criteria createCriteria = openSession.createCriteria(Center.class);
                createCriteria.add(Restrictions.eq("idCenter", Integer.parseInt(center)));

                Center cen = (Center) createCriteria.uniqueResult();

                JSONArray jsonArray = new JSONArray();
                double total = 0;
                int count = 1;
                Set memberses = cen.getMemberses();
                Iterator iterator = memberses.iterator();
                while (iterator.hasNext()) {

                    Members mem = (Members) iterator.next();
                    if (mem.getAproved().equals("Approve") && mem.getIsActive().equals("Active")) {

                        Set loans = mem.getLoans();
                        Iterator iterator1 = loans.iterator();
                        while (iterator1.hasNext()) {

                            Loan loan = (Loan) iterator1.next();
                                System.out.println("ISACTIVEBB "+loan.getIsActive());
                                System.out.println("ISAPPROVEBB "+loan.getIsAprove());
                            if (loan.getIssueDate().equals(dateFormat.setDateFull(date)) & loan.getIsAprove().equals("Approve") & loan.getIsActive().equals("Active")) {
                                System.out.println("ISACTIVE "+loan.getIsActive());
                                System.out.println("ISAPPROVE "+loan.getIsAprove());
                                total += loan.getRenewAmount();

                                JSONObject jo = new JSONObject();

                                jo.put("Count", count++);
                                jo.put("MemNO", mem.getMemberNo());
                                jo.put("MemName", mem.getNameWithInitials());
                                jo.put("Memberfee", loan.getMemberfee());
                                jo.put("Membernic", mem.getNic());

                                jo.put("Loanamo", loan.getLoanAmount());

                                jo.put("paidAmo", loan.getLoanIndex());
                                jo.put("Installment", loan.getLoanInstallment());
                                jo.put("sign", " ");

                                jsonArray.put(jo);

                            }

                        }
                    }

                }

                openSession.close();
                out.write(decimalFormat.setAmount(total) + "$" + jsonArray.toString());
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
