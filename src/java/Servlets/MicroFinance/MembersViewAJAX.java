package Servlets.MicroFinance;

import ORM.Members;

import Singleton.dateFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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

@WebServlet(name = "MembersViewAJAX", urlPatterns = {"/MembersViewAJAX"})
public class MembersViewAJAX extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {

                String memberID = request.getParameter("memberID");
                Session openSession = PoolManager.getSessionFactory().openSession();

                Criteria createCriteria = openSession.createCriteria(Members.class);
                createCriteria.add(Restrictions.eq("idMembers", Integer.parseInt(memberID)));
                Members uq = (Members) createCriteria.uniqueResult();
                SimpleDateFormat s = new SimpleDateFormat("dd/MM/yyyy");
                SimpleDateFormat s1 = new SimpleDateFormat("MM/dd/yyyy");
                
              System.out.println(uq.getDob());
//                Date d=s.parse( uq.getDob());

                JSONArray jsonArray = new JSONArray();
                JSONObject jo = new JSONObject();

                jo.put("g_occ", uq.getHusbandjob());
                jo.put("g_dob", uq.getHusbandDob());
                jo.put("g_name", uq.getHusbandName());
                jo.put("g_NIC", uq.getHusbandNic());
                jo.put("memcity", uq.getCity());
                jo.put("address_2", uq.getAddress2());
                jo.put("address_1", uq.getAddress1());
                jo.put("contactNo", uq.getContactNo());
                jo.put("memdob", uq.getDob());
                jo.put("memname", uq.getFullName());
                jo.put("nameint", uq.getNameWithInitials());
                jo.put("NICMem", uq.getNic());
                jo.put("groupID", uq.getGroupId());
                jo.put("memid", uq.getMemberNo());
                jo.put("id", uq.getIdMembers());
                jo.put("centerID", uq.getCenter().getIdCenter());
//                jo.put("centerID", uq.getCenter().getCenterNo()+" - "+uq.getCenter().getCenterName());

                jsonArray.put(jo);
                openSession.close();
             out.write(jsonArray.toString());
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
