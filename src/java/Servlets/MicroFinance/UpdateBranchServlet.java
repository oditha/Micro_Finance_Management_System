package Servlets.MicroFinance;

import ORM.Branch;
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

@WebServlet(name = "UpdateBranchServlet", urlPatterns = {"/UpdateBranchServlet"})
public class UpdateBranchServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            if (request.getParameter("btn").equals("Delete")) {

                try {

                    Session session = PoolManager.getSessionFactory().openSession();
                    Transaction beginTransaction = session.beginTransaction();

                    Criteria createCriteria = session.createCriteria(Branch.class);
                    createCriteria.add(Restrictions.eq("idBranch", Integer.parseInt(request.getParameter("branchID"))));

                    Branch branch = (Branch) createCriteria.uniqueResult();

                    branch.setIsActive("Deactivate");

                    beginTransaction.commit();
                    session.close();
                    response.sendRedirect("MicroFinance/addBranch.jsp?save=delete");
                } catch (Exception e) {

                    System.out.println(e);
                    response.sendRedirect("MicroFinance/addBranch.jsp?save=error");

                }

            } else if (request.getParameter("btn").equals("Update")) {

                try {

                    Session session = PoolManager.getSessionFactory().openSession();
                    Transaction beginTransaction = session.beginTransaction();

                    Criteria createCriteria = session.createCriteria(Branch.class);
                    createCriteria.add(Restrictions.eq("idBranch", Integer.parseInt(request.getParameter("branchID"))));

                    Branch branch = (Branch) createCriteria.uniqueResult();

                    branch.setBranchNo(request.getParameter("branchcode"));
                    branch.setBranchName(request.getParameter("branchName"));
                    branch.setAddress1(request.getParameter("address1"));
                    branch.setAddress2(request.getParameter("address2"));
                    branch.setCity(request.getParameter("city"));
                    branch.setContact1(request.getParameter("contact1"));
                    branch.setContact2(request.getParameter("contact2"));
                    branch.setIsActive("Active");

                    beginTransaction.commit();
                    session.close();
                    response.sendRedirect("MicroFinance/addBranch.jsp?save=done");
                } catch (Exception e) {

                    System.out.println(e);
                    response.sendRedirect("MicroFinance/addBranch.jsp?save=error");

                }
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
