import com.NeuroSky.ThinkGear.IO.*;
import com.NeuroSky.ThinkGear.Util.*;
import com.NeuroSky.Util.*;
import pt.citar.diablu.processing.mindset.*;

/*
 * Drone mind control
 * 
 * This sketch sends Serial values to an receiver  receiver 
 * 
 * The input is generated via a Neurosky MindSet Mobile headset
 * 
 * Created 21 March 2018
 * By Wesley Hartogs 
 * Communication and Multimedia Design
 * Avans University of Applied Sciences
 * 
 * 
 */

// import Serial libary
import processing.serial.*;

// Define receiver  Serial
Serial receiver ;

// Import MindSet libary
MindSet mindSet;

void setup() {

  size(150, 500);

  // Initiate Serial communication at COM10 
  receiver  = new Serial(this, "COM5", 9600  );

  // Initiate MindSet communication
  // The MindSet uses Bluetooth Serial communication, 
  // Check the COM-pot in the ThinkGear Connector in your Device Manager
  mindSet = new MindSet(this, "COM4");

  // Enable anti-aliassing
  smooth();

  // Set stroke properties
  strokeWeight(5);
  stroke(255);
  strokeCap(SQUARE);

  // Set line colour
  fill(255);
  
} // setup()


void draw()
{
  // Start with a black background
  background(0);

  // Draw horizontal line to at 40% from bottom
  // This line indicates the minimum (40%) attention needed
  line( 0, height*0.60, width, height*.60);

  // Draw a line from the horizontal center upwards
  // This line gives an indication of your attention
  // The height is mapped in reverse to get a percentage from top
  // Example: by 40% (0.4) attention the height value is (100 - 40) 60% (0.6) from top
  line( width*.5, height, width*.5, height*map( float( attentionLevel ) / 100, 0, 1, 1, 0 ) );

  if(attentionLevel<=20){
    receiver.write(0);
    
  }
  else if(attentionLevel<=40){

      receiver.write(45);

  }
  else if(attentionLevel<=60){
          println( attentionLevel);

      receiver.write(65);

  }

  else if(attentionLevel<=100){
      receiver.write(100);
                println( attentionLevel);


  }


}



// MindSet variables and functions
int signalStrenght = 0;
int attentionLevel = 0;

public void attentionEvent( int attentionLevel_val ) 
{
  attentionLevel = attentionLevel_val;
}

// This function is activated when the connection with the MindSet is not optimal
public void poorSignalEvent( int signalNoise ) 
{
  // MindSet is adjusting
  if ( signalNoise == 200 ) {
    println( "Mindset is not touching your skin!" );
  }

  // Map the signal strenght to a percentage
  signalStrenght = int( map( ( 200-signalNoise ), 200, 0, 100, 0 ) );
  println( "Signal strength: " + signalStrenght + "%" );
}
