// Blink without Delay


const int ledPin =  2;      // the number of the LED pin


int ledState = LOW;             // ledState used to set the LED

// Generally, you shuould use "unsigned long" for variables that hold time
// The value will quickly become too large for an int to store
unsigned long previousMillis = 0;        // will store last time LED was updated


//const long interval = 1000;     // 1   sec
//const long interval = 10000;    // 10  sec
const long interval   = 100000;   // 100 sec

void setup() {
  Serial.begin(9600);
  
  // set the digital pin as output:
  pinMode(ledPin, OUTPUT);
}

void loop()
{
  // using millis you have to reset the machine once every day
  
  relay_1_loop();
  // relay_2_loop();
  
  
}

void relay_1_loop() {
  // check to see if it's time to blink the LED; that is, if the
  // difference between the current time and last time you blinked
  // the LED is bigger than the interval at which you want to
  // blink the LED.
  unsigned long currentMillis = millis();

  if(currentMillis - previousMillis >= interval) {
    // save the last time you blinked the LED
    previousMillis = currentMillis;

    // if the LED is off turn it on and vice-versa:
    if (ledState == LOW)
      ledState = HIGH;
    else
      ledState = LOW;

    // set the LED with the ledState of the variable:
    digitalWrite(ledPin, ledState);
  } 
  
}
