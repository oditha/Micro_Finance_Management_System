package Servlets.MicroFinance;

import ORM.Loan;
import ORM.Members;
import ORM.Repayment;

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
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet(name = "RenewLoanSearchAJAX", urlPatterns = {"/RenewLoanSearchAJAX"})
public class RenewLoanSearchAJAX extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String Restric = "memberNo";

            try {

                String id = request.getParameter("member");
//                out.write(id);
                char charAt = id.charAt(0);

                if (!id.contains("/")) {

                    Restric = "nic";

                } else {

                    Restric = "memberNo";

                }

                Criteria createCriteria = PoolManager.getSessionFactory().openSession().createCriteria(Members.class);
                createCriteria.add(Restrictions.eq(Restric, id));
                Members ur = (Members) createCriteria.uniqueResult();

                if (ur != null) {

                    String nameWithInitials = ur.getNameWithInitials();
                    String groupId = ur.getGroupId();
                    String centerDay = ur.getCenter().getCenterDay();
                    Integer idMembers = ur.getIdMembers();
                    Integer idCenter = ur.getCenter().getIdCenter();
                    String memberNo = ur.getMemberNo();
                    Session openSession = PoolManager.getSessionFactory().openSession();
                    
                    Criteria cr = openSession.createCriteria(Loan.class);
                    cr.createAlias("members", "m");
                    cr.add(Restrictions.eq("m.idMembers", idMembers));

                    List<Loan> list = cr.list();

                    int size = list.size();
                    size++;

                    String LoanIndex = decimalFormat.setCenterID(size);

                    int loanID = 0;
                    double loanamount = 0.00;
                    double loanInstallment = 0.00;
                    for (Loan loan : list) {

                        String status = loan.getStatus();

                        if (status.equals("Unpaid")) {

                            loanID = loan.getIdLoan();
                            loanamount = loan.getLoanAmount() + loan.getLoanInterest();
                            loanInstallment = loan.getLoanInstallment();

                        }else if(loan.getIsActive().equals("Pending")){
                        
                        
                            out.write("err");
                            
                        }
//                        PoolManager.getSessionFactory().openSession().close();
                    }

                    Criteria crr = openSession.createCriteria(Repayment.class);
                    crr.createAlias("loan", "l");
                    crr.add(Restrictions.eq("l.idLoan", loanID));
                    crr.add(Restrictions.eq("isActive", "Active"));
                    crr.setProjection(Projections.sum("paidAmount"));
                    List list1 = crr.list();
                    String toString = list1.get(0).toString();

                    double balance = loanamount - Double.parseDouble(toString);

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

                    js.put("memberName", nameWithInitials);
                    js.put("reDay", centerDay);
                    js.put("lindex", LoanIndex);
                    js.put("Gar", Gar);
                    js.put("pLoan", balance);
                    js.put("memberID", idMembers);
                    js.put("memberSearch", memberNo);
                    js.put("ins", loanInstallment);
                    js.put("loanid", loanID);

                    jsonArray.put(js);
                    openSession.close();
                    out.write(jsonArray.toString());

                } else {
                    out.write("SearchError");
                }

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
