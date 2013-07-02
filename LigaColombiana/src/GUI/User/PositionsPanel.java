package GUI.User;

import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

public class PositionsPanel extends JPanel{
    
    private final int WIDTH = 1000;
    private final int HEIGHT = 550;
    private JTable positionsTable;
    private JScrollPane scrollPane;
    private final int numberOfYears = 13;
    private String[] years;
    private String[] semesters = { "1", "2" };
    private JComboBox yearsComboBox;
    private JComboBox semestersComboBox;
    private String year, semester;
    private JButton update;
    
    public PositionsPanel( ){
        year = "2013";
        semester = "1";
        loadTable( );
        years = new String[numberOfYears];
        fillYears();
        yearsComboBox = new JComboBox( years );
        semestersComboBox = new JComboBox( semesters );
        yearsComboBox.addActionListener( new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JComboBox cb = (JComboBox)e.getSource( );
                year = (String)cb.getSelectedItem( );
            }
        } );
        
        semestersComboBox.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JComboBox cb = (JComboBox)e.getSource( );
                semester = (String)cb.getSelectedItem( );
            }
        } );
        yearsComboBox.setBounds( 20,0,70,25 );
        semestersComboBox.setBounds( 100,0,40,25 );
        update = new JButton( "Actualiza tabla de posiciones" );
        update.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                loadTable( );
            }
        } );
        update.setBounds( 160,0,200,25 );
        
        positionsTable.setPreferredScrollableViewportSize( new Dimension(WIDTH-20, HEIGHT-20) );
        positionsTable.setFillsViewportHeight(true);
        scrollPane = new JScrollPane(positionsTable);
        scrollPane.setBounds(0, 30, WIDTH, HEIGHT-20);
        
        setLayout(null);
        add( yearsComboBox );
        add( semestersComboBox );
        add( update );
        add( scrollPane );
        
        setLocation(0, 50);
        setSize(WIDTH-10, HEIGHT);
        setVisible(true);
    }
    
    private void loadTable( ){
        try {
            positionsTable = new JTable( ViewsPanel.data("posicion, nombre_equipo, puntaje, goles_favor, goles_contra",
                                              "tabla_de_posiciones","año="+year+" AND semestre="+semester), 
                                         ViewsPanel.columnNames("posicion, nombre_equipo, puntaje, goles_favor, goles_contra",
                                                     "tabla_de_posiciones","año="+year+" AND semestre="+semester) );
            DefaultTableModel dm = (DefaultTableModel)positionsTable.getModel();
            dm.fireTableDataChanged();
        } catch (SQLException ex) {
            Logger.getLogger(PositionsPanel.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private void fillYears(){
        for( int i = 2013; i>2013-numberOfYears; i-- ) 
            years[2013-i] = new String( String.valueOf(i) );
    }
}

class Games{
    
}