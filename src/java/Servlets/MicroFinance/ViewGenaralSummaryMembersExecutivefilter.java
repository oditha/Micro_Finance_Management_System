package Servlets.MicroFinance;

import ORM.Center;
import ORM.CenterHasStaff;
import ORM.Loan;
import ORM.Members;
import ORM.Repayment;

import Singleton.decimalFormat;
import Srcs.PoolManager;
import Srcs.WeeksCount;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
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

@WebServlet(name = "ViewGenaralSummaryMembersExecutivefilter", urlPatterns = {"/ViewGenaralSummaryMembersExecutivefilter"})
public class ViewGenaralSummaryMembersExecutivefilter extends HttpServlet {

    String MemberNo = null;
    String MemberNAme = null;
    String ContractNo = null;
    double loanAmount = 0;
    double totalPaid = 0;
    double remaningAmount = 0;
    double totalAmount = 0;
    int count = 0;
    double totalInstallment = 0;
    int installmentCount = 0;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String type = request.getParameter("type");
            String idCenter = request.getParameter("idCenter");
            String Executiveid = request.getParameter("Executiveid");

            try {

                if (type.equals("ALL Members")) {
                  
                    
                    JSONArray ja = new JSONArray();
                    Session openSession = PoolManager.getSessionFactory().openSession();
                    Criteria cr = openSession.createCriteria(Center.class);
                  //  cr.add(Restrictions.eq("idCenter", Integer.parseInt(idCenter)));
                   // Center cen = (Center) cr.uniqueResult();
                    List<Center> list = cr.list();
                   
                    for (Center cen : list) {
                        
                        Iterator it6 = cen.getCenterHasStaffs().iterator();
                        while (it6.hasNext()) {
                            CenterHasStaff chs = (CenterHasStaff) it6.next();
                            
                            
                            if (chs.getStaff().getIdStaff()==Integer.parseInt(Executiveid)) {
                                
                          
                   Set<Members> set = cen.getMemberses();
                    Iterator it = set.iterator();
                    while (it.hasNext()) {

                        System.out.println("Member");

                        Members mem = (Members) it.next();
                        if (mem.getIsActive().equals("Active")) {
                            MemberNo = "";
                            MemberNAme = "";
                            ContractNo = "";
                            loanAmount = 0;
                            totalPaid = 0;
                            remaningAmount = 0;
                            totalAmount = 0;

                            Iterator it2 = mem.getLoans().iterator();
                            while (it2.hasNext()) {

                                Loan loan = (Loan) it2.next();

                                if (loan.getStatus().equals("Unpaid")) {

                                    count++;
                                    MemberNo = mem.getMemberNo();
                                    MemberNAme = mem.getNameWithInitials();
                                    ContractNo = loan.getContractNo();
                                    loanAmount = loan.getLoanAmount();
                                    totalAmount = loan.getLoanInterest() + loan.getLoanAmount();

                                    Iterator it3 = loan.getRepayments().iterator();
                                    while (it3.hasNext()) {

                                        Repayment repay = (Repayment) it3.next();

                                        totalPaid += repay.getPaidAmount();

                                    }

                                    remaningAmount = totalAmount - totalPaid;
                                    JSONObject ob = new JSONObject();

                                    ob.put("Count", count);
                                    ob.put("MemberNo", MemberNo);
                                    ob.put("MemberNAme", MemberNAme);
                                    ob.put("ContractNo", ContractNo);
                                    ob.put("loanAmount", decimalFormat.setAmount(loanAmount));
                                    ob.put("totalAmount", decimalFormat.setAmount(totalAmount));
                                    ob.put("totalPaid", decimalFormat.setAmount(totalPaid));
                                    ob.put("remaningAmount", decimalFormat.setAmount(remaningAmount));

                                    ja.put(ob);

                                }

                            }

                        }

                    }
                    
                    }}
  }
                    openSession.close();
                    out.write(ja.toString());

                } else if (type.equals("Under Payment Members")) {
                    
                    
                    JSONArray ja = new JSONArray();
                    
                    Session openSession = PoolManager.getSessionFactory().openSession();
                    Criteria cr = openSession.createCriteria(Center.class);
                    //cr.add(Restrictions.eq("idCenter", Integer.parseInt(idCenter)));
                    List <Center>list = cr.list();
                    
                    for (Center cen : list) {
                        
                        Iterator it6 = cen.getCenterHasStaffs().iterator();
                        
                        while (it6.hasNext()) {
                            CenterHasStaff chs = (CenterHasStaff) it6.next();
                            
                            if (chs.getStaff().getIdStaff()==Integer.parseInt(Executiveid)) {
                                
                         
                    
                    
                  //  Center cen = (Center) cr.uniqueResult();
                    Set<Members> set = cen.getMemberses();
                    Iterator it = set.iterator();
                    while (it.hasNext()) {

                        System.out.println("Member");

                        Members mem = (Members) it.next();
                        if (mem.getIsActive().equals("Active")) {
                            MemberNo = "";
                            MemberNAme = "";
                            ContractNo = "";
                            loanAmount = 0;
                            totalPaid = 0;
                            remaningAmount = 0;
                            totalAmount = 0;
                            totalInstallment = 0;
                            Iterator it2 = mem.getLoans().iterator();
                            while (it2.hasNext()) {

                                Loan loan = (Loan) it2.next();

                                if (loan.getStatus().equals("Unpaid")) {

                                    count++;
                                    MemberNo = mem.getMemberNo();
                                    MemberNAme = mem.getNameWithInitials();
                                    ContractNo = loan.getContractNo();
                                    loanAmount = loan.getLoanAmount();
                                    totalAmount = loan.getLoanInterest() + loan.getLoanAmount();

                                    Iterator it3 = loan.getRepayments().iterator();
                                    while (it3.hasNext()) {

                                        Repayment repay = (Repayment) it3.next();

                                        totalPaid += repay.getPaidAmount();
                                        totalInstallment += repay.getRepaymentAmount();

                                    }

                                    if (totalPaid < totalInstallment) {

                                        remaningAmount = totalAmount - totalPaid;
                                        JSONObject ob = new JSONObject();

                                        ob.put("Count", count);
                                        ob.put("MemberNo", MemberNo);
                                        ob.put("MemberNAme", MemberNAme);
                                        ob.put("ContractNo", ContractNo);
                                        ob.put("loanAmount", decimalFormat.setAmount(loanAmount));
                                        ob.put("totalAmount", decimalFormat.setAmount(totalAmount));
                                        ob.put("totalPaid", decimalFormat.setAmount(totalPaid));
                                        ob.put("remaningAmount", decimalFormat.setAmount(remaningAmount));

                                        ja.put(ob);

                                    }

                                }

                            }

                        }

                    }
                       }
                            
                        }
                        
                    }

                    openSession.close();
                    out.write(ja.toString());
                } else if (type.equals("Over Payment Members")) {

                    Session openSession = PoolManager.getSessionFactory().openSession();
                    JSONArray ja = new JSONArray();

                    Criteria cr = openSession.createCriteria(Center.class);
                   // cr.add(Restrictions.eq("idCenter", Integer.parseInt(idCenter)));
                    List <Center>list = cr.list();
                    
                    for (Center cen : list) {
                        
                        Iterator it6 = cen.getCenterHasStaffs().iterator();
                        
                        while (it6.hasNext()) {
                            CenterHasStaff chs = (CenterHasStaff) it6.next();
                            
                            if (chs.getStaff().getIdStaff()==Integer.parseInt(Executiveid)) {
                                
                        
//                    Center cen = (Center) cr.uniqueResult();
                    Set<Members> set = cen.getMemberses();
                    Iterator it = set.iterator();
                    while (it.hasNext()) {

                        System.out.println("Member");

                        Members mem = (Members) it.next();
                        if (mem.getIsActive().equals("Active")) {
                            MemberNo = "";
                            MemberNAme = "";
                            ContractNo = "";
                            loanAmount = 0;
                            totalPaid = 0;
                            remaningAmount = 0;
                            totalAmount = 0;
                            totalInstallment = 0;
                            Iterator it2 = mem.getLoans().iterator();
                            while (it2.hasNext()) {

                                Loan loan = (Loan) it2.next();

                                if (loan.getStatus().equals("Unpaid")) {

                                    count++;
                                    MemberNo = mem.getMemberNo();
                                    MemberNAme = mem.getNameWithInitials();
                                    ContractNo = loan.getContractNo();
                                    loanAmount = loan.getLoanAmount();
                                    totalAmount = loan.getLoanInterest() + loan.getLoanAmount();

                                    Iterator it3 = loan.getRepayments().iterator();
                                    while (it3.hasNext()) {

                                        Repayment repay = (Repayment) it3.next();

                                        totalPaid += repay.getPaidAmount();
                                        totalInstallment += repay.getRepaymentAmount();

                                    }

                                    if (totalPaid > totalInstallment) {

                                        remaningAmount = totalAmount - totalPaid;
                                        JSONObject ob = new JSONObject();

                                        ob.put("Count", count);
                                        ob.put("MemberNo", MemberNo);
                                        ob.put("MemberNAme", MemberNAme);
                                        ob.put("ContractNo", ContractNo);
                                        ob.put("loanAmount", decimalFormat.setAmount(loanAmount));
                                        ob.put("totalAmount", decimalFormat.setAmount(totalAmount));
                                        ob.put("totalPaid", decimalFormat.setAmount(totalPaid));
                                        ob.put("remaningAmount", decimalFormat.setAmount(remaningAmount));

                                        ja.put(ob);

                                    }

                                }

                            }

                        }

                    }
    }
                            
                        }
                        
                    }
                    openSession.close();
                    out.write(ja.toString());
                } else if (type.equals("Not Paid Members")) {
                    
                    Session openSession = PoolManager.getSessionFactory().openSession();

                    JSONArray ja = new JSONArray();
                    Criteria cr = PoolManager.getSessionFactory().openSession().createCriteria(Center.class);
                    //cr.add(Restrictions.eq("idCenter", Integer.parseInt(idCenter)));
                     List <Center>list = cr.list();
                    
                    for (Center cen : list) {
                        
                        Iterator it6 = cen.getCenterHasStaffs().iterator();
                        
                        while (it6.hasNext()) {
                            CenterHasStaff chs = (CenterHasStaff) it6.next();
                            
                            if (chs.getStaff().getIdStaff()==Integer.parseInt(Executiveid)) {
                                
                         
                   // Center cen = (Center) cr.uniqueResult();
                    Set<Members> set = cen.getMemberses();
                    Iterator it = set.iterator();
                    while (it.hasNext()) {

                        Members mem = (Members) it.next();
                        if (mem.getIsActive().equals("Active")) {
                            MemberNo = "";
                            MemberNAme = "";
                            ContractNo = "";
                            loanAmount = 0;
                            totalPaid = 0;
                            remaningAmount = 0;
                            totalAmount = 0;
                            totalInstallment = 0;
                            installmentCount = 0;

                            Iterator it2 = mem.getLoans().iterator();
                            while (it2.hasNext()) {

                                Loan loan = (Loan) it2.next();

                                if (loan.getStatus().equals("Unpaid")) {

                                    count++;
                                    MemberNo = mem.getMemberNo();
                                    MemberNAme = mem.getNameWithInitials();
                                    ContractNo = loan.getContractNo();
                                    loanAmount = loan.getLoanAmount();
                                    totalAmount = loan.getLoanInterest() + loan.getLoanAmount();

                                    Set repayments = loan.getRepayments();
                                    int size = repayments.size();
                                    int weeksCount = WeeksCount.weeksCount(loan.getIssueDate(), loan.getRepaymentDay());
                                    if (size < weeksCount) {

                                        Iterator it3 = loan.getRepayments().iterator();
                                        while (it3.hasNext()) {

                                            Repayment repay = (Repayment) it3.next();

                                            totalPaid += repay.getPaidAmount();
                                            totalInstallment += repay.getRepaymentAmount();

                                        }
                                        if (totalPaid < totalInstallment) {

                                            remaningAmount = totalAmount - totalPaid;
                                            JSONObject ob = new JSONObject();

                                            ob.put("Count", count);
                                            ob.put("MemberNo", MemberNo);
                                            ob.put("MemberNAme", MemberNAme);
                                            ob.put("ContractNo", ContractNo);
                                            ob.put("loanAmount", decimalFormat.setAmount(loanAmount));
                                            ob.put("totalAmount", decimalFormat.setAmount(totalAmount));
                                            ob.put("totalPaid", decimalFormat.setAmount(totalPaid));
                                            ob.put("remaningAmount", decimalFormat.setAmount(remaningAmount));

                                            ja.put(ob);

                                        }

                                    }

                                }

                            }

                        }

                    }
                       }
                            
                        }
                        
                    }

                    out.write(ja.toString());
                    openSession.close();
                } else if (type.equals("Arrears Members")) {
                    Session openSession = PoolManager.getSessionFactory().openSession();
                    
                    Criteria cr = openSession.createCriteria(Center.class);
                    JSONArray ja = new JSONArray();
                    //cr.add(Restrictions.eq("idCenter", Integer.parseInt(idCenter)));
                     List <Center>list = cr.list();
                    
                    for (Center cen : list) {
                        
                        Iterator it6 = cen.getCenterHasStaffs().iterator();
                        
                        while (it6.hasNext()) {
                            CenterHasStaff chs = (CenterHasStaff) it6.next();
                            
                            if (chs.getStaff().getIdStaff()==Integer.parseInt(Executiveid)) {
                                
                          
                  //  }
                   // Center cen = (Center) cr.uniqueResult();
                    Set<Members> set = cen.getMemberses();
                    Iterator it = set.iterator();
                    while (it.hasNext()) {

                        Members mem = (Members) it.next();
                        if (mem.getIsActive().equals("Active")) {
                            MemberNo = "";
                            MemberNAme = "";
                            ContractNo = "";
                            loanAmount = 0;
                            totalPaid = 0;
                            remaningAmount = 0;
                            totalAmount = 0;
                            totalInstallment = 0;
                            installmentCount = 0;

                            Iterator it2 = mem.getLoans().iterator();
                            while (it2.hasNext()) {

                                Loan loan = (Loan) it2.next();

                                if (loan.getStatus().equals("Unpaid")) {

                                    count++;
                                    MemberNo = mem.getMemberNo();
                                    MemberNAme = mem.getNameWithInitials();
                                    ContractNo = loan.getContractNo();
                                    loanAmount = loan.getLoanAmount();
                                    totalAmount = loan.getLoanInterest() + loan.getLoanAmount();

                                    Set repayments = loan.getRepayments();
                                    int size = repayments.size();
                                    int weeksCount = WeeksCount.weeksCount(loan.getIssueDate(), loan.getRepaymentDay());
                                    if (size == weeksCount) {

                                        Iterator it3 = loan.getRepayments().iterator();
                                        while (it3.hasNext()) {

                                            Repayment repay = (Repayment) it3.next();

                                            totalPaid += repay.getPaidAmount();
                                            totalInstallment += repay.getRepaymentAmount();

                                        }
                                        if (totalPaid < totalInstallment) {

                                            remaningAmount = totalAmount - totalPaid;
                                            JSONObject ob = new JSONObject();

                                            ob.put("Count", count);
                                            ob.put("MemberNo", MemberNo);
                                            ob.put("MemberNAme", MemberNAme);
                                            ob.put("ContractNo", ContractNo);
                                            ob.put("loanAmount", decimalFormat.setAmount(loanAmount));
                                            ob.put("totalAmount", decimalFormat.setAmount(totalAmount));
                                            ob.put("totalPaid", decimalFormat.setAmount(totalPaid));
                                            ob.put("remaningAmount", decimalFormat.setAmount(remaningAmount));

                                            ja.put(ob);

                                        }

                                    }

                                }

                            }

                        }

                    }
                            }
                    
                        }
                            
                        }
                      
                    openSession.close();
                    out.write(ja.toString());
                } else if (type.equals("Expired Members")) {
                    JSONArray ja = new JSONArray();
                    Session openSession = PoolManager.getSessionFactory().openSession();
                    Criteria cr = openSession.createCriteria(Center.class);
                    //cr.add(Restrictions.eq("idCenter", Integer.parseInt(idCenter)));
                     List <Center>list = cr.list();
                    
                    for (Center cen : list) {
                        
                        Iterator it6 = cen.getCenterHasStaffs().iterator();
                        
                        while (it6.hasNext()) {
                            CenterHasStaff chs = (CenterHasStaff) it6.next();
                            
                            if (chs.getStaff().getIdStaff()==Integer.parseInt(Executiveid)) {
                                
                       
                   // Center cen = (Center) cr.uniqueResult();
                    Set<Members> set = cen.getMemberses();
                    Iterator it = set.iterator();
                    while (it.hasNext()) {

                        Members mem = (Members) it.next();
                        if (mem.getIsActive().equals("Active")) {
                            MemberNo = "";
                            MemberNAme = "";
                            ContractNo = "";
                            loanAmount = 0;
                            totalPaid = 0;
                            remaningAmount = 0;
                            totalAmount = 0;
                            totalInstallment = 0;
                            installmentCount = 0;

                            Iterator it2 = mem.getLoans().iterator();
                            while (it2.hasNext()) {

                                Loan loan = (Loan) it2.next();

                                if (loan.getStatus().equals("Unpaid")) {

                                    count++;
                                    MemberNo = mem.getMemberNo();
                                    MemberNAme = mem.getNameWithInitials();
                                    ContractNo = loan.getContractNo();
                                    loanAmount = loan.getLoanAmount();
                                    totalAmount = loan.getLoanInterest() + loan.getLoanAmount();

                                    Set repayments = loan.getRepayments();
                                    int size = repayments.size();
                                    int weeksCount = WeeksCount.weeksCount(loan.getIssueDate(), loan.getRepaymentDay());
                                    if (loan.getLoanPeriod() < weeksCount) {

                                        Iterator it3 = loan.getRepayments().iterator();
                                        while (it3.hasNext()) {

                                            Repayment repay = (Repayment) it3.next();

                                            totalPaid += repay.getPaidAmount();
                                            totalInstallment += repay.getRepaymentAmount();

                                        }
                                        remaningAmount = totalAmount - totalPaid;
                                        JSONObject ob = new JSONObject();

                                        ob.put("Count", count);
                                        ob.put("MemberNo", MemberNo);
                                        ob.put("MemberNAme", MemberNAme);
                                        ob.put("ContractNo", ContractNo);
                                        ob.put("loanAmount", decimalFormat.setAmount(loanAmount));
                                        ob.put("totalAmount", decimalFormat.setAmount(totalAmount));
                                        ob.put("totalPaid", decimalFormat.setAmount(totalPaid));
                                        ob.put("remaningAmount", decimalFormat.setAmount(remaningAmount));

                                        ja.put(ob);

                                    }

                                }

                            }

                        }

                    }
     }
                            
                        }
                        
                    }
                    out.write(ja.toString());
                    openSession.close();
                }

            } catch (Exception e) {

                out.write("" + e);
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
