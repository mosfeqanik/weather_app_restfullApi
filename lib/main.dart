import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_dio/provider/weather_provider.dart';
import 'package:weather_app_dio/screens/location_screen/location_screen.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<WeatherProvider>(
              create: (context) => WeatherProvider()),
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LocationScreen(),
    );
  }
}
