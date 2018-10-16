package Servlets.MicroFinance;

import ORM.Center;
import ORM.CenterHasStaff;
import ORM.Loan;
import ORM.Members;
import ORM.Staff;

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
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

@WebServlet(name = "UpdateCentersServlet", urlPatterns = {"/UpdateCentersServlet"})
public class UpdateCentersServlet extends HttpServlet {

    int idStaff;
    int CenterID;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String cenID = request.getParameter("cenid");

            if (request.getParameter("btn").equals("Delete")) {

                try {
                    Session session = PoolManager.getSessionFactory().openSession();
                    Transaction beginTransaction = session.beginTransaction();
                    Criteria cr = session.createCriteria(Center.class);
                    cr.add(Restrictions.eq("idCenter", Integer.parseInt(cenID)));
                    Center c = (Center) cr.uniqueResult();
                    c.setIsActive("Deactivate");
                    beginTransaction.commit();
                    session.close();
                    response.sendRedirect("MicroFinance/addCenter.jsp?save=delete");
                } catch (Exception e) {

                    response.sendRedirect("MicroFinance/addCenter.jsp?save=error");

                    System.out.println(e);

                }

            } else if (request.getParameter("btn").equals("Update")) {

                try {
                    String staff = request.getParameter("Executive").split(" - ")[0];
                    Session openSession = PoolManager.getSessionFactory().openSession();
                    Criteria cr2 = openSession.createCriteria(Staff.class);
                    cr2.add(Restrictions.eq("nic", staff));
                    Staff s = (Staff) cr2.uniqueResult();
                    idStaff = s.getIdStaff();

//                    Criteria ccc = openSession.createCriteria(Center.class);
//                    ccc.add(Restrictions.eq("centerNo", request.getParameter("branchcode")));
//                    Center uq = (Center) ccc.uniqueResult();
//                    System.out.println("CENID " + uq.getIdCenter());
//                    CenterID = uq.getIdCenter();
                    Staff staff1 = new Staff();
                    staff1.setIdStaff(idStaff);
                    openSession.close();
                    Session session = PoolManager.getSessionFactory().openSession();
                    Transaction beginTransaction = session.beginTransaction();
                    Criteria cr = session.createCriteria(Center.class);
                    cr.add(Restrictions.eq("idCenter", Integer.parseInt(cenID)));
                    Center cen = (Center) cr.uniqueResult();

                    cen.setCenterName(request.getParameter("CenterName"));
                    cen.setCenterDay(request.getParameter("CenterDay"));
                    cen.setCentertime(request.getParameter("time"));
                    cen.setCenterNo(request.getParameter("branchcode"));

                    session.update(cen);

                    Iterator iterator = cen.getMemberses().iterator();
                    while (iterator.hasNext()) {

                        Members next = (Members) iterator.next();
                        Iterator<Loan> itt = next.getLoans().iterator();
                        while (itt.hasNext()) {
                            Loan next1 = itt.next();
                            next1.setRepaymentDay(request.getParameter("CenterDay"));

                            session.save(next1);
                        }

                    }

                    Criteria cc = session.createCriteria(CenterHasStaff.class);
                    cc.createAlias("center", "c");
                    cc.add(Restrictions.eq("c.idCenter", Integer.parseInt(cenID)));
                    CenterHasStaff uqw = (CenterHasStaff) cc.uniqueResult();

                    uqw.setStaff(staff1);

                    session.update(uqw);

                    beginTransaction.commit();

                    session.close();
                    response.sendRedirect("MicroFinance/addCenter.jsp?save=done");
                } catch (Exception e) {

                    response.sendRedirect("MicroFinance/addCenter.jsp?save=error");
                    System.out.println(e);
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
