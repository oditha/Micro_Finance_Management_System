package Servlets.MicroFinance;

import ORM.Branch;
import ORM.Center;

import Singleton.decimalFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

@WebServlet(name = "GenCenterIDServlet", urlPatterns = {"/GenCenterIDServlet"})
public class GenCenterIDServlet extends HttpServlet {

    String idBranch;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String name = request.getParameter("branchNo").split(" - ")[0];
            System.out.println(name);
            Session openSession = PoolManager.getSessionFactory().openSession();

            try {
                Criteria createCriteria = openSession.createCriteria(Branch.class);
                createCriteria.add(Restrictions.eq("branchNo", name));
//                createCriteria.add(Restrictions.eq("isActive", "Active"));
                
                Branch branch = (Branch) createCriteria.uniqueResult();
                idBranch = branch.getIdBranch().toString();
                System.out.println("Id Branch" + idBranch);
            } catch (Exception e) {

                System.out.println(e);

            }

            try {

                Criteria cr = openSession.createCriteria(Center.class);
                cr.createAlias("branch", "b");
                cr.add(Restrictions.eq("b.idBranch", Integer.parseInt(idBranch)));
                cr.add(Restrictions.eq("isActive", "Active"));

                List<Center> list = cr.list();

                int count = list.size() + 1;

                String setCenterID = decimalFormat.setCenterID(count);

                openSession.close();
                System.out.println("CCCC " + count);
                out.write(setCenterID);

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
