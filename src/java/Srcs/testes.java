/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Srcs;

import Singleton.dateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;

/**
 *
 * @author arshak
 */
public class testes {
   
    static int count = 0;
    public static void main(String[] args) throws ParseException {
        
        Date parse = new SimpleDateFormat("dd/MM/yyyy").parse("10/11/1992");
        System.out.println(parse);
    }
    
}
