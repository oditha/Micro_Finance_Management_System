package Servlets.MicroFinance;

import ORM.Center;
import ORM.Members;

import Singleton.decimalFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Member;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

@WebServlet(name = "GenMemberIDServlet", urlPatterns = {"/GenMemberIDServlet"})
public class GenMemberIDServlet extends HttpServlet {

    int idCenter;

   public static Map<String, TreeSet> map = new HashMap<String, TreeSet>();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String center = request.getParameter("CenterNO");
            String centerNO = request.getParameter("Center").split(" - ")[0];
            String branch = request.getParameter("branchNo").split(" - ")[0];

            if (map.get(centerNO) == null) {

                try {

                    Session session = PoolManager.getSessionFactory().openSession();

                    Criteria cr = session.createCriteria(Members.class);
                    cr.createAlias("center", "c");
                    cr.add(Restrictions.eq("c.idCenter", Integer.parseInt(center)));
                    cr.setProjection(Projections.rowCount());
//                List<Member> list = cr.list();
                    List list = cr.list();

                    String toString = list.get(0).toString();

                    TreeSet<Integer> tree = new TreeSet<Integer>();
                    int size = Integer.parseInt(toString);
                    size++;
                    tree.add(size);
                    map.put(centerNO, tree);
                    System.out.println(centerNO + " " + tree);
//                size++;

//                String memID = decimalFormat.setCenterID(size);
//                
//                String Memid = branch+"/"+centerNO+"/"+memID;
//                out.write(Memid);
                    session.close();

                } catch (Exception e) {

                    out.write("Select Center");
                    System.out.println(e);

                }

            }

            TreeSet get = map.get(centerNO);
            Integer last = (Integer) get.last();
//                last++;
//            get.add(last);
            System.out.println(last);
            String memID = decimalFormat.setCenterID(last);
//                
            String Memid = branch + "/" + centerNO + "/" + memID;
            out.write(Memid);

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
