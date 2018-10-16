package Servlets.MicroFinance;

import ORM.Center;
import ORM.CenterHasStaff;
import ORM.Loan;
import ORM.Members;
import ORM.Repayment;
import Singleton.dateFormat;
import Singleton.decimalFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
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

@WebServlet(name = "ViewCenterCollectionTbleBranch", urlPatterns = {"/ViewCenterCollectionTbleBranch"})
public class ViewCenterCollectionTbleBranch extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            PrintWriter out = response.getWriter();
            Map<String, Integer> npcount = new HashMap();
            Map<String, Double> nptotal = new HashMap();
            Map<String, Integer> upcount = new HashMap();
            Map<String, Integer> cocount = new HashMap();
            Map<String, Integer> locount = new HashMap();
            Map<String, Double> colle = new HashMap();
            Map<String, Double> excollec = new HashMap();
            Map<String, Double> upay = new HashMap();
            Map<String, String> hmcenter = new HashMap();

            String dateChcek = request.getParameter("date");

            String setDateFull = dateFormat.setDateFull(dateChcek);

            npcount.clear();
            colle.clear();
            upay.clear();
            hmcenter.clear();

            String centerno = null;

            JSONArray jsonArray = new JSONArray();
            Session openSession = PoolManager.getSessionFactory().openSession();

            Criteria createCriteria = openSession.createCriteria(Center.class);

            createCriteria.add(Restrictions.eq("isActive", "Active"));
            createCriteria.add(Restrictions.eq("isApprove", "Approve"));
            createCriteria.add(Restrictions.eq("centerDay", dateFormat.parseDate(setDateFull)));

            List<Center> list = createCriteria.list();

            for (Center center : list) {

                Iterator it = center.getCenterHasStaffs().iterator();
                while (it.hasNext()) {

                    CenterHasStaff centerhasstaff = (CenterHasStaff) it.next();

                    Iterator members = centerhasstaff.getCenter().getMemberses().iterator();

                    while (members.hasNext()) {

                        Members members1 = (Members) members.next();

                        if (members1.getIsActive().equals("Active")) {

                        Iterator itt = members1.getLoans().iterator();

                        while (itt.hasNext()) {
                            System.out.println("loans in " + center.getCenterName());
                            Loan loan = (Loan) itt.next();

                            if (loan.getIsActive().equals("Active") && loan.getIsAprove().equals("Approve")) {

                                centerno = center.getCenterNo();

                                //Changes
                                if (excollec.get(centerno) == null) {

                                    excollec.put(centerno, loan.getLoanInstallment());
                                } else {

                                    excollec.put(centerno, loan.getLoanInstallment() + excollec.get(centerno));

                                }

                                if (locount.get(centerno) == null) {

                                    locount.put(centerno, 1);
                                } else {

                                    locount.put(centerno, locount.get(centerno) + 1);

                                }

                                /////////
                                if (npcount.get(centerno) == null) {
                                    System.out.println("List Empty");
                                    npcount.put(centerno, 1);
                                    System.out.println("1st " + npcount.get(centerno));
                                } else {

                                    System.out.println("Data Avaliable");
                                    Integer get = npcount.get(centerno);

                                    npcount.put(centerno, get + 1);
                                    System.out.println("incresed " + npcount.get(centerno));
                                }

                                Iterator repaymen = loan.getRepayments().iterator();
                                while (repaymen.hasNext()) {
                                    Repayment next = (Repayment) repaymen.next();

                                    if (next.getIsActive().equals("Active")) {

                                        if (next.getDate().equals(setDateFull)) {

                                            if (next.getActualDay().equals(dateFormat.DayOnlyString(setDateFull))) {

//                                            changes
                                                Integer get = npcount.get(centerno);

                                                npcount.put(centerno, get - 1);

//                                            changes
                                                if (true) {
//                                            if (next.getArreas().equals("ExePayment")) {

                                                    centerno = center.getCenterNo();

                                                    if (colle.get(centerno) == null) {
                                                        colle.put(centerno, next.getPaidAmount());

                                                    } else {

                                                        Double paidamount = next.getPaidAmount();
                                                        colle.put(center.getCenterNo(), paidamount + colle.get(centerno));

                                                    }
                                                    //1

                                                    if (next.getRepaymentAmount() > next.getPaidAmount()) {

                                                        centerno = center.getCenterNo();
                                                        //Changes
                                                        if (upcount.get(centerno) == null) {
                                                            upcount.put(centerno, 1);
                                                        } else {

                                                            upcount.put(centerno, upcount.get(centerno) + 1);

                                                        }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                        if (upay.get(centerno) == null) {
                                                            upay.put(center.getCenterNo(), next.getPaidAmount());
                                                        } else {

                                                            Double paidamount = next.getPaidAmount();

                                                            upay.put(center.getCenterNo(), paidamount + upay.get(centerno));

                                                        }

                                                    }
                                                }
                                            }

                                        }

                                    }
                                }
///end if
                            }
                        }
                    }
                }

                hmcenter.put(center.getCenterNo(), center.getCenterName());
                centerno = center.getCenterNo();

            }

        }
        System.out.println(centerno);

        System.out.println(colle);
        System.out.println(upay);
        for (Map.Entry<String, String> entry : hmcenter.entrySet()) {

            String tab = entry.getValue();

            double underpayment = 0.00;
            double collec = 0.00;

//                int loancount = 0;
//                int paymentcount = 0;
//                int uncount = 0;
            JSONObject jo = new JSONObject();
            String key = entry.getKey();
            jo.put("CenterNo", key);

            jo.put("CenterName", tab);

            if (npcount.get(key) != null) {
                jo.put("memberFee", npcount.get(key));

            } else {

                jo.put("memberFee", 0.0);

            }

            if (colle.get(key) != null) {

                jo.put("collection", decimalFormat.setAmount(colle.get(key)));
                collec = colle.get(key);

            } else {

                jo.put("collection", 0.00);

            }
            if (upay.get(key) != null) {

                jo.put("notpaid", decimalFormat.setAmount(upay.get(key)));
                underpayment = upay.get(key);

            } else {

                jo.put("notpaid", 0.0);

            }

            if (upcount.get(key) != null) {

                jo.put("upcount", upcount.get(key));

            } else {

                jo.put("upcount", 0);

            }

            if (excollec.get(key) != null) {
                jo.put("nptotal", decimalFormat.setAmount(excollec.get(key) - (collec + underpayment)));
                double total = (collec + underpayment);

                double collectionpre = total / excollec.get(key) * 100;

                jo.put("collpre", Math.round(collectionpre) + "%");
            } else {
                jo.put("nptotal", "N/A");
                jo.put("collpre", "N/A");

            }

            jsonArray.put(jo);

        }

        out.write(jsonArray.toString());

        openSession.close();

    }
    catch (Exception e

    
        ) {
            e.printStackTrace();
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
