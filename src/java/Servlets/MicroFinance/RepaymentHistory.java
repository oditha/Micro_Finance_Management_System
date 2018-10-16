package Servlets.MicroFinance;

import ORM.Loan;
import ORM.Repayment;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
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

@WebServlet(name = "RepaymentHistory", urlPatterns = {"/RepaymentHistory"})
public class RepaymentHistory extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
     
        
        try {
            
            String id = request.getParameter("loanID");
            
            PrintWriter out = response.getWriter();
            
            Session sess = PoolManager.getSessionFactory().openSession();
            Criteria cr = sess.createCriteria(Loan.class);
            cr.add(Restrictions.eq("idLoan", Integer.parseInt(id)));
            Loan uniqueResult = (Loan) cr.uniqueResult();
            
            JSONArray arr = new JSONArray();
            
            
            
            if (uniqueResult!=null) {
            
                Iterator it = uniqueResult.getRepayments().iterator();
                while (it.hasNext()) {
                    Repayment next = (Repayment) it.next();
                    
                    
                    if (next.getIsActive().equals("Active")) {
                        
                        JSONObject jo = new JSONObject();
                        jo.put("Reciptno", next.getRecieptNo());
                        jo.put("PaidDate", next.getDate());
                        jo.put("amount", next.getPaidAmount());
                        arr.put(jo);
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                }
                
                
                
                
                
                
            }
            
          out.write(  arr.toString());
            
            
            
        } catch (Exception e) {
            e.printStackTrace();
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
