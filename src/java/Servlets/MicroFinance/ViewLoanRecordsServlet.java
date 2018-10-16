
package Servlets.MicroFinance;

import ORM.Loan;

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
import org.hibernate.criterion.Restrictions;
import org.json.JSONArray;
import org.json.JSONObject;


@WebServlet(name = "ViewLoanRecordsServlet", urlPatterns = {"/ViewLoanRecordsServlet"})
public class ViewLoanRecordsServlet extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           
            try {
                Session session = PoolManager.getSessionFactory().openSession();
                Criteria createCriteria = session.createCriteria(Loan.class);
                createCriteria.add(Restrictions.eq("idLoan", Integer.parseInt(request.getParameter("loanID"))));
                Loan loan = (Loan) createCriteria.uniqueResult();
                if (loan !=null) {
                    JSONArray jsonArray = new JSONArray();
                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("ContractNO", loan.getContractNo());
                    jsonObject.put("loanIndex", loan.getLoanIndex());
                    jsonObject.put("loanAmount", loan.getLoanAmount());
                    jsonObject.put("loanInterset", loan.getLoanInterest());
                    jsonObject.put("loanPeriod", loan.getLoanPeriod());
                    jsonObject.put("loanInstallment", loan.getLoanInstallment());
                    jsonObject.put("loanIssueDate", loan.getIssueDate());
                    jsonObject.put("loanRepaymentDay", loan.getRepaymentDay());
                    jsonObject.put("gur1", loan.getGaranter1());
                    jsonObject.put("gur2", loan.getGaranter2());
                    jsonObject.put("Status", loan.getStatus());
                    jsonObject.put("CreateBy", loan.getCreateBy());
                    
                    jsonArray.put(jsonObject);
                    out.write(jsonArray.toString());
                }
                session.close();
            } catch (Exception e) {
               out.write("error");
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
