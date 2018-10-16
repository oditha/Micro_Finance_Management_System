/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.HR;

import ORM.Staff;
import ORM.Staffattedence;

import Singleton.dateFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
@WebServlet(name = "SetIntimeServlet", urlPatterns = {"/SetIntimeServlet"})
public class SetIntimeServlet extends HttpServlet {

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

            int id = Integer.parseInt(session.getAttribute("id").toString());
//            out.print(id);
//            
//            out.print(dateFormat.DateFullCurrent());
//            

            try {

                Session sess2 = PoolManager.getSessionFactory().openSession();

                Criteria cr2 = sess2.createCriteria(Staffattedence.class);
                cr2.createAlias("staff", "s");
                cr2.add(Restrictions.eq("s.idStaff", id));
                cr2.add(Restrictions.eq("date", dateFormat.DateFullCurrent()));

                List<Staffattedence> l = cr2.list();
                
                
                
                
                if (l.size()!=0) {
                    response.sendRedirect("index.jsp?status=success");
                }else{
                
                               Session sess = PoolManager.getSessionFactory().openSession();
                
                Transaction tr=sess.beginTransaction();
                
                Staff staff = new Staff();
                
                staff.setIdStaff(id);
                
                Staffattedence staffattedence = new Staffattedence();
                
                staffattedence.setDate(dateFormat.DateFullCurrent());
                staffattedence.setIntime(dateFormat.TimeCurrent());
                staffattedence.setStatus("Present");
                staffattedence.setStaff(staff);
                staffattedence.setIsActive("Active");
                staffattedence.setIsAprove("Aproved");
                staffattedence.setSpecialnote("1");
                staffattedence.setCreatedBy(session.getAttribute("userName").toString());
                sess.save(staffattedence);
                
                tr.commit();
                
                
                if (tr.wasCommitted()) {
                    response.sendRedirect("index.jsp?status=success");
                }

                
                
                
                    sess.close();
                
                
                }
                
                
                
                

            } catch (Exception e) {
                throw new ServletException(e);
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
