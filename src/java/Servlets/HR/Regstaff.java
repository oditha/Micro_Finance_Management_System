/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.HR;

import ORM.Staff;

import Singleton.dateFormat;
import Singleton.decimalFormat;
import Srcs.PoolManager;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.HibernateError;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author iamarshrx
 */
@WebServlet(name = "Regstaff", urlPatterns = {"/Regstaff"})
public class Regstaff extends HttpServlet {

    HashMap<String, String> hm=new HashMap();
    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            PrintWriter out = response.getWriter();

            String nic = null;
            String licenceNo = null;
            String StaffName = null;
            String StaffNameinitials = null;
            String gender = null;
            String dob = null;
            String ad1 = null;
            String ad2 = null;
            String city = null;
            String Email = null;
            String contact1 = null;
            String contact2 = null;
            String position = null;
            String basic = null;
            String joiningdate = null;
            String etf = null;
            String epf = null;
            String image = null;

            int i = 1;

            String realpath = request.getServletContext().getRealPath("");

            //out.print(realpath);
            out.print(hm.get("nic"));
            String Folderpath = realpath + "/" + "images";
           // out.print(realpath);
            File file = new File(Folderpath);

            if (!file.exists()) {
                file.mkdir();
                //  out.print(Folderpath);
            }
            boolean isMultipart = ServletFileUpload.isMultipartContent(request);

            if (!isMultipart) {
                out.print("case paaram");
            } else {

                FileItemFactory filefactory = new DiskFileItemFactory();
                ServletFileUpload sfu = new ServletFileUpload(filefactory);

                List list = sfu.parseRequest(request);

                Iterator itlist = list.iterator();

                while (itlist.hasNext()) {

                    FileItem fileitem = (FileItem) itlist.next();

                    if (fileitem.isFormField()) {

                        if (fileitem.getFieldName().equals("nic")) {
                            nic = fileitem.getString();
                            
                            hm.put("nic", nic);
                             
                            
                        } else if (fileitem.getFieldName().equals("licenceNo")) {
                            licenceNo = fileitem.getString();
                        } else if (fileitem.getFieldName().equals("StaffName")) {
                            StaffName = fileitem.getString();
                        } else if (fileitem.getFieldName().equals("StaffNameinitials")) {
                            StaffNameinitials = fileitem.getString();
                        } else if (fileitem.getFieldName().equals("gender")) {
                            gender = fileitem.getString();
                        } else if (fileitem.getFieldName().equals("dob")) {
                            dob = fileitem.getString();
                        } else if (fileitem.getFieldName().equals("Address1")) {
                            ad1 = fileitem.getString();
                        } else if (fileitem.getFieldName().equals("Address2")) {
                            ad2 = fileitem.getString();
                        } else if (fileitem.getFieldName().equals("city")) {
                            city = fileitem.getString();
                        } else if (fileitem.getFieldName().equals("email")) {
                            Email = fileitem.getString();
                        } else if (fileitem.getFieldName().equals("contact1")) {
                            contact1 = fileitem.getString();
                        } else if (fileitem.getFieldName().equals("contact2")) {
                            contact2 = fileitem.getString();
                        } else if (fileitem.getFieldName().equals("position")) {
                            position = fileitem.getString();
                        } else if (fileitem.getFieldName().equals("basicSalary")) {
                            basic = fileitem.getString();
                        } else if (fileitem.getFieldName().equals("joiningDate")) {
                            joiningdate = fileitem.getString();
                        } else if (fileitem.getFieldName().equals("etf")) {
                            etf = fileitem.getString();
                        } else if (fileitem.getFieldName().equals("epf")) {
                            epf = fileitem.getString();
                        }
//                        
                    } else {

                        String itemname = fileitem.getName();

                        if (itemname.contains("/")) {

                            itemname.substring(itemname.lastIndexOf("/") + 1);

                        }

                        if (!itemname.contains(".jpg")) {
                            out.print("error in format");
                        } else {

                            if (!itemname.equals("")) {
                                File newfile = new File(Folderpath + "/" + itemname);

                                fileitem.write(newfile);

                                image =  itemname;
                                // out.print(newfile);

                            }

                        }

                    }

                }////////////////------------------------- end of while

//                try {
//                     Session sess = DB.getsession();
//                Transaction tr = sess.beginTransaction();
//
//                Staff s = new Staff();
//                s.setNic(nic);
//                s.setLicenceNo(licenceNo);
//                s.setName(StaffName);
//                s.setAddress1(ad1);
//                s.setAddress2(ad2);
//                s.setCity(city);
//                s.setContact1(contact1);
//                s.setContact2(contact2);
//                s.setBasicSalary(basic);
//                s.setEpfNo(epf);
//                s.setEtfNo(etf);
//                s.setDob(dob);
//                s.setJoiningDate(joiningdate);
//                s.setPosition(position);
//                s.setIsActive("1");
//                s.setCreatedby("");
//                s.setEmail(Email);
//                s.setGender(gender);
//                s.setPhoto(image);
//                s.setNameWithinitials(StaffNameinitials);
//
//                tr.commit();
//out.print(joiningdate);
//                if (tr.wasCommitted()) {
//                    out.print(tr.wasCommitted());
//                }
//                } catch (Exception e) {
//                    throw  new HibernateException(e);
//                }
            }

            try {
                Session sess =PoolManager.getSessionFactory().openSession();
                Transaction tr = sess.beginTransaction();
                HttpSession session = request.getSession();
                Staff s = new Staff();
                s.setNic(nic);
                s.setLicenceNo(licenceNo);
                s.setName(StaffName);
                s.setAddress1(ad1);
                s.setAddress2(ad2);
                s.setCity(city);
                s.setContact1(contact1);
                s.setContact2(contact2);
                s.setBasicSalary(decimalFormat.setAmount(Double.parseDouble(basic)));
                s.setEpfNo(epf);
                s.setEtfNo(etf);
                s.setDob(dateFormat.setDateFull(dob));
                s.setJoiningDate(dateFormat.setDateFull(joiningdate));
                s.setPosition(position);
                s.setIsActive("Active");
                s.setCreatedby(session.getAttribute("userName").toString());
                s.setEmail(Email);
                s.setGender(gender);
                s.setPhoto(image);
                s.setNameWithinitials(StaffNameinitials);

                
                sess.save(s);
                
                tr.commit();
                out.print(joiningdate);
                if (tr.wasCommitted()) {
                    response.sendRedirect("HR/AddregStaff.jsp?status=success");
                }else{
                
                
                
                
                
                }
                    sess.close();
            } catch (Exception e) {
                throw new HibernateException(e);
            }

        } catch (Exception e) {
            throw new ServletException();
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
