package Servlets.MicroFinance;

import Holders.RepaymentHolder;
import ORM.Center;
import ORM.Loan;
import ORM.Members;
import ORM.Repayment;
import Singleton.decimalFormat;

import Srcs.PoolManager;
import Srcs.WeeksCount;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.view.JasperViewer;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

@WebServlet(name = "RepaymentSheetJasper", urlPatterns = {"/RepaymentSheetJasper"})
public class RepaymentSheetJasper extends HttpServlet {

    public static List<RepaymentHolder> holder = new ArrayList<>();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {

                Map<String, String> hm = new TreeMap<String, String>();
                System.out.println(request.getParameter("id"));
                int idCenter = Integer.parseInt(request.getParameter("id"));
//                int idCenter = 13;
                holder.clear();
                String group = "";
                String memNo = "";
                String memName = "";
                String contact = "";
                double loanAmount = 0;
                double interest = 0;
                double rental = 0;
                double paid = 0;
                double Remain = 0;
                double arrears = 0;
                double defau = 0;

                Session openSession = PoolManager.getSessionFactory().openSession();

                Criteria cr = openSession.createCriteria(Center.class);
                cr.add(Restrictions.eq("idCenter", idCenter));

                Center cen = (Center) cr.uniqueResult();

                RepaymentHolder rh0 = new RepaymentHolder();
                rh0.setArrears(decimalFormat.setAmount(arrears));
                rh0.setBalance(decimalFormat.setAmount(Remain));
                rh0.setCenter(cen.getCenterName());
                rh0.setContactno(contact);
                rh0.setGroupno(group);
                rh0.setLoan(decimalFormat.setAmount(loanAmount));
                rh0.setMembername(memName);
                rh0.setMemberno(memNo);
                rh0.setRental(decimalFormat.setAmount(rental));

                holder.add(rh0);
                Set memberses = cen.getMemberses();
                Iterator it = cen.getMemberses().iterator();
                while (it.hasNext()) {
                    Members mem = (Members) it.next();
                    memNo = "";
                    memName = "";
                    loanAmount = 0;
                    rental = 0;
                    Remain = 0;
                    contact = "";
                    group = "";
                    paid = 0;
                    if (mem.getIsActive().equals("Active") && mem.getAproved().equals("Approve")) {

                        Iterator it1 = mem.getLoans().iterator();

                        while (it1.hasNext()) {
                            Loan loan = (Loan) it1.next();
                            if (loan.getStatus().equals("Unpaid") && loan.getIsActive().equals("Active")
                                    && loan.getIsAprove().equals("Approve")) {

                                Iterator it2 = loan.getRepayments().iterator();
                                int weeksCount = WeeksCount.weeksCount(loan.getIssueDate(), loan.getRepaymentDay());
                                defau = weeksCount * loan.getLoanInstallment();
                                while (it2.hasNext()) {

                                    Repayment re = (Repayment) it2.next();
                                    if (re.getIsActive().equals("Active") && re.getIsAproved().equals("Approve")) {

                                        paid += re.getPaidAmount();

                                    }

                                }

                                memNo = mem.getMemberNo();
                                memName = mem.getNameWithInitials();
                                loanAmount = loan.getLoanAmount();
                                interest = loan.getLoanInterest();
                                rental = loan.getLoanInstallment();
                                Remain = (loanAmount + interest) - paid;
                                contact = mem.getContactNo();
                                group = mem.getGroupId();

                                if (weeksCount > loan.getLoanPeriod()) {

                                    arrears = (loanAmount + interest) - paid;
                                } else {

                                    arrears = defau - paid;

                                }

                                RepaymentHolder rh = new RepaymentHolder();
                                rh.setArrears(decimalFormat.setAmount(arrears));
                                rh.setBalance(decimalFormat.setAmount(Remain));
                                rh.setCenter(cen.getCenterName());
                                rh.setContactno(contact);
                                rh.setGroupno(group);
                                rh.setLoan(decimalFormat.setAmount(loanAmount));
                                rh.setMembername(memName);
                                rh.setMemberno(memNo);
                                rh.setRental(decimalFormat.setAmount(rental));

                                holder.add(rh);

                            }
                        }

                    }

                }

                Collections.sort(holder, (RepaymentHolder o1, RepaymentHolder o2) -> {
                    return o1.getMemberno().compareTo(o2.getMemberno());
                });

                Collections.sort(holder, (RepaymentHolder o1, RepaymentHolder o2) -> {
                    return o1.getGroupno().compareTo(o2.getGroupno());
                });
                
                ///////////////////////////////////
                
                 int size = holder.size();


                System.out.println("Size " + size);
                double pagecount = (size - 1) / 20;
                System.out.println("Pagecount " + pagecount);
                Math.round(pagecount);
                System.out.println("Pagecount Round " + pagecount);

                for (double i = size; i < 30; i++) {
                    System.out.println("tow " + i);

                    RepaymentHolder rh = new RepaymentHolder();
                    rh.setArrears("");
                    rh.setBalance("");
                    rh.setCenter("");
                    rh.setContactno("");
                    rh.setGroupno("");
                    rh.setLoan("");
                    rh.setMembername("");
                    rh.setMemberno("");
                    rh.setRental("");

                    holder.add(rh);
                }
                
                //////////////////////////////////////
                
                System.out.println(holder);
                openSession.close();
                out.write("OK");
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
