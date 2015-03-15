

import processing.serial.*;

Serial myPort;  // Create object from Serial class
int i =0;
void setup() 
{
  size(200,200); //make our canvas 200 x 200 pixels big
  
  println("Serial Ports:");
  println(Serial.list());
  
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
}

void draw() {
 
  myPort.write(i);  
  i=(i+8)%1024;

 // println(i);
  
}
