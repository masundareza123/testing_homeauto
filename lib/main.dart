import 'package:flutter/material.dart';
import 'package:testing_homeauto/ui/views/home_view.dart';
import 'package:testing_homeauto/ui/views/login_view.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loginScreen(),
    );
  }
}
