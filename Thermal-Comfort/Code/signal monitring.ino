#include <Wire.h>
#include "MAX30100_PulseOximeter.h"

#define Air_Tem A0
#define Skin_Tem A1
#define GSR A2

#define REPORTING_PERIOD_MS     1000

int a0 = 0;
int a1 = 0;
int gsr = 0;
float air_temp = 0;
float skin_temp = 0;

PulseOximeter pox;

uint32_t tsLastReport = 0;

void setup()
{
    Serial.begin(9600);

    Serial.print("Initializing pulse oximeter..");

    if (!pox.begin()) {
        Serial.println("FAILED");
        for(;;);
    } else {
        Serial.println("SUCCESS");
    }
}

void loop()
{  
    // Make sure to call update as fast as possible
    pox.update();

    a0 = analogRead(Air_Tem);
    air_temp = a0*0.48876;
    a1 = analogRead(Skin_Tem);
    skin_temp = a1*0.48876;
    gsr = analogRead(GSR);
    
    // Asynchronously dump heart rate and oxidation levels to the serial
    // For both, a value of 0 means "invalid"
    if (millis() - tsLastReport > REPORTING_PERIOD_MS) {
        Serial.println(air_temp);
        Serial.println(skin_temp);
        Serial.println(gsr);
        Serial.println(pox.getHeartRate());
    
        tsLastReport = millis();
    }

    //a0 = analogRead(Air_Tem);
    //air_temp = a0*0.48876;
    //a1 = analogRead(Skin_Tem);
    //skin_temp = a1*0.48876;
    //Serial.println(air_temp);
    //Serial.println(skin_temp);
    //delay(1000);
}
