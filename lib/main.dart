import 'package:flutter/material.dart';
import 'package:weather_app/config/config.dart';

import 'presentation/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getAppTheme(),
      title: 'Meteo por JFdeSousa',
      home: HomeScreen(),
    );
  }
}
