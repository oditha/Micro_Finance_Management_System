package Servlets;

import ORM.Center;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet(name = "MembersCount", urlPatterns = {"/MembersCount"})
public class MembersCount extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
          
            try {
                
                Session openSession = PoolManager.getSessionFactory().openSession();
                
                Criteria createCriteria = openSession.createCriteria(Center.class);
                createCriteria.add(Restrictions.eq("isActive", "Active"));
                createCriteria.add(Restrictions.eq("isApprove", "Approve"));
                List<Center> list = createCriteria.list();
                
                JSONArray jsonArray = new JSONArray();
                JSONArray ja = new JSONArray();
                
                
                for (Center center : list) {
                    System.out.println("in the for");
                    JSONObject jo = new JSONObject();
                    
                    Set memberses = center.getMemberses();
//                    System.out.println("");

                    if (memberses.size() != 0) {
                        
                    jo.put("Center", center.getCenterName());
                        jo.put("count", memberses.size());

                    }
                    jsonArray.put(jo);
                    
                }
                
                
                openSession.close();
                
                
                
                out.write(jsonArray.toString());
                
            } catch (Exception e) {
           
                out.write(e.toString());
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
