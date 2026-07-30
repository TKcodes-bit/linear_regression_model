import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
        primarySwatch: Colors.green,
        useMaterial3: false,
      ),

      home: const HomeScreen(),
    );
  }
}
