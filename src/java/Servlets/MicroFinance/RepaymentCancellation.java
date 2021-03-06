
package Servlets.MicroFinance;

import ORM.Repaymentcancellation;

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

@WebServlet(name = "RepaymentCancellation", urlPatterns = {"/RepaymentCancellation"})
public class RepaymentCancellation extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       
        try {
            PrintWriter out = response.getWriter();
            Session sess = PoolManager.getSessionFactory().openSession();
            Criteria cr = sess.createCriteria(Repaymentcancellation.class);
            
            cr.add(Restrictions.eq("idRepaymentCancellation", Integer.parseInt(request.getParameter("ID"))));
            
            Repaymentcancellation uniqueResult = (Repaymentcancellation) cr.uniqueResult();
            JSONArray arr = new JSONArray();
            if (uniqueResult!=null) {
                
                JSONObject jo = new JSONObject();
                jo.put("ContractNo", uniqueResult.getRepayment().getLoan().getContractNo());
                jo.put("MemberName", uniqueResult.getRepayment().getLoan().getMembers().getNameWithInitials());
                jo.put("PaidAmount", uniqueResult.getRepayment().getPaidAmount());
                jo.put("Paiddate", uniqueResult.getRepayment().getDate());
                jo.put("Reason", uniqueResult.getReason());
                arr.put(jo);
                
                
                
                
            }
            sess.close();
            out.write(arr.toString());
            
            
            
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
