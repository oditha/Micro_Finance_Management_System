/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.HR;

import ORM.Staff;
import ORM.Staffsalary;

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
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author iamarshrx
 */
@WebServlet(name = "CreateSalaryServlet", urlPatterns = {"/CreateSalaryServlet"})
public class CreateSalaryServlet extends HttpServlet {

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

            HttpSession session = request.getSession();
            String bsalary = request.getParameter("bsalary");
            String staffid = request.getParameter("staffid");
            String tallowance = request.getParameter("tallowance");
            String csubtotal = request.getParameter("csubtotal");
            String nettotal = request.getParameter("nettotal");
            String tdeductions = request.getParameter("tdeductions");
            String etf = request.getParameter("etf");
            String epf = request.getParameter("epf");
            String dsub = request.getParameter("dsub");
            
           int id=Integer.parseInt(staffid);
            

            Session sess = PoolManager.getSessionFactory().openSession();
            Transaction tr = sess.beginTransaction();
            Staff staff = new Staff();

            staff.setIdStaff(id);

            Staffsalary ss = new Staffsalary();

            ss.setDate(dateFormat.DateFullCurrent());
            ss.setBasicSalary(decimalFormat.setAmount(Double.parseDouble(bsalary)));
            ss.setTotalSalary(decimalFormat.setAmount(Double.parseDouble(csubtotal)));
            ss.setTotalAllowance(decimalFormat.setAmount(Double.parseDouble(tallowance)));
            ss.setTotalDeductions(decimalFormat.setAmount(Double.parseDouble(tdeductions)));
            ss.setEpf(decimalFormat.setAmount(Double.parseDouble(epf)));
            ss.setEtf(decimalFormat.setAmount(Double.parseDouble(etf)));
            ss.setNetSalary(decimalFormat.setAmount(Double.parseDouble(nettotal)));
            ss.setStaff(staff);
            ss.setIsActive("Active");
            ss.setIsAprove("aproved");
            ss.setCreatedBy(session.getAttribute("userName").toString());
            ss.setTotalPayments(decimalFormat.setAmount(Double.parseDouble(dsub)));
            ss.setIsDelete("Paid");
            
            sess.save(ss);
            tr.commit();
            
            if (tr.wasCommitted()) {
                 /// response.sendRedirect("HR/AddSalaryCreation.jsp?save=success");
                 out.write("okk");
                 
                 
            }
           sess.close();
            
            
            

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
