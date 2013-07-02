package Logic;

import GUI.InitialFrame;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class Program {
    
    private static final String BD = new String( "LigaColombiana" );
    public Connection connection;
    private String user = "root";
    private String password = "1234"; 
    public Statement instruccion;
    
    public Program() {
        try {
            System.out.println("Intentando cargar el conector");
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("Conectando a la Base de Datos");
            connection = DriverManager.getConnection(
                    "jdbc:mysql://localhost/"+BD+"?user="+user+"&password="+password);
            System.out.println("Conexion a BD establecida");
            instruccion =  connection.createStatement();
            
            new InitialFrame();
        }
        catch (Exception e) {
            System.err.println(e);
       }
    }

    public void closeConnection( )
    {
        try {
            connection.close();
            System.out.println("Cerrar conexion con JDBC ... OK");
            } catch (SQLException ex) {
            System.out.println("Imposible cerrar conexion ... FAIL");
        }
    }
}
