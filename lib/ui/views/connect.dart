// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'package:dart_amqp/dart_amqp.dart';
// import 'package:testing_homeauto/ui/views/home_view.dart';
//
// class ConnectionView extends StatefulWidget {
//   String user;
//   String pass;
//   String vhost;
//   String host;
//
//   ConnectionView({this.user, this.pass, this.vhost, this.host});
//   @override
//   _ConnectionViewState createState() => _ConnectionViewState();
// }
//
// class _ConnectionViewState extends State<ConnectionView> {
//   Client client;
//   bool check_status = false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     connect();
//   }
//   void connect() {
//     try {
//       ConnectionSettings settings = new ConnectionSettings(
//         host: widget.host,
//         authProvider: new PlainAuthenticator(widget.user, widget.pass),
//         virtualHost: widget.vhost,
//       );
//       client = new Client(settings: settings);
//       client.connect().then((value) {
//         setState(() {
//           check_status = true;
//         });
//       });
//     } catch (e) {
//       print("kesalahan 344or $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//             child: Padding(
//                 padding: EdgeInsets.all(10),
//                 child: check_status?ListView.builder(
//                   reverse: true,
//                   itemBuilder: (context,idx){
//
//                     return HomeView();
//                   },
//                 ):Container(
//                   child: Center(
//                     child: Text("RMQ Not Connected \n Please check your credential"),
//                   ),
//                 )
//             )
//         )
//     );
//   }
// }
