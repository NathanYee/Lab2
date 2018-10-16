#include "Arduino.h"

// Set LED_BUILTIN if it is not defined by Arduino framework
#define LED_BUILTIN PC13

USBSerial usb;

int laserPin = PB1;
char in = '0';

void setup()
{
  pinMode(laserPin, OUTPUT);
  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, HIGH);

  //Serial.begin(9600);
  usb.begin(115200);

}

void loop() {

  while (usb.available()) {
    in = usb.read();
		usb.print("Got char: "); usb.println(in); //Acknowledge that we got it
  }

  //analogWrite(laserPin, (unsigned int)in);
  digitalWrite(laserPin, (in == '0') ? LOW : HIGH);
  digitalWrite(LED_BUILTIN, (in == '0') ? HIGH : LOW);

  //usb.println(in + '0'); //Print the char's ASCII value

	/*
	usb.print("in: ");
	usb.println(in);
	*/

	delay(10);

}
  
