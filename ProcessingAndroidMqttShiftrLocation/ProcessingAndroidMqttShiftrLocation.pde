import ketai.sensors.*;
double longitude, latitude, altitude;
KetaiLocation location;
// RENENS SQUARE
PVector latMinMax = new PVector(46.5, 46.6);
PVector longMinMax = new PVector(6.5, 6.7);
// MUDA SQUARE !!!
//PVector latMinMax = new PVector(47.384863, 47.394863);
//PVector longMinMax = new PVector(8.5156, 8.5019);
//
import mqtt.*;
MQTTClient client;
//
void setup() {
  location = new KetaiLocation(this);
  //
  client = new MQTTClient(this);
  client.connect("mqtt://frgmntnmuda:b0672a7de83013f5@broker.shiftr.io", "processing");
  client.subscribe("/miam");
  // client.unsubscribe("/example");
  frameRate(15);
}

void draw() {
  background(0);
  if (location.getProvider() == "none")
    text("Location data is unavailable. \n" +
      "Please check your location settings.", 0, 0, width, height);
  else
    text("Latitude: " + latitude + "\n" + 
      "Longitude: " + longitude + "\n" + 
      "Altitude: " + altitude + "\n" + 
      "Provider: " + location.getProvider(), 0, 0, width, height);  
  // getProvider() returns "gps" if GPS is available
  // otherwise "network" (cell network) or "passive" (WiFi MACID)
}

void onLocationEvent(double _latitude, double _longitude, double _altitude)
{
  longitude = _longitude;
  latitude = _latitude;
  altitude = _altitude;
  println("lat/lon/alt: " + latitude + "/" + longitude + "/" + altitude);
  client.publish("/lat", ""+latitude);
  client.publish("/long", ""+longitude);
  if (latitude>latMinMax.x && latitude < latMinMax.y && longitude>longMinMax.x && longitude < longMinMax.y) {
    client.publish("/buzz", "buzz");
  }
}

void mousePressed() {
  client.publish("/sucrerie", "Miam");
}

void messageReceived(String topic, byte[] payload) {
  println("new message: " + topic + " - " + new String(payload));
  //client.publish("/example", "world");
}