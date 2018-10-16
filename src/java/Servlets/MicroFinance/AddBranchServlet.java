package Servlets.MicroFinance;

import ORM.Branch;
import ORM.Center;

import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;

@WebServlet(name = "AddBranchServlet", urlPatterns = {"/AddBranchServlet"})
public class AddBranchServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {
                HttpSession session = request.getSession();

                System.out.println("OOOOOOOJNdkjdij" + request.getParameter("branchcode"));

                session.getAttribute("userName");

                Session db = PoolManager.getSessionFactory().openSession();

                Transaction beginTransaction = db.beginTransaction();

                Branch branch = new Branch();
                
                

                branch.setBranchNo(request.getParameter("branchcode"));
                branch.setBranchName(request.getParameter("branchName"));
                branch.setAddress1(request.getParameter("address1"));
                branch.setAddress2(request.getParameter("address2"));
                branch.setCity(request.getParameter("city"));
                branch.setContact1(request.getParameter("contact1"));
                branch.setContact2(request.getParameter("contact2"));
                branch.setIsActive("Active");

                db.save(branch);

                beginTransaction.commit();

                db.close();
                response.sendRedirect("MicroFinance/addBranch.jsp?save=done");
            } catch (Exception e) {


                response.sendRedirect("MicroFinance/addBranch.jsp?save=error");
                e.printStackTrace();

                

            }

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

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
