package GUI.User;

import Logic.Main;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Vector;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class ViewsPanel extends JPanel implements ActionListener{
    
    private JPanel view;
    private JLabel actionLabel;
    private JComboBox viewsComboBox;
    private String[] viewsList = { "Tabla de posiciones", 
                                   "Otra",
                                   "Y otra" };
    
    public ViewsPanel( ){
        actionLabel = new JLabel( "Seleccione una accion" );
        actionLabel.setBounds(20,0,200,25);
        viewsComboBox = new JComboBox<>( viewsList );
        viewsComboBox.addActionListener(this);
        viewsComboBox.setSelectedIndex(0);
        viewsComboBox.setBounds(20,20,200,25);
        view = new PositionsPanel("2013", "1");
        
        setLayout(null);
        add( actionLabel ); 
        add( viewsComboBox );
        add( view );
        
        setVisible(true);
        setLocation(0,0);
        setSize(1000,30);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        JComboBox cb = (JComboBox)e.getSource( );
    }
    
    public static Vector columnNames( String columns, String table ) throws SQLException {
        ResultSet tabla = Main.app.instruccion.executeQuery( "SELECT " + columns + " FROM " + table + ";" );
        ResultSetMetaData metaDatos = tabla.getMetaData( );
        int size = metaDatos.getColumnCount( );
        Vector<String> names = new Vector<String>( );
        for( int i = 1; i <= size; i++)
            names.add( metaDatos.getColumnName( i ) );
        return names;
    }
    
    public static Vector data( String columns, String table ) throws SQLException {
        ResultSet tabla = Main.app.instruccion.executeQuery( "SELECT " + columns + " FROM " + table + ";" );
        ResultSetMetaData metaDatos = tabla.getMetaData( );
        int size = metaDatos.getColumnCount( );
        Vector<Vector> data = new Vector<Vector>( );
        while( tabla.next() )
        {
            Vector temp = new Vector( );
            for( int j = 1; j <= size; j++ )
                temp.add( tabla.getObject( j ) );
            data.add( temp );
        }
        return data;
    }
    
    public static Vector columnNames( String columns, String table, String condition ) throws SQLException {
        System.out.println("SELECT " + columns + " FROM " + table + 
                           " WHERE " + condition + ";");
        ResultSet tabla = Main.app.instruccion.executeQuery( "SELECT " + columns + " FROM " + table + 
                                                             " WHERE " + condition + ";" );
        ResultSetMetaData metaDatos = tabla.getMetaData( );
        int size = metaDatos.getColumnCount( );
        Vector<String> names = new Vector<String>( );
        for( int i = 1; i <= size; i++)
            names.add( metaDatos.getColumnName( i ) );
        return names;
    }
    
    public static Vector data( String columns, String table, String condition ) throws SQLException {
        System.out.println("SELECT " + columns + " FROM " + table + 
                           " WHERE " + condition + ";");
        ResultSet tabla = Main.app.instruccion.executeQuery( "SELECT " + columns + " FROM " + table + 
                                                             " WHERE " + condition + ";" );
        ResultSetMetaData metaDatos = tabla.getMetaData( );
        int size = metaDatos.getColumnCount( );
        Vector<Vector> data = new Vector<Vector>( );
        while( tabla.next() )
        {
            Vector temp = new Vector( );
            for( int j = 1; j <= size; j++ )
                temp.add( tabla.getObject( j ) );
            data.add( temp );
        }
        return data;
    }
}
