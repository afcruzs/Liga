package GUI;

import GUI.User.*;
import javax.swing.JFrame;

public class UserFrame extends JFrame{
    
    private final int WIDTH = 1000;
    private final int HEIGHT = 600;
    private ViewsPanel views;
    
    public UserFrame( ){
        super( "User Frame" );
        
        views = new ViewsPanel( );
        
        add( views );
        
        setSize(WIDTH, HEIGHT);
        setResizable(false);
        setVisible(true);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
    
}
