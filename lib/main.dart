import 'package:ecommerceapp/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E commerce',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0, 112, 76, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
        home: SplashScreen(),
    );
  }
}
