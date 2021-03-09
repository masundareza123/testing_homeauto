import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testing_homeauto/services/rmq_service.dart';
import 'package:testing_homeauto/ui/shared/ui_helper.dart';
import 'package:testing_homeauto/ui/views/lamp_view.dart';
import 'package:stacked/stacked.dart';
import 'package:dart_amqp/dart_amqp.dart';

import '../shared/ui_helper.dart';

class HomeView extends StatefulWidget {
  String user;
  String pass;
  String vhost;
  String host;

  HomeView({this.user, this.pass, this.vhost, this.host});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Client client;
  bool check_status = false;
  RMQService rmqService = new RMQService();
  ValueChanged<bool> onChanged;
  bool allLamp = false;
  String status_allLamp = "OFF";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
    setState(() {
      allLamp = false;
    });
  }

  void connect() {
    try {
      client = rmqService.dataConnect(
          widget.user, widget.pass, widget.vhost, widget.host
      );
      // client.channel().then((Channel channel){
      //   return channel.queue("Sensor", durable: true);
      // }).then((Queue queue){
      //   queue.publish("Succes");
      // } );
      client.connect().then((value) {
        setState(() {
          check_status = true;
        });
      });
    } catch (e) {
      print("kesalahan 344or $e");
    }
  }

  void LampuSemua(bool status){
    if(status){
      rmqService.publish("5baa1697-ab70-400d-b670-6be5f5c9070a#0000",client);
    }else{
      rmqService.publish("5baa1697-ab70-400d-b670-6be5f5c9070a#1111",client);
    }
    allLamp = status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Testing Lamp Home Automation"),
        ),
        backgroundColor: Color(0xffF1F4F6),
        body: SingleChildScrollView(
          child:Center (
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: Container(
                      width: 200,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.white,
                        child: InkWell(
                          onTap : (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LampView(status: allLamp, user: widget.user, pass: widget.pass, vhost: widget.vhost, host: widget.host,)));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              verticalSpaceMedium,
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child:Icon(FontAwesomeIcons.lightbulb,color: Colors.blue,),
                              ),
                              verticalSpaceMedium,
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "All Lamp",
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "$status_allLamp",
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: TextStyle(color: Colors.grey, fontSize: 10.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 7,bottom: 15,top: 10),
                                child:  InkWell(
                                  splashColor: Colors.white,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.decelerate,

                                    width: 50,
                                    decoration: BoxDecoration(

                                      borderRadius: BorderRadius.circular(50.0),
                                      border: Border.all(color: Color(0xff0079E2)),
                                      color: allLamp ? Color(0xff0079E2) : Color(0xFFFFFFFF),
                                    ),
                                    child: AnimatedAlign(
                                      duration: const Duration(milliseconds: 300),
                                      alignment:
                                      allLamp ? Alignment.centerRight : Alignment.centerLeft,
                                      curve: Curves.decelerate,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: allLamp ? Color(0xFFFFFFFF):Color(0xff0079E2),
                                            borderRadius: BorderRadius.circular(100.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      print("semua lampu");
                                      allLamp = !allLamp;
                                      allLamp ? status_allLamp = "ON":status_allLamp = "OFF";
                                      LampuSemua(allLamp);
                                      // onChanged(front);
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}

