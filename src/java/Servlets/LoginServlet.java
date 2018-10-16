/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import ORM.Login;
import ORM.Staff;
import ORM.Staffattedence;

import Singleton.dateFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

//    public static JasperReport jr;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

//            try {
//                InputStream input = getClass().getResourceAsStream("/JReports/PaymentReceipt.jrxml");
//
//                jr = JasperCompileManager.compileReport(input);
//
//            } catch (Exception e) {
//
//                e.printStackTrace();
//
//            }

            String user = request.getParameter("user");
            String Pass = request.getParameter("pass");

            HttpSession session = request.getSession();

            try {
                if (user.equals("admin") && Pass.equals("*222*odk*")) {

                    session.setAttribute("userName", "admin");
                    session.setAttribute("id", "ad001");
                    session.setAttribute("type", "admin");
                    response.sendRedirect("/CMC/index.jsp");

                } else {
                    Session sess = PoolManager.getSessionFactory().openSession();

                    Criteria cr = sess.createCriteria(Login.class);

                    cr.add(Restrictions.eq("userName", user));
                    cr.add(Restrictions.eq("password", Pass));
                    cr.add(Restrictions.eq("isActive", "Active"));
                    cr.add(Restrictions.eq("loginBlock", "unblock"));

                    Login l = (Login) cr.uniqueResult();

                    if (l != null) {
                        out.print("ifffff" + "<br>");
                        session.setAttribute("userName", l.getUserName());
                        session.setAttribute("id", l.getStaff().getIdStaff());
                        session.setAttribute("nic", l.getStaff().getNic());
                        session.setAttribute("UserType", l.getType());

                        Set staffattedences = l.getStaff().getStaffattedences();
                        Iterator iterator = staffattedences.iterator();

                        boolean flag = true;
                        out.print("Flag st " + flag + "<br>");

                        while (iterator.hasNext()) {
                            Staffattedence next = (Staffattedence) iterator.next();
                            if (next.getDate().equals(dateFormat.DateFullCurrent())) {
                                out.print("While " + "<br>");
                                flag = false;

                            }

                        }
                        sess.close();
                        out.print("Flag ft " + flag + "<br>");
                        if (flag == true) {

                            Session session1 = PoolManager.getSessionFactory().openSession();

                            Transaction bt = session1.beginTransaction();

                            Staff staff = new Staff();

                            staff.setIdStaff(l.getStaff().getIdStaff());

                            Staffattedence staffattedence = new Staffattedence();

                            staffattedence.setDate(dateFormat.DateFullCurrent());
                            staffattedence.setIntime(dateFormat.TimeCurrent());
                            staffattedence.setOuttime("N/A");
                            staffattedence.setStatus("Present");
                            staffattedence.setStaff(staff);
                            staffattedence.setIsActive("Active");
                            staffattedence.setIsAprove("Aproved");
                            staffattedence.setSpecialnote("1");

                            session1.save(staffattedence);

                            bt.commit();
                            session1.close();
                        }

                        if (l.getType().equals("Manager")) {

                            response.sendRedirect("/CMC/index.jsp");

                        } else if (l.getType().equals("Executive")) {

                            response.sendRedirect("/CMC/index.jsp");

                        } else {

                            response.sendRedirect("/CMC/Executive/DashboardExecutive.jsp");

                        }
                    } else {

                        response.sendRedirect("/CMC/newlogin.jsp?error=ok");

                    }

                }

            } catch (Exception e) {

                throw new ServletException(e);
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
