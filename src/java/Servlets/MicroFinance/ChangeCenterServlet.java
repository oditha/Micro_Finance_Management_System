/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.MicroFinance;

import ORM.CenterHasStaff;
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
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author danushka
 */
@WebServlet(name = "ChangeCenterServlet", urlPatterns = {"/ChangeCenterServlet"})
public class ChangeCenterServlet extends HttpServlet {

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
            
            String centers[]=request.getParameterValues("centers");
            String exe2 = request.getParameter("Exe2");
            int ex=Integer.parseInt(exe2);

                Session sess = PoolManager.getSessionFactory().openSession();
            
            
            for (int i = 0; i < centers.length; i++) {
              
            System.out.println("Empid"+exe2);
            System.out.println("centerid"+centers[i]);
                
                Criteria cr = sess.createCriteria(CenterHasStaff.class);
                cr.createAlias("center", "c");
                cr.add(Restrictions.eq("c.idCenter", Integer.parseInt(centers[i])));
                Transaction tr = sess.beginTransaction();
                
                CenterHasStaff uniqueResult = (CenterHasStaff) cr.uniqueResult();
                
                
                if (uniqueResult!=null) {
                    
                    Staff stf = new Staff();
                    stf.setIdStaff(Integer.parseInt(exe2));
                    uniqueResult.setStaff(stf);
                    tr.commit();
                  //  System.out.println("ok");
                   
                   
                  
                    
                    
                    
                }
                
                
                
             
                  
                   
            
                
                   
                
            }
            out.write("ok");
            
            
                sess.close();
            
            
            
            
            
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
