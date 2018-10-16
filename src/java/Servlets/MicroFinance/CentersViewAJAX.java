package Servlets.MicroFinance;

import ORM.Center;
import ORM.CenterHasStaff;

import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
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

@WebServlet(name = "CentersViewAJAX", urlPatterns = {"/CentersViewAJAX"})
public class CentersViewAJAX extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                int id = Integer.parseInt(request.getParameter("centerID"));
                System.out.println(id);
                Session openSession = PoolManager.getSessionFactory().openSession();
                Criteria createCriteria = openSession.createCriteria(Center.class);
                createCriteria.add(Restrictions.eq("idCenter", id));
                Center cen = (Center) createCriteria.uniqueResult();

                if (cen != null) {

                    JSONArray jsonArray = new JSONArray();
                    JSONObject jo = new JSONObject();

                    jo.put("cenid", cen.getIdCenter());
                    jo.put("name", cen.getCenterName());
                    jo.put("no", cen.getCenterNo());
                    jo.put("day", cen.getCenterDay());
                    jo.put("time", cen.getCentertime());
                    jo.put("idCenter", cen.getIdCenter());

                    Iterator it = cen.getCenterHasStaffs().iterator();
                    if (it.hasNext()) {
                        
                        CenterHasStaff next = (CenterHasStaff) it.next();
                        String nic = next.getStaff().getNic();
                        String exname = next.getStaff().getNameWithinitials();
                        
                        jo.put("exname", nic+" - "+exname);
                        
                    }

                    jsonArray.put(jo);
                    out.write(jsonArray.toString());

                }
                openSession.close();
            } catch (Exception e) {

                System.out.println(e);
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
