package GUI;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPasswordField;
import javax.swing.UIManager;


public class InitialFrame extends JFrame implements ActionListener {
    
    private final int WIDTH = 350;
    private final int HEIGHT = 400;
    private JLabel userLabel, passLabel, imageLabel;
    private JButton acceptButton;
    private JComboBox usersComboBox;
    private String[] usersString = { "Admin", "Usuario" };
    private JPasswordField passwordField;
    private char[] adminPassword = { '1','2','3','4' };
    
    public InitialFrame( ){
        super( "Liga Colombiana" );
        JDialog.setDefaultLookAndFeelDecorated(true);
        try { UIManager.setLookAndFeel("javax.swing.plaf.nimbus.NimbusLookAndFeel"); } 
        catch (Exception ex) { Logger.getLogger(InitialFrame.class.getName()).log(Level.SEVERE, null, ex); }
        
        imageLabel = new JLabel( new ImageIcon("images/image1.png") );
        userLabel = new JLabel( "Seleccione el usuario" );
        passLabel = new JLabel( "Ingrese la contraseña" );
        usersComboBox = new JComboBox<>( usersString );
        passwordField = new JPasswordField();
        acceptButton = new JButton( "Aceptar" );
        
        imageLabel.setBounds( 20, 20, 300, 175 );
        userLabel.setBounds( 40, 200, 260, 25 );
        usersComboBox.setSelectedIndex( 0 );
        usersComboBox.addActionListener( this );
        usersComboBox.setBounds( 40, 220, 260, 25 );
        passLabel.setBounds( 40, 260, 260, 25 );
        passwordField.setBounds( 40, 280, 260, 25 );
        acceptButton.setBounds( 40, 320, 260, 40 );
        acceptButton.addActionListener( new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if( usersComboBox.getSelectedIndex() == 0 )
                    acceptEvent( passwordField.getPassword() );
                else
                    acceptEvent( ); 
            }
        } );
        
        setLayout(null);
        add( imageLabel );
        add( userLabel );
        add( usersComboBox );
        add( passLabel );
        add( passwordField );
        add( acceptButton );
        
        setSize(WIDTH, HEIGHT);
        setResizable(false);
        setVisible(true);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocation(400, 100);
    }

    private void acceptEvent( char[] password ){
        if( Arrays.equals( password, adminPassword ) ){
            dispose();
            new UserFrame();
            new AdminFrame();
        } else
            JOptionPane.showMessageDialog( null, "Contraseña incorrecta, intente de nuevo",
					"Contraseña incorrecta", JOptionPane.ERROR_MESSAGE);
    }
    
    private void acceptEvent(){
        dispose();
        new UserFrame();
    } 
    
    @Override
    public void actionPerformed(ActionEvent e) {
        if( usersComboBox.getSelectedIndex() == 1 )
            passwordField.setEnabled(false);
        else
            passwordField.setEnabled(true);
    }
    
}
