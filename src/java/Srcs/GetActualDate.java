/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Srcs;

import Singleton.dateFormat;
import java.text.ParseException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.joda.time.DateTime;
import org.joda.time.Weeks;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.joda.time.format.ISODateTimeFormat;

/**
 *
 * @author Danushka
 */
public class GetActualDate {

    public static List ActualDays(String day, String Name, int size) throws ParseException {

        String date = day;
        String[] split = date.split("/");
        int year = Integer.parseInt(split[2]);
        int mont = Integer.parseInt(split[1]);
        int days = Integer.parseInt(split[0]);

        ArrayList<String> al = new ArrayList<String>();

        LocalDate nextWed = LocalDate.of(year, mont, days).with(TemporalAdjusters.next(DayOfWeek.valueOf(Name.toUpperCase())));

        String StartDate = nextWed.toString();
        
        
          if (StartDate.startsWith("+8")) {
            
            StartDate=StartDate.split("\\+8")[1];
            
            
            
        }

        String startDate = dateFormat.setDateFull(StartDate);
        al.add(startDate);
        DateTimeFormatter forPattern = DateTimeFormat.forPattern("dd/MM/yyyy");

       DateTime st = forPattern.parseDateTime(startDate);
        DateTime plusDays = null;
        for (int i = 0; i < size - 1; i++) {

            plusDays = st.plusDays(7);
            st = plusDays;
            String print = forPattern.print(plusDays);
            al.add(print);
        }

        return al;

    }

    
}
