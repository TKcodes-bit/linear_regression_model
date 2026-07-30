import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/vehicle.dart';
import '../utils/encoders.dart';

class ApiService {
  // Your deployed Render API
  static const String baseUrl =
      "https://vehicle-co2-api.onrender.com";

  static Future<double> predictEmission(Vehicle vehicle) async {

    // Encode categorical values before sending to ML API
    final encodedVehicle = {
      "year": vehicle.year,

      "make": makeEncoder[vehicle.make],
      "model": modelEncoder[vehicle.model],
      "vehicle_class":
          vehicleClassEncoder[vehicle.vehicleClass],

      "engine_size": vehicle.engineSize,
      "cylinders": vehicle.cylinders,

      "transmission":
          transmissionEncoder[vehicle.transmission],

      "fuel_type":
          fuelTypeEncoder[vehicle.fuelType],

      "fuel_city": vehicle.fuelCity,
      "fuel_hwy": vehicle.fuelHwy,
      "fuel_comb": vehicle.fuelComb,
      "fuel_mpg": vehicle.fuelMpg,
    };


    print("Sending encoded JSON:");
    print(encodedVehicle);


    final response = await http.post(
      Uri.parse("$baseUrl/predict"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(encodedVehicle),
    );


    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return (data["predicted_co2"] as num).toDouble();

    } else {
      throw Exception(
        "Prediction failed: ${response.body}"
      );
    }
  }
}

