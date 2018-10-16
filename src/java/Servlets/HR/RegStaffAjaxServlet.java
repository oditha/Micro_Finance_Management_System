/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.HR;

import ORM.Staff;

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

/**
 *
 * @author iamarshrx
 */
@WebServlet(name = "RegStaffAjaxServlet", urlPatterns = {"/RegStaffAjaxServlet"})
public class RegStaffAjaxServlet extends HttpServlet {

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

           

            JSONArray arr = new JSONArray();

            Session sess = PoolManager.getSessionFactory().openSession();

            Criteria cr = sess.createCriteria(Staff.class);

            cr.add(Restrictions.eq("idStaff", Integer.parseInt(request.getParameter("ID"))));

            Staff staff = (Staff) cr.uniqueResult();
            
            JSONObject jo=new JSONObject();
            
            
            jo.put("nic",staff.getNic());
            jo.put("Licence",staff.getNic());
            jo.put("fullname",staff.getName());
            jo.put("Namew",staff.getNameWithinitials());
            jo.put("gender",staff.getGender());
            jo.put("dob", staff.getDob());
            jo.put("email",staff.getEmail() );
            jo.put("ad1", staff.getAddress1());
            jo.put("ad2", staff.getAddress2());
            jo.put("c1", staff.getContact1());
            jo.put("c2", staff.getContact2());
            jo.put("city", staff.getCity());
            jo.put("position", staff.getPosition());
            jo.put("etf", staff.getEtfNo());
            jo.put("epf", staff.getEpfNo());
            jo.put("basic", staff.getBasicSalary());
            jo.put("jdate", staff.getJoiningDate());
            jo.put("pic", staff.getPhoto());
            jo.put("salary", staff.getBasicSalary());
            
            arr.put(jo);
            
            
            
            sess.close();
            out.write(arr.toString());
            
            
            
            
            
            
            
            
            
            
            
            
            

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
