/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.MicroFinance;

import ORM.Denimation;
import ORM.Denimationcah;
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
import org.hibernate.annotations.SourceType;
import org.hibernate.criterion.Restrictions;
import org.hibernate.sql.JoinType;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author arshak
 */
@WebServlet(name = "ViewCashDenimation", urlPatterns = {"/ViewCashDenimation"})
public class ViewCashDenimation extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            PrintWriter out = response.getWriter();
            String date0 = request.getParameter("date");
            String idStaff = request.getParameter("idStaff");
            int id = Integer.parseInt(idStaff);
          // out.write("iyg" + idStaff);

            try {
                Session sess = PoolManager.getSessionFactory().openSession();
                Criteria cr = sess.createCriteria(Staff.class);
                cr.add(Restrictions.eq("idStaff", id));
                
                Staff staff = (Staff) cr.uniqueResult();
                
             //   List<Staff> list = cr.list();
                JSONArray arr = new JSONArray();
//            

                if (staff!=null) {

                    System.out.println(staff.getName());

                   // out.write(staff.getNic());
                    
                    
                    JSONObject jo = new JSONObject();
                    Iterator iterator = staff.getDenimations().iterator();

                    while (iterator.hasNext()) {
                        Denimation denimation = (Denimation) iterator.next();

                        
                        
                        if (denimation.getDate().equals(dateFormat.setDateFull(date0))) {

                            jo.put("ExchangeCash", denimation.getExchangeCash());
                            jo.put("TotalLoanAmount", denimation.getTotalLoanAmount());
                            jo.put("Short", denimation.getShort_());
                            jo.put("CenterCollection", denimation.getCenterCollection());
                            jo.put("Expences", denimation.getExpences());
                            jo.put("Exas", denimation.getExtras());
                            jo.put("MemberFee", denimation.getMemberFee());
                            jo.put("npcollection", denimation.getNpcollection());
                            jo.put("IncomeAmount", denimation.getIncomeAmount());
                            //jo.put("Expence", denimation.getIncomeAmount());
                            jo.put("TotalhortExtras", denimation.getShortAndExtraBalance());

                            Iterator it2 = denimation.getDenimationcahs().iterator();

                            while (it2.hasNext()) {
                              
                                
                                
                                Denimationcah dc = (Denimationcah) it2.next();
                                jo.put("N5000", dc.getN5000());
                                jo.put("N2000", dc.getN2000());
                                jo.put("N1000", dc.getN1000());
                                jo.put("N500", dc.getN500());
                                jo.put("N100", dc.getN100());
                                jo.put("N50", dc.getN50());
                                jo.put("N20", dc.getN20());
                                jo.put("N10", dc.getN10());
                                jo.put("NCoins", dc.getCoins());
                                jo.put("Ntotal", dc.getTotal());
                                //   jo.put("Ntotal", dc.);

                            }

                            arr.put(jo);

                        }

                    }

                }

                sess.close();
                out.write(arr.toString());
            } catch (Exception e) {

                e.printStackTrace();

            }

        } catch (Exception e) {

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
