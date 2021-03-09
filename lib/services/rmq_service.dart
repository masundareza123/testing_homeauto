import 'package:dart_amqp/dart_amqp.dart';

class RMQService {
  Client client;
  final String userQueue = "homeauto";
  final String passQueue = "homeauto12345!";
  final String vHostQueue = "/Homeauto";
  final String hostQueue = "192.168.4.174";
  final String queues = "Sensor";

  Client dataConnect(String user,String pass,String vHost,String host){
    ConnectionSettings settings = new ConnectionSettings(
      host: host,
      authProvider: new PlainAuthenticator(user, pass),
      virtualHost: vHost,
    );
    Client client = new Client(settings: settings);
    return client;
  }
  void publish(String message,Client client) {
    print("Kirim Data!");
    client.channel().then((Channel channel) {
      return channel.queue(queues, durable: true);
    }).then((Queue queue) {
      queue.publish(message);
      client.close();
    });
  }
}
