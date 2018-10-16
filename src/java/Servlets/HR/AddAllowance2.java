/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.HR;

import ORM.Allowance;
import ORM.Staff;
import ORM.StaffHasAllowance;

import Singleton.dateFormat;
import Singleton.decimalFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author iamarshrx
 */
@WebServlet(name = "AddAllowance2", urlPatterns = {"/AddAllowance2"})
public class AddAllowance2 extends HttpServlet {

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
            
            
            PrintWriter out = response.getWriter();
            String atype = request.getParameter("allowanceType");
            String Staffid = request.getParameter("staffid");
            String amount = request.getParameter("aamount");

          

            try {
                HttpSession session = request.getSession();
                Session sess=PoolManager.getSessionFactory().openSession();
             Transaction tr=sess.beginTransaction();
             Allowance al=new Allowance();
             StaffHasAllowance sta=new StaffHasAllowance();
             Staff staff=new Staff();
             
             al.setIdAllowance(Integer.parseInt(atype));
             staff.setIdStaff(Integer.parseInt(Staffid));
             
             
            sta.setAllowance(al);
            sta.setAmount(decimalFormat.setAmount(Double.parseDouble(amount)));
            sta.setStaff(staff);
            sta.setDate(dateFormat.DateFullCurrent());
//            sta.set("Active");
//            sta.setIsAproved("approved");
//            sta.setCreatedBy(session.getAttribute("Username").toString());
            sess.save(sta);
            
            tr.commit();
            
            
            if (tr.wasCommitted()) {
                
              out.write("success");
                
                
                
                
            }else{
            
            out.write("err");
            
            }
            
            sess.close();
            } catch (Exception e) {
                out.write("err");
                throw new HibernateException(e);
            }
            
            
            
          
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
