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

/**
 *
 * @author iamarshrx
 */
@WebServlet(name = "EditStaffServlet", urlPatterns = {"/EditStaffServlet"})
public class EditStaffServlet extends HttpServlet {

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
            String StaffName = request.getParameter("StaffName");
            String gender = request.getParameter("gender");
            String contact1 = request.getParameter("contact1");
            String contact2 = request.getParameter("contact2");
            String position = request.getParameter("position");
            String basicSalary = request.getParameter("basicSalary");
            String joiningDate = request.getParameter("joiningDate");
            String licenceNo = request.getParameter("licenceNo");
            String StaffNameinitials = request.getParameter("StaffNameinitials");
            String dob = request.getParameter("dob");
            String Address1 = request.getParameter("Address1");
            String Address2 = request.getParameter("Address2");
            String etf = request.getParameter("etf");
            String epf = request.getParameter("epf");
            String city = request.getParameter("city");

            int id = Integer.parseInt(request.getParameter("hid").toString());
            Session sess = PoolManager.getSessionFactory().openSession();

            Transaction tr = sess.beginTransaction();
            Criteria cr = sess.createCriteria(Staff.class);
            cr.add(Restrictions.eq("idStaff", id));
            Staff staff = (Staff) cr.uniqueResult();

            staff.setNic(nic);
            staff.setLicenceNo(licenceNo);
            staff.setName(StaffName);
            staff.setAddress1(Address1);
            staff.setAddress2(Address2);
            staff.setCity(city);
            staff.setContact1(contact1);
            staff.setContact2(contact2);
            staff.setBasicSalary(decimalFormat.setAmount(Double.parseDouble(basicSalary)));
            staff.setEpfNo(epf);
            staff.setEtfNo(etf);
            staff.setDob(dateFormat.setDateFull(dob));
            staff.setJoiningDate(dateFormat.setDateFull(joiningDate));
            staff.setPosition(position);
            staff.setIsActive("Active");
            staff.setCreatedby(session.getAttribute("userName").toString());

            staff.setGender(gender);

            staff.setNameWithinitials(StaffNameinitials);

            tr.commit();

            if (tr.wasCommitted()) {
                response.sendRedirect("HR/AddregStaff.jsp?Update=success");
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
