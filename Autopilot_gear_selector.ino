#include "DHT.h"
#include <ArduinoJson.h>

#define DHTPIN PA6
#define doorPin PB0
#define gear PA7
#define LedP PA5 
#define LedR PA4
#define LedN PA3
#define LedD PA2
#define neutral_safety_switch PA1

#define DHTTYPE DHT11   // DHT 11
String gearSelected = "P";
DHT dht(DHTPIN, DHTTYPE);

bool autopilotFlag = false;

void setup() {
  Serial.begin(9600);
  pinMode(gear, INPUT);
  pinMode(doorPin, INPUT_PULLUP);
  pinMode(neutral_safety_switch, INPUT_PULLUP);
  pinMode(LedP, OUTPUT);
  pinMode(LedR, OUTPUT);
  pinMode(LedN, OUTPUT);
  pinMode(LedD, OUTPUT);
  dht.begin();
}

void loop() {
  // Check for incoming serial data
  if (Serial.available() > 0) {
    char incomingByte = Serial.read();

    // Check for the autopilot flag
    if (incomingByte == 'A') {
      autopilotFlag = true;
    } else if (incomingByte == 'M') {
      autopilotFlag = false;
    }
  }

  int d = digitalRead(doorPin);
  int h = dht.readHumidity();
  int t = dht.readTemperature();

  // Create a JSON object
  StaticJsonDocument<200> doc;

  // Check if any reads failed and exit early (to try again).
  if (isnan(h) || isnan(t)) {
    doc["temperature"] = String("--");
    doc["humidity"] = "N/A";
    doc["door"] = 1;
  } else {
    doc["temperature"] = t;
    doc["humidity"] = h;
    doc["door"] = d;
  }

  // Determine gear
  if (!autopilotFlag) {
    int gearValue = analogRead(gear);
    if (gearValue > 300 && gearValue < 600) {
      gearSelected = "D";
    } else if (gearValue > 640 && gearValue < 870) {
      gearSelected = "N";
    } else if (gearValue > 900 && gearValue < 1090) {
      gearSelected = "R";
    } else if (gearValue > 1100 && gearValue < 1300) {
      gearSelected = "P";
    }

    // Set LED indicators based on the selected gear
    if (gearSelected == "P") {
      digitalWrite(LedP, HIGH);
      digitalWrite(LedN, LOW);
      digitalWrite(LedR, LOW);
      digitalWrite(LedD, LOW);
    } else if (gearSelected == "D") {
      digitalWrite(LedP, LOW);
      digitalWrite(LedN, LOW);
      digitalWrite(LedR, LOW);
      digitalWrite(LedD, HIGH);
    } else if (gearSelected == "N") {
      digitalWrite(LedP, LOW);
      digitalWrite(LedN, HIGH);
      digitalWrite(LedR, LOW);
      digitalWrite(LedD, LOW);
    } else if (gearSelected == "R") {
      digitalWrite(LedP, LOW);
      digitalWrite(LedN, LOW);
      digitalWrite(LedR, HIGH);
      digitalWrite(LedD, LOW);
    }
  } else {
    // Autopilot mode - receive gear from serial
    if (Serial.available() > 0) {
      char gearChar = Serial.read();
      gearSelected = String(gearChar);

      // Set LED indicators based on the received gear
      if (gearSelected == "P") {
        digitalWrite(LedP, HIGH);
        digitalWrite(LedN, LOW);
        digitalWrite(LedR, LOW);
        digitalWrite(LedD, LOW);
      } else if (gearSelected == "D") {
        digitalWrite(LedP, LOW);
        digitalWrite(LedN, LOW);
        digitalWrite(LedR, LOW);
        digitalWrite(LedD, HIGH);
      } else if (gearSelected == "N") {
        digitalWrite(LedP, LOW);
        digitalWrite(LedN, HIGH);
        digitalWrite(LedR, LOW);
        digitalWrite(LedD, LOW);
      } else if (gearSelected == "R") {
        digitalWrite(LedP, LOW);
        digitalWrite(LedN, LOW);
        digitalWrite(LedR, HIGH);
        digitalWrite(LedD, LOW);
      }
    }
  }

  doc["gear"] = gearSelected;

  // Serialize JSON to a string and send it over serial
  serializeJson(doc, Serial);
  Serial.println();
  delay(150);
}
