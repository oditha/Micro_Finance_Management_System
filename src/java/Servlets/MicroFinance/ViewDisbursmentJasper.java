package Servlets.MicroFinance;

import Holders.DisbrustmentHolder;
import ORM.Center;
import ORM.CenterHasStaff;
import ORM.Loan;
import ORM.Members;

import Singleton.dateFormat;
import Singleton.decimalFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
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

@WebServlet(name = "ViewDisbursmentJasper", urlPatterns = {"/ViewDisbursmentJasper"})
public class ViewDisbursmentJasper extends HttpServlet {

public static List<DisbrustmentHolder> holder = new ArrayList<>();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {

                holder.clear();
                String date = request.getParameter("dates");
                String executiveid = request.getParameter("stfid");
                System.out.println(executiveid);
                String exe = request.getParameter("exe");
                Session openSession = PoolManager.getSessionFactory().openSession();
                Criteria createCriteria = openSession.createCriteria(Center.class);

                double total = 0;
                double memfee = 0;

                DisbrustmentHolder dis1 = new DisbrustmentHolder();
                dis1.setCenter("");
                dis1.setContractno("");
                dis1.setExecutive(exe);
                dis1.setFee("");
                dis1.setIndex("");
                dis1.setInstallment("");
                dis1.setLoan("");
                dis1.setMemname("");
                dis1.setMemno("");
                dis1.setNic("");
                dis1.setTotalfee(decimalFormat.setAmount(memfee));
                dis1.setTotalloan(decimalFormat.setAmount(total));
                dis1.setContact("");

                holder.add(dis1);

                List<Center> list = createCriteria.list();

                for (Center cen : list) {

                    Iterator it = cen.getCenterHasStaffs().iterator();

                    while (it.hasNext()) {
                        CenterHasStaff next = (CenterHasStaff) it.next();

                        if (next.getStaff().getIdStaff() == Integer.parseInt(executiveid)) {

                            Set memberses = cen.getMemberses();
                            Iterator iterator = memberses.iterator();
                            while (iterator.hasNext()) {

                                Members mem = (Members) iterator.next();
                                if (mem.getAproved().equals("Approve") && mem.getIsActive().equals("Active")) {

                                    Set loans = mem.getLoans();
                                    Iterator iterator1 = loans.iterator();
                                    while (iterator1.hasNext()) {

                                        Loan loan = (Loan) iterator1.next();
                                        System.out.println("ISACTIVEBB " + loan.getIsActive());
                                        System.out.println("ISAPPROVEBB " + loan.getIsAprove());
                                        if (loan.getIssueDate().equals(dateFormat.setDateFull(date)) & loan.getIsAprove().equals("Approve") & loan.getIsActive().equals("Active")) {
                                            System.out.println("ISACTIVE " + loan.getIsActive());
                                            System.out.println("ISAPPROVE " + loan.getIsAprove());
                                            total += loan.getLoanAmount();
                                            memfee += Double.parseDouble(loan.getMemberfee());

                                            DisbrustmentHolder dis = new DisbrustmentHolder();
                                            dis.setCenter(loan.getMembers().getCenter().getCenterName());
                                            dis.setContractno(loan.getContractNo());
                                            dis.setExecutive(exe);
                                            dis.setFee(decimalFormat.setAmount(Double.parseDouble(loan.getMemberfee())));
                                            dis.setIndex(loan.getLoanIndex());
                                            dis.setInstallment(decimalFormat.setAmount(loan.getLoanInstallment()));
                                            dis.setLoan(decimalFormat.setAmount(loan.getLoanAmount()));
                                            dis.setMemname(loan.getMembers().getNameWithInitials());
                                            dis.setMemno(loan.getMembers().getMemberNo());
                                            dis.setNic(loan.getMembers().getNic());
                                            dis.setTotalfee(decimalFormat.setAmount(memfee));
                                            dis.setTotalloan(decimalFormat.setAmount(total));
                                            dis.setContact(loan.getMembers().getContactNo());

                                            holder.add(dis);

                                        }

                                    }
                                }

                            }
                        }

                    }
                }
                
//                Collections.sort(holder, (DisbrustmentHolder o1, DisbrustmentHolder o2) -> {
//                    return o1.getMemno().compareTo(o2.getMemno());
//                });
                
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
