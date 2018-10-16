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
import java.time.Month;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.time.temporal.TemporalAdjusters;
import java.util.Date;
import org.joda.time.DateTime;
import org.joda.time.Weeks;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

/**
 *
 * @author Danushka
 */
public class WeeksCount {

    public static int weeksCount(String day, String Name) throws ParseException {

        String date = day;
        String[] split = date.split("/");
        int year = Integer.parseInt(split[2]);
        int mont = Integer.parseInt(split[1]);
        int days = Integer.parseInt(split[0]);

        LocalDate nextWed = LocalDate.of(year, mont, days).with(TemporalAdjusters.next(DayOfWeek.valueOf(Name.toUpperCase())));

        //System.out.println(nextWed);
        String StartDate = nextWed.toString();

//        Jan 19
        if (StartDate.startsWith("+8")) {

            StartDate = StartDate.split("\\+8")[1];

        }

        //System.out.println(StartDate);
        String setDateFull = dateFormat.setDateFull(StartDate);

        String DateFullCurrent = dateFormat.DateFullCurrent();

        DateTimeFormatter forPattern = DateTimeFormat.forPattern("dd/MM/yyyy");

        DateTime st = forPattern.parseDateTime(setDateFull);
        DateTime ed = forPattern.parseDateTime(DateFullCurrent);
        DateTime cut = forPattern.parseDateTime("15/04/2018");
        DateTime issue = forPattern.parseDateTime(date);

        int weeks = Weeks.weeksBetween(st, ed).getWeeks();
        if (st.isBefore(cut)) {

            weeks = weeks;
            System.out.println("Before April 15 " + weeks);

        } else {

            System.out.println("after April 15 " + weeks);
            weeks = weeks + 1;

        }
        return weeks;

    }

    public static void main(String[] args) throws ParseException {
        System.out.println();
    }

}
