#define PIN 3
int val;


void setup() {
  // put your setup code here, to run once:
   Serial.begin(9600); // Start serial communication at 9600 bps

}

void loop() {
  unsigned int value;
  // Read Serial
  if (Serial.available()) 
   { // If data is available to read,
     val = Serial.read(); // read it and store it in val
   }

    value = map(val, 0, 100, 0, 255);
    
    analogWrite(3, value);   


   
  
}
