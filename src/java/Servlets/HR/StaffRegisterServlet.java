/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.HR;

import ORM.Staff;

import Singleton.dateFormat;
import Singleton.decimalFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
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
@WebServlet(name = "StaffRegisterServlet", urlPatterns = {"/StaffRegisterServlet"})
public class StaffRegisterServlet extends HttpServlet {

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
            
            String nic = request.getParameter("nic");
            String licenceNo = request.getParameter("licenceNo");
            String StaffName = request.getParameter("StaffName");
            String StaffNameinitials = request.getParameter("StaffNameinitials");
            String Address1 = request.getParameter("Address1");
            String Address2 = request.getParameter("Address2");
            String city = request.getParameter("city");
            String gender = request.getParameter("gender");
            String dob = request.getParameter("dob");
            String contact1 = request.getParameter("contact1");
            String contact2 = request.getParameter("contact2");
            String email = request.getParameter("email");
            String position = request.getParameter("position");
            String basicSalary = request.getParameter("basicSalary");
            String joiningDate = request.getParameter("joiningDate");
            String etf = request.getParameter("etf");
            String epf = request.getParameter("epf");
            
            //out.print(nic + licenceNo + StaffName + StaffNameinitials + Address1 + Address2 + city + gender + dob + contact1 + contact2 + email + position + basicSalary + joiningDate + etf + epf);
            
            try {
                String usern=session.getAttribute("userName").toString();
                 Session sess = PoolManager.getSessionFactory().openSession();
            
            Transaction tr = sess.beginTransaction();
            
            Staff staff = new Staff();
            
            staff.setNic(nic);
            staff.setLicenceNo(licenceNo);
            staff.setName(StaffName);
            staff.setNameWithinitials(StaffNameinitials);
            staff.setAddress1(Address1);
            staff.setAddress2(Address2);
            staff.setCity(city);
            staff.setGender(gender);
            staff.setDob(dob);
            staff.setContact1(contact1);
            staff.setContact2(contact2);
            staff.setEmail(email);
            staff.setPosition(position);
            staff.setBasicSalary(basicSalary);
            staff.setJoiningDate(joiningDate);
            staff.setEtfNo(etf);
            staff.setEpfNo(epf);
            staff.setIsActive("Active");
            staff.setCreatedby(usern);
            sess.save(staff);
            
            tr.commit();
            
            if (tr.wasCommitted()) {
                
//                RequestDispatcher rd2 = request.getRequestDispatcher("../AddregStaff.jsp");
//             ///   request.setAttribute("save", "success");
//                rd2.forward(request, response);
        response.sendRedirect("HR/AddregStaff.jsp?save=ok");
                
            }
        sess.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            
        } catch (Exception e) {
            throw new ServletException();
            
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
