package Servlets.MicroFinance;

import ORM.Center;
import ORM.CenterHasStaff;
import ORM.Loan;
import ORM.Members;
import ORM.Repayment;
import ORM.Staff;

import Singleton.dateFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
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

@WebServlet(name = "ViewCenterCollectionAll", urlPatterns = {"/ViewCenterCollectionAll"})
public class ViewCenterCollectionAll extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            double collection = 0;
            double NPcollection = 0;
            double memberfee = 0;
            double totalLoan = 0;
            String centerNo = null;
            String centerName = null;
            try {
                String parameter = request.getParameter("type");
                String dateChcek = request.getParameter("date");
//                String setDateFull = dateFormat.setDateFull(dateChcek);
                Session openSession = PoolManager.getSessionFactory().openSession();
                if (parameter.equals("exe")) {

                    String idStaff = request.getParameter("staffID");

                    collection = 0.00;
                    NPcollection = 0.00;
                    memberfee = 0.00;
                    totalLoan = 0.00;

                    Criteria cr = openSession.createCriteria(CenterHasStaff.class);
                    cr.createAlias("staff", "s");
                    cr.add(Restrictions.eq("s.idStaff", Integer.parseInt(idStaff)));

                    List<CenterHasStaff> list = cr.list();

                    for (CenterHasStaff chs : list) {

                        Center center = chs.getCenter();
                        Iterator it = center.getMemberses().iterator();
                        centerNo = center.getCenterNo();
                        centerName = center.getCenterName();
                        while (it.hasNext()) {

                            Members mem = (Members) it.next();

                            Iterator it2 = mem.getLoans().iterator();

                            while (it2.hasNext()) {
                                Loan loan = (Loan) it2.next();

                                String issueDate = loan.getIssueDate();

                                //   if (issueDate.equals(setDateFull)) {
                                memberfee += Double.parseDouble(loan.getMemberfee());
                                totalLoan += loan.getRenewAmount();

                                //}
                                Iterator it3 = loan.getRepayments().iterator();
                                while (it3.hasNext()) {

                                    Repayment re = (Repayment) it3.next();

                                    String date = re.getDate();

                                    //      if (date.equals(setDateFull)) {
                                    String actualDay = re.getActualDay();
                                    String currentDay = re.getCurrentDay();

                                    if (actualDay.equals(currentDay)) {

                                        collection += re.getPaidAmount();

                                    } else if (!(actualDay.equals(currentDay))) {

                                        NPcollection += re.getPaidAmount();

                                        // }
                                    }

                                }

                            }

                        }

                    }

                } else if (parameter.equals("center")) {

                    String idCenter = request.getParameter("CenterID");

                    collection = 0.00;
                    NPcollection = 0.00;
                    memberfee = 0.00;
                    totalLoan = 0.00;

                    Criteria createCriteria = openSession.createCriteria(Center.class);
                    createCriteria.add(Restrictions.eq("idCenter", Integer.parseInt(idCenter)));
                    Center uniqueResult = (Center) createCriteria.uniqueResult();
                    centerNo = uniqueResult.getCenterNo();
                    centerName = uniqueResult.getCenterName();
                    Iterator it = uniqueResult.getMemberses().iterator();
                    while (it.hasNext()) {

                        Members mem = (Members) it.next();
                        Iterator it2 = mem.getLoans().iterator();

                        while (it2.hasNext()) {
                            Loan loan = (Loan) it2.next();
                            String issueDate = loan.getIssueDate();
                            // if (issueDate.equals(setDateFull)) {

                            memberfee += Double.parseDouble(loan.getMemberfee());
                            totalLoan += loan.getRenewAmount();

                            // }
                            Iterator it3 = loan.getRepayments().iterator();

                            while (it3.hasNext()) {
                                Repayment re = (Repayment) it3.next();

                                String date = re.getDate();

                                collection += re.getPaidAmount();

                            }

                        }

                    }

                }

                JSONArray jsonArray = new JSONArray();
                JSONObject jo = new JSONObject();

                jo.put("collection", collection);
                jo.put("notpaid", NPcollection);
                jo.put("memberFee", memberfee);
                jo.put("totalLoan", totalLoan);
                //   jo.put("CenterNo", );
                jo.put("CenterNo", centerNo);
                jo.put("CenterName", centerName);

                jsonArray.put(jo);
                openSession.close();
                out.write(jsonArray.toString());

            } catch (Exception e) {

                out.write("error");
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
