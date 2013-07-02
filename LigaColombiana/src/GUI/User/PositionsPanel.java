package GUI.User;

import java.awt.Dimension;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;

public class PositionsPanel extends JPanel{
    
    private final int WIDTH = 1000;
    private final int HEIGHT = 600;
    private JTable positionsTable;
    private JScrollPane scrollPane;
    
    public PositionsPanel( String año, String semestre ){
        try {
            positionsTable = new JTable( ViewsPanel.data("posicion, nombre_equipo, puntaje, goles_favor, goles_contra",
                                                          "tabla_de_posiciones","año="+año+" AND semestre="+semestre), 
                                         ViewsPanel.columnNames("posicion, nombre_equipo, puntaje, goles_favor, goles_contra",
                                                                "tabla_de_posiciones","año="+año+" AND semestre="+semestre) );
        } catch (SQLException ex) {
            Logger.getLogger(PositionsPanel.class.getName()).log(Level.SEVERE, null, ex);
        }
        positionsTable.setPreferredScrollableViewportSize( new Dimension(WIDTH-20, HEIGHT-20) );
        positionsTable.setFillsViewportHeight(true);
        scrollPane = new JScrollPane(positionsTable);
        scrollPane.setBounds(0, 0, WIDTH, HEIGHT-20);
        
        setLayout(null);
        add( scrollPane );
        
        setLocation(0, 50);
        setSize(WIDTH, HEIGHT);
        setVisible(true);
    }
}
