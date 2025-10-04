import 'package:flutter/material.dart';
import 'package:tree/screens/weather_screen.dart';
import 'package:tree/datasourse/get_data/get_data.dart';
void main(){
  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'hala'),
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
      
    );
  }
}
