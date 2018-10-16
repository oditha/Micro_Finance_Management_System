/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets.MicroFinance;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

/**
 *
 * @author arshak
 */



public class tst extends HttpServlet{
    
    static int count = 0;
    public static void main(String[] args) {
        for (int i = 0; i < 10; i++) {
            
            count++;
            
        }
        System.out.println(count);
    }
    
    
}
