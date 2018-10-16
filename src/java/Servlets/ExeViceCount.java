
package Servlets;

import ORM.CenterHasStaff;
import ORM.Staff;
import Srcs.ColorGen;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
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

@WebServlet(name = "ExeViceCount", urlPatterns = {"/ExeViceCount"})
public class ExeViceCount extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
         
            try {
                
                Session openSession = PoolManager.getSessionFactory().openSession();
                
                Criteria createCriteria = openSession.createCriteria(Staff.class);
                createCriteria.add(Restrictions.eq("isActive", "Active"));
                List<Staff> list = createCriteria.list();
                JSONArray jsonArray = new JSONArray();
                
                for (Staff staff : list) {
                    int count = 0;
                    JSONObject jo = new JSONObject();
                    jo.put("staff", staff.getNameWithinitials());
                    
                    Iterator iterator = staff.getCenterHasStaffs().iterator();
                    while (iterator.hasNext()) {
                        CenterHasStaff next = (CenterHasStaff) iterator.next();
                        Set memberses = next.getCenter().getMemberses();
                        count += memberses.size();
                    }
                    
                    jo.put("count", count);
                    
                    jo.put("color", ColorGen.colorcodegen());
                    
                    
                    jsonArray.put(jo);
                }
                
                openSession.close();
                
                out.write(jsonArray.toString());
                
            } catch (Exception e) {
            
                e.printStackTrace();
            
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
