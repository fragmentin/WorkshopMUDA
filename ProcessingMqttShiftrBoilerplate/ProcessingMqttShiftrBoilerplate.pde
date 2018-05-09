import mqtt.*;
MQTTClient client;
//
void setup() {
  client = new MQTTClient(this);
  client.connect("mqtt://frgmntnmuda:b0672a7de83013f5@broker.shiftr.io", "processing");
  client.subscribe("/receive");
  frameRate(30);
}
void draw() {
  background(0);
}
void mousePressed() {
  client.publish("/send", "message to send");
}
void messageReceived(String topic, byte[] payload) {
  println("new message: " + topic + " - " + new String(payload));
  //client.publish("/example", "world");
}