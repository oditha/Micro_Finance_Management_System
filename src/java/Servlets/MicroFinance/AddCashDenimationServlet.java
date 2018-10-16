package Servlets.MicroFinance;

import ORM.Denimation;
import ORM.Denimationcah;
import ORM.Staff;

import Singleton.dateFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;

@WebServlet(name = "AddCashDenimationServlet", urlPatterns = {"/AddCashDenimationServlet"})
public class AddCashDenimationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {

                String Date = request.getParameter("Rday");
                String ExchangeCash = request.getParameter("ExchangeCash");
                String CenterCollection = request.getParameter("CenterCollection");
                String NPCollection = request.getParameter("npCollection");
                String MemberFee = request.getParameter("MemberFees");
                String IncomeAmount = request.getParameter("TotalAmount");
                String TotalLoanAmount = request.getParameter("TotalLoan");
                String Expences = request.getParameter("Expenses");
                String TotalBalance = request.getParameter("TotalAmount1");
                String Short = request.getParameter("Short");
                String Extras = request.getParameter("Exsas");
                String ShortAndExtraBalance = request.getParameter("Balance");
                String note5000 = request.getParameter("example-5000");
                String note2000 = request.getParameter("example-2000");
                String note1000 = request.getParameter("example-1000");
                String note500 = request.getParameter("example-500");
                String note100 = request.getParameter("example-100");
                String note50 = request.getParameter("example-50");
                String note20 = request.getParameter("example-20");
                String note10 = request.getParameter("example-10");
                String coins = request.getParameter("example-Coins");
                String NoteTotal = request.getParameter("example-Total");
                String idStaff = request.getParameter("idStaff");

                Session session = PoolManager.getSessionFactory().openSession();
                Transaction beginTransaction = session.beginTransaction();

                Staff staff = new Staff();
                staff.setIdStaff(Integer.parseInt(idStaff));

                Denimation denimation = new Denimation();
                denimation.setDate(dateFormat.setDateFull(Date));
                denimation.setExchangeCash(Double.parseDouble(ExchangeCash));
                denimation.setCenterCollection(Double.parseDouble(CenterCollection));
                denimation.setNpcollection(Double.parseDouble(NPCollection));
                denimation.setMemberFee(Double.parseDouble(MemberFee));
                denimation.setIncomeAmount(Double.parseDouble(IncomeAmount));
                denimation.setTotalLoanAmount(Double.parseDouble(TotalLoanAmount));
                denimation.setExpences(Double.parseDouble(Expences));
                denimation.setTotalBalance(Double.parseDouble(TotalBalance));
                denimation.setShort_(Double.parseDouble(Short));
                denimation.setExtras(Double.parseDouble(Extras));
                denimation.setShortAndExtraBalance(Double.parseDouble(ShortAndExtraBalance));
                denimation.setStaff(staff);

                session.save(denimation);

                Denimationcah dc = new Denimationcah();
                dc.setN5000(Integer.parseInt(note5000));
                dc.setN2000(Integer.parseInt(note2000));
                dc.setN1000(Integer.parseInt(note1000));
                dc.setN500(Integer.parseInt(note500));
                dc.setN100(Integer.parseInt(note100));
                dc.setN50(Integer.parseInt(note50));
                dc.setN20(Integer.parseInt(note20));
                dc.setN10(Integer.parseInt(note10));
                dc.setCoins(Double.parseDouble(coins));
                dc.setTotal(Double.parseDouble(NoteTotal));
                dc.setDenimation(denimation);

                denimation.getDenimationcahs().add(dc);
                session.save(dc);

                beginTransaction.commit();

                session.close();
                out.write("done");
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
