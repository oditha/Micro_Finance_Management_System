package Servlets.Executive;

import ORM.Branch;
import ORM.Center;
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

@WebServlet(name = "AddCenterServletExecutive", urlPatterns = {"/AddCenterServletExecutive"})
public class AddCenterServletExecutive extends HttpServlet {

    int idBranch;
    int idStaff;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String user = request.getSession().getAttribute("userName").toString();

            String branch = request.getParameter("branch").split(" - ")[0];
            String staff = request.getParameter("Executive").split(" - ")[0];
            //            request.getParameter("Centercode")
            //            request.getParameter("CenterName")
            //            request.getParameter("CenterDay")
            //            request.getParameter("time")
            ;

            try {
                Session sess = PoolManager.getSessionFactory().openSession();
                Criteria cr1 = sess.createCriteria(Branch.class);
                cr1.add(Restrictions.eq("branchNo", branch));
            //    Object uniqueResult = cr1.uniqueResult();
                
                
                Branch b = (Branch) cr1.uniqueResult();
                idBranch = b.getIdBranch();
                sess.close();
                
                Session sess2 = PoolManager.getSessionFactory().openSession();
                
                Criteria cr2 = sess2.createCriteria(Staff.class);
                cr2.add(Restrictions.eq("nic", staff));
                Staff s = (Staff) cr2.uniqueResult();
                idStaff = s.getIdStaff();
                sess2.close();
               
                
                
                Session session = PoolManager.getSessionFactory().openSession();
                Transaction beginTransaction = session.beginTransaction();

                Branch branch1 = new Branch();
                branch1.setIdBranch(idBranch);

                Staff staff1 = new Staff();
                staff1.setIdStaff(idStaff);

                Center center = new Center();

                center.setCenterNo(request.getParameter("Centercode"));
                center.setBranch(branch1);
                center.setCenterName(request.getParameter("CenterName"));
                center.setCenterDay(request.getParameter("CenterDay"));
                center.setCentertime(request.getParameter("time"));
                center.setIsApprove("Pending");
                center.setIsActive("Pending");
                center.setCreatedBy(user);

                session.save(center);

                CenterHasStaff centerHasStaff = new CenterHasStaff();
                centerHasStaff.setCenter(center);
                centerHasStaff.setStaff(staff1);

                session.save(centerHasStaff);

                beginTransaction.commit();

                response.sendRedirect("Executive/addCenter.jsp?save=done");
                session.close();
            } catch (Exception e) {

                response.sendRedirect("MicroFinance/addCenter.jsp?save=error");
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
