import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const VehiclePredictionApp());
}

class VehiclePredictionApp extends StatelessWidget {
  const VehiclePredictionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle CO₂ Predictor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
