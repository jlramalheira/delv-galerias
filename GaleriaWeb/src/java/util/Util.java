package util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Util {
    private static SimpleDateFormat formatador = new SimpleDateFormat("dd/MM/yyyy");

    public static Date StringToDate(String s){
        try {
            return formatador.parse(s);
        } catch (ParseException ex) {
            Logger.getLogger(Util.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public static String DateToString(Date d){
        return formatador.format(d);
    }
   

}
