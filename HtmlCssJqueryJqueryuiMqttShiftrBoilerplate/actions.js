$( document ).ready(function() {
  var client = mqtt.connect("mqtt://frgmntnmuda:b0672a7de83013f5@broker.shiftr.io") // you add a ws:// url here
  client.subscribe("mqtt/demo")

  client.on("message", function (topic, payload) {
    alert([topic, payload].join(": "))
    //client.end()
  })
  $("button").click(function() {
    var t = $(this).attr("id");
    client.publish("web/"+t, t)
  });
});
