package Servlets.MicroFinance;

import ORM.Loan;
import ORM.Members;

import Singleton.decimalFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Objects;
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

@WebServlet(name = "ViewMemberDataAJAX", urlPatterns = {"/ViewMemberDataAJAX"})
public class ViewMemberDataAJAX extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String Restric = "memberNo";

            try {

                String id = request.getParameter("memberID");
                char charAt = id.charAt(0);

                if (!id.contains("/")) {

                    Restric = "nic";

                } else {

                    Restric = "memberNo";

                }
                Session openSession = PoolManager.getSessionFactory().openSession();
                Criteria createCriteria = openSession.createCriteria(Members.class);

                createCriteria.add(Restrictions.eq(Restric, id));
                createCriteria.add(Restrictions.eq("isActive", "Active"));
                Members ur = (Members) createCriteria.uniqueResult();

                if (ur != null) {

                    String nameWithInitials = ur.getNameWithInitials();
                    String groupId = ur.getGroupId();
                    String centerDay = ur.getCenter().getCenterDay();
                    Integer idMembers = ur.getIdMembers();
                    Integer idCenter = ur.getCenter().getIdCenter();
                    System.out.println("Cen " + centerDay);
                    Criteria cr = openSession.createCriteria(Loan.class);
                    cr.createAlias("members", "m");
                    cr.add(Restrictions.eq("m.idMembers", idMembers));

                    List<Loan> list = cr.list();

                    boolean flag = false;

                    int size = list.size();
                    size++;

                    String LoanIndex = decimalFormat.setCenterID(size);

                    for (Loan loan : list) {

                        String status = loan.getStatus();

                        if (status.equals("Unpaid")) {

                            flag = true;

                        } else if (loan.getIsActive().equals("Pending")) {
                            flag = true;

                        }

                    }

                    Criteria c = openSession.createCriteria(Members.class);
                    c.createAlias("center", "c");
                    c.add(Restrictions.eq("c.idCenter", idCenter));
                    c.add(Restrictions.eq("groupId", groupId));

                    String Gar = "";

                    List<Members> l = c.list();

                    for (Members members : l) {

                        if (!Objects.equals(members.getIdMembers(), idMembers)) {

                            Gar += members.getMemberNo() + " - " + members.getNameWithInitials() + "+";

                        }

                    }

                    JSONArray jsonArray = new JSONArray();
                    JSONObject js = new JSONObject();

                    js.put("nameWithInitials", nameWithInitials);
                    js.put("centerDay", centerDay);
                    js.put("LoanIndex", LoanIndex);
                    js.put("Gar", Gar);
                    js.put("flag", flag);
                    js.put("idMembers", idMembers);

                    jsonArray.put(js);

                    out.write(jsonArray.toString());

                } else {
                    out.write("SearchError");
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
