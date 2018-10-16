package Singleton;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

public class dateFormat {

    private static SimpleDateFormat sdfYear;
    private static SimpleDateFormat sdfFull;
    private static SimpleDateFormat sdfCS;
    private static SimpleDateFormat day;
    private static SimpleDateFormat day1;
    private static SimpleDateFormat dateYY;
    public static SimpleDateFormat sdfCM;
    public static SimpleDateFormat sdct;
    public static SimpleDateFormat forContract;
    public static SimpleDateFormat parseDate;

    public static String YearOnly() {

        if (sdfYear == null) {

            sdfYear = new SimpleDateFormat("yyyy");

        }

        return sdfYear.format(new Date());

    }

    public static String parseDate(String Date) {

        Date date = null;
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("EEEE");

        try {
            if (sdfYear == null) {

                sdfYear = new SimpleDateFormat("dd/MM/yyyy");

            }

            date = sdfYear.parse(Date);
            simpleDateFormat.format(date);
        } catch (ParseException ex) {
            Logger.getLogger(dateFormat.class.getName()).log(Level.SEVERE, null, ex);
        }

        return simpleDateFormat.format(date);
    }

    public static String ContractNo() {

        if (forContract == null) {

            forContract = new SimpleDateFormat("yyyyMMdd");

        }

        return forContract.format(new Date());

    }

    public static String MonthOnly() {

        if (sdfCM == null) {

            sdfCM = new SimpleDateFormat("MM/yyyy");

        }

        return sdfCM.format(new Date());

    }

    public static String DateFullCurrent() {

        if (sdfFull == null) {

            sdfFull = new SimpleDateFormat("dd/MM/yyyy");

        }

        return sdfFull.format(new Date());

    }

    public static String setDateFull(String Date) throws ParseException {

        if (sdfCS == null) {

            sdfCS = new SimpleDateFormat("dd/MM/yyyy");

        }

        if (dateYY == null) {

            dateYY = new SimpleDateFormat("yyyy-MM-dd");

        }

        Date parse = dateYY.parse(Date);

        return sdfCS.format(parse);

    }

    public static String DayOnly() {

        if (day == null) {

            day = new SimpleDateFormat("EEEE");

        }

        return day.format(new Date());

    }

    public static String TimeCurrent() {

        if (sdct == null) {

            sdct = new SimpleDateFormat("hh:mm:ss aaa");

        }

        return sdct.format(new Date());

    }

    public static String DayOnlyString(String date) throws ParseException {

        if (day1 == null) {

            day1 = new SimpleDateFormat("EEEE");

        }

        Date parse = new SimpleDateFormat("dd/MM/yyyy").parse(date);

        return day1.format(parse);

    }

}
