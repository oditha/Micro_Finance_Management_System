package Servlets.Executive;

import Servlets.MicroFinance.*;
import ORM.Center;
import ORM.Members;

import Singleton.dateFormat;
import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.TreeSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;

@WebServlet(name = "AddMemberServletEXE", urlPatterns = {"/AddMemberServletEXE"})
public class AddMemberServletEXE extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {

               String user = request.getSession().getAttribute("userName").toString();

                String center = request.getParameter("center");
                String memberid = request.getParameter("memberid");
                String group = request.getParameter("group");
                String nic = request.getParameter("NIC");
                String namein = request.getParameter("namein");
                String fullname = request.getParameter("fullname");
                String dob = request.getParameter("dob");
                String contact = request.getParameter("contact");
                String add1 = request.getParameter("address1");
                String add2 = request.getParameter("address2");
                String city = request.getParameter("city");
                String gnic = request.getParameter("gNIC");
                String gname = request.getParameter("gname");
                String gdob = request.getParameter("gdob");
                String gocc = request.getParameter("gocc");
                String NO = request.getParameter("NO");

                Session session = PoolManager.getSessionFactory().openSession();
                Transaction beginTransaction = session.beginTransaction();

                Center center1 = new Center();
                center1.setIdCenter(Integer.parseInt(center));

                Members members = new Members();

                members.setMemberNo(memberid);
                members.setNic(nic);
                members.setNameWithInitials(namein);
                members.setFullName(fullname);
                members.setGroupId(group);
                members.setDob(dateFormat.setDateFull(dob));
                members.setContactNo(contact);
                members.setAddress1(add1);
                members.setAddress2(add2);
                members.setCity(city);
                members.setHusbandNic(gnic);
                members.setHusbandName(gname);
                members.setHusbandDob(dateFormat.setDateFull(gdob));
                members.setHusbandjob(gocc);
                members.setIsActive("Active");
                members.setAproved("Approve");
                members.setCreatedBy(user);
                members.setCenter(center1);

                session.save(members);
                beginTransaction.commit();
                session.close();
                TreeSet get = GenMemberIDServlet.map.get(NO);
                Integer last = (Integer) get.last();
                last++;
                get.add(last);

                response.sendRedirect("Executive/addMember.jsp?save=done");
//                session.close();
            } catch (Exception e) {

                response.sendRedirect("Executive/addMember.jsp?save=error");
                //System.out.println(e);
                e.printStackTrace();

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
