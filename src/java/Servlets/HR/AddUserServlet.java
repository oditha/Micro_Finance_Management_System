/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.HR;

import ORM.Login;
import ORM.Staff;

import Singleton.dateFormat;
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
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author iamarshrx
 */
@WebServlet(name = "AddUserServlet", urlPatterns = {"/AddUserServlet"})
public class AddUserServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            HttpSession session = request.getSession();
            PrintWriter out = response.getWriter();

            String staff = request.getParameter("Staff");
            String username = request.getParameter("user");
            String pass = request.getParameter("Pass");
            String repass = request.getParameter("repass");
            int id = 0;
            String position = null;
            String usern = session.getAttribute("userName").toString();
//out.print(pass);

            if (pass.equals(repass)) {

                if (!staff.equals("Select")) {

                    String arr[] = staff.split("-");

                    String nic = arr[1];
                    Session sess1 = PoolManager.getSessionFactory().openSession();

                    //Session sess=DB.getsession();
                    try {

                     //   Session sess1 = PoolManager.getSessionFactory().openSession();

                        Criteria cr = sess1.createCriteria(Staff.class);

                        cr.add(Restrictions.eq("nic", nic));

                        Staff st = (Staff) cr.uniqueResult();
                        id = st.getIdStaff();
                        position = st.getPosition();

                     //   s.close();
                    } catch (Exception e) {

                        throw new HibernateException(e);

                    }

                    try {

                        Transaction tr = sess1.beginTransaction();

                        Staff staff1 = new Staff();

                        staff1.setIdStaff(id);

                        Login login = new Login();

                        login.setUserName(username);
                        login.setPassword(pass);
                        login.setType(position);
                        login.setSetDate(dateFormat.DateFullCurrent());
                        login.setStaff(staff1);
                        login.setLoginBlock("unblock");
                        login.setIsActive("Active");
                        login.setIsAprove("Aproved");
                        login.setCreatedBy(usern);

                        sess1.save(login);
                        tr.commit();

                        if (tr.wasCommitted()) {

                            response.sendRedirect("HR/AddUser.jsp?success=ok");
                            nic = null;
                            id = 0;

                        }

                        Staff s = new Staff();
                        sess1.close();
                    } catch (Exception e) {

                        throw new HibernateException(e);
                    }

                } else {

                    response.sendRedirect("HR/AddUser.jsp?err=slectstf");

                }

            } else {

                response.sendRedirect("HR/AddUser.jsp?err=passnm");

            }

        } catch (Exception e) {
            throw new ServletException(e);
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
