package Singleton;


import java.awt.Toolkit;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;

public class DBJasper {

    private static Connection c;

    private static void createNewConnection() throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        c = DriverManager.getConnection("jdbc:mysql://localhost:3306/microcredit", "root", "*222*odk*");
    }

    public static void idu(String sql) throws Exception {
        if (c == null) {
            createNewConnection();
        }
        c.createStatement().executeUpdate(sql);
//        showNotification();
//        JOptionPane.showMessageDialog(null, "Sucess", "Done", JRootPane.INFORMATION_DIALOG);

    }

    public static ResultSet search(String sql) throws Exception {
        if (c == null) {
            createNewConnection();
        }
        return c.createStatement().executeQuery(sql);
    }

    public static Connection getCon() throws Exception {
        if (c == null) {
            createNewConnection();
        }
        return c;
    }

    private static void playnotification() {
        final Runnable runnable = (Runnable) Toolkit.getDefaultToolkit().getDesktopProperty("win.sound.exclamation");
        if (runnable != null) {
            runnable.run();
        }
    }

//    private static void showNotification() throws AWTException, MalformedURLException {
//        notificationSaveDone nsd = new notificationSaveDone();
//        nsd.displayTray();
//        return;
//    }
}
