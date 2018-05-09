int ledPin = 2; // LED pin
int inputPin = 14; // input pin of PIR
int pirState = LOW;
int val = 0;
//
void setup() {
  pinMode(ledPin, OUTPUT); // declare LED as output
  pinMode(inputPin, INPUT); // declare sensor as input
  Serial.begin(9600);
}
void loop(){
  val = digitalRead(inputPin); // read input value
  Serial.println(val);
  if (val == HIGH) {
    digitalWrite(ledPin, HIGH); // LED on
    if (pirState == LOW) {
      // we have just turned on
      Serial.println("Motion detected");
      pirState = HIGH;
      delay(50);
    }
  } else {
    digitalWrite(ledPin, LOW); // LED off
    if (pirState == HIGH){
      // we have just turned of
      Serial.println("Motion ended");
      pirState = LOW;
      delay(50);
    }
  }
}
