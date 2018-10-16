package Servlets;

import ORM.Login;

import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;


@WebServlet(name="MobileLoginServlet", urlPatterns={"/MobileLoginServlet"})
public class MobileLoginServlet extends HttpServlet {
   

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            try {
                String user = request.getParameter("UserName");
                String pass = request.getParameter("Password");

                Criteria createCriteria =PoolManager.getSessionFactory().openSession().createCriteria(Login.class);

                createCriteria.add(Restrictions.eq("userName", user));
                createCriteria.add(Restrictions.eq("password", pass));

                Login login = (Login) createCriteria.uniqueResult();

                if (login != null) {

                    HttpSession session = request.getSession();
                    session.setAttribute("id", login.getStaff().getIdStaff());
                    session.setAttribute("Name", login.getUserName());
                    session.setAttribute("userType", login.getType());

//                    RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");
//                    requestDispatcher.forward(request, response);

                    response.sendRedirect("mobile/home.jsp");
                }else{
                    
                    response.sendRedirect("mobile/newlogin.jsp?stat=err");
                
                }
                PoolManager.getSessionFactory().openSession().close();
            } catch (Exception e) {
                
                out.print(e);
                
            }
            
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
