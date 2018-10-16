#include "Arduino.h"
#include <SPI.h>

// Set LED_BUILTIN if it is not defined by Arduino framework
#define LED_BUILTIN PC13

USBSerial usb;


void setup() {
	digitalWrite(SS, HIGH); // SS should be high when we are not actively writing
	SPI.begin();
}


void loop() {
	byte d = 0b00000011;

	SPI.beginTransaction(SPISettings(100000 /*Speed in hz*/, MSBFIRST, SPI_MODE0 /*Clock phase and polarity*/));
	digitalWrite(SS, LOW);

	SPI.transfer(d);
	
	digitalWrite(SS, HIGH);
	SPI.endTransaction();
}
