package GUI;

import javax.swing.JFrame;

public class AdminFrame extends JFrame{
    
    private final int WIDTH = 800;
    private final int HEIGHT = 600;
    
    public AdminFrame( ){
        super( "Admin Frame" );
        
        
        
        setSize(WIDTH, HEIGHT);
        setResizable(false);
        setVisible(true);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
    
}
