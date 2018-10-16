
package Servlets.HR;

import ORM.Resignation;

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
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;


@WebServlet(name = "DeleteResignationServlet", urlPatterns = {"/DeleteResignationServlet"})
public class DeleteResignationServlet extends HttpServlet {

  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            PrintWriter out = response.getWriter();
            
            int id=Integer.parseInt(request.getParameter("hid"));
            
            
            Session sess=PoolManager.getSessionFactory().openSession();
            
            Transaction tr=sess.beginTransaction();
            Criteria cr=sess.createCriteria(Resignation.class);
            cr.add(Restrictions.eq("idResignation",id));
            
            Resignation re=(Resignation) cr.uniqueResult(); 
            re.setIsActive("DeActive");
            tr.commit();
            
            if (tr.wasCommitted()) {
                response.sendRedirect("HR/AddResignation.jsp?Delete=success");
            }
            
            
            
            
            sess.close();
            
            
            
        } catch (Exception e) {
            
            throw  new ServletException(e);
            
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
