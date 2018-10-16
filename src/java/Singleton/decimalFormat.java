/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Singleton;

import java.text.DecimalFormat;

/**
 *
 * @author oditha
 */
public class decimalFormat {
    
    private static DecimalFormat dfAmount;
    private static DecimalFormat CenterID;
    private static DecimalFormat ContractNO;
    
    
    public static String setAmount(double amount){
    
        if (dfAmount == null) {

            dfAmount = new DecimalFormat(".00");
            
        }
        
        String format = dfAmount.format(amount);
    
        return format;
        
    }
    public static String setCenterID(int id){
    
        if (CenterID == null) {

            CenterID = new DecimalFormat("000");
            
        }
        
        String format = CenterID.format(id);
    
        return format;
        
    }
    
    public static String Contract(int id){
    
        if (ContractNO == null) {

            ContractNO = new DecimalFormat("00000000");
            
        }
        
        String format = ContractNO.format(id);
    
        return format;
        
    }
    
    
}
