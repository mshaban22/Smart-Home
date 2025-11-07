#include <SPI.h>
#include <Wire.h>
#include <DHT.h>
#include <SoftwareSerial.h>
#include <Servo.h>

Servo Servo1;

#define DHTPIN 2          // Digital pin 2
#define DHTTYPE DHT11     // DHT 11
#define smoke A5
#define fanPin 5
#define servoPin 6
String quality = ""; 
String smokeConcentration = "";
DHT dht(DHTPIN, DHTTYPE);

void setup() {
  Serial.begin(9600);
  pinMode(A0, INPUT);
  dht.begin();
    pinMode(5, OUTPUT);
  Servo1.attach(servoPin);

}

void loop() {
   unsigned int sensorValue = analogRead(smoke);  // Read the analog value from sensor

   double outputValue = map(sensorValue, 0, 1023, 0, 255); // map the 10-bit data to 8-bit data

float humd = dht.readHumidity();         // Read humidity value
float temp = dht.readTemperature();  
float gasLevel = analogRead(A0);

float gasLevelm= analogRead(A0)/100;
float outputValuem = map(sensorValue, 0, 1023, 0, 255)/100; // map the 10-bit data to 8-bit data

  if (gasLevel < 181) {
    quality = "GOOD!";
  } else if (gasLevel > 181 && gasLevel < 225) {
    quality = "Poor!";
  } else if (gasLevel > 225 && gasLevel < 300) {
    quality = "Very bad!";
  } else if (gasLevel > 300 && gasLevel < 350) {
    quality = "ur dead!";
  } else {
    quality = "Toxic";   
  }


if (outputValue < 30){
  smokeConcentration = "Low";
  }
 else if(outputValue>30 && outputValue<65){
    smokeConcentration = "Moderate";
}
else if(outputValue > 65){
  smokeConcentration = "High";
}
  // Serial.print("Air Quality: ");
  // Serial.println(quality);  
  // Serial.print("Gas level: ");
  // Serial.println(gasLevel);
  // Serial.print("Humidity: ");
  // Serial.println("%");
  // Serial.print("smoke output: ");
  // Serial.println(sensorValue);
  

//___________________________________________________________________________________________________________________________________
//  fucking part of mobile app, no one fuck it please.
Serial.write('r');

      Serial.write(static_cast<byte>(static_cast<int>(temp)));
      Serial.write(static_cast<byte>(static_cast<int>((temp - static_cast<int>(temp)) * 100))); 

      Serial.write(static_cast<byte>(static_cast<int>(humd)));
      Serial.write(static_cast<byte>(static_cast<int>((humd - static_cast<int>(humd)) * 100))); 

      Serial.write(static_cast<byte>(static_cast<int>(gasLevel)));
      Serial.write(static_cast<byte>(static_cast<int>((gasLevel - static_cast<int>(gasLevelm)) * 100))); 

      Serial.write(static_cast<byte>(static_cast<int>(outputValue)));
      Serial.write(static_cast<byte>(static_cast<int>((outputValue - static_cast<int>(outputValuem)) * 100))); 
//__________________________________________________________________________________________________________________________________



 Serial.println("____________");
  delay(500);  // Delay to slow down the data update rate
}
