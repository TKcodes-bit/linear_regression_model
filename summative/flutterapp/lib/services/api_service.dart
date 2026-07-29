import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/vehicle.dart';

class ApiService {
  // Replace with your actual Render URL
  static const String baseUrl =
      "https://vehicle-co2-api.onrender.com";

  static Future<double> predictEmission(Vehicle vehicle) async {
    final response = await http.post(
      Uri.parse("$baseUrl/predict"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(vehicle.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return (data["prediction"] as num).toDouble();
    } else {
      throw Exception("Prediction failed: ${response.body}");
    }
  }
}
