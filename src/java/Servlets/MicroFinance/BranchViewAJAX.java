package Servlets.MicroFinance;

import ORM.Branch;

import Srcs.PoolManager;
import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet(name = "BranchViewAJAX", urlPatterns = {"/BranchViewAJAX"})
public class BranchViewAJAX extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {
                System.out.println("BNO " + request.getParameter("branchID"));

                Session session = PoolManager.getSessionFactory().openSession();
                Criteria createCriteria = session.createCriteria(Branch.class);
                createCriteria.add(Restrictions.eq("idBranch", Integer.parseInt(request.getParameter("branchID"))));

                Branch uniqueResult = (Branch) createCriteria.uniqueResult();

                if (uniqueResult != null) {

                    JSONArray jsonArray = new JSONArray();
                    JSONObject jo = new JSONObject();
                    
                    jo.put("bid", uniqueResult.getIdBranch());
                    jo.put("bno", uniqueResult.getBranchNo());
                    jo.put("bname", uniqueResult.getBranchName());
                    jo.put("bad1", uniqueResult.getAddress1());
                    jo.put("bad2", uniqueResult.getAddress2());
                    jo.put("bct", uniqueResult.getCity());
                    jo.put("bco1", uniqueResult.getContact1());
                    jo.put("bco2", uniqueResult.getContact2());
                    
                    jsonArray.put(jo);
                    
                    System.out.println(jsonArray.toString());
                    
                    out.write(jsonArray.toString());

                }
                session.close();
            } catch (Exception e) {
                
                e.printStackTrace();
                
            }

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

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
