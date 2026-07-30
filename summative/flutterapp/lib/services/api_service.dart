import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/vehicle.dart';
import '../utils/encoders.dart';

class ApiService {
  // Your deployed Render API
  static const String baseUrl =
      "https://vehicle-co2-api.onrender.com";

  static Future<double> predictEmission(Vehicle vehicle) async {

    final encodedVehicle = {
      "year": vehicle.year,

      "make": makeMap[vehicle.make.toUpperCase()],
      "model": modelMap[vehicle.model.toUpperCase()],
      "vehicle_class":
          vehicleClassMap[vehicle.vehicleClass.toUpperCase()],

      "engine_size": vehicle.engineSize,
      "cylinders": vehicle.cylinders,

      "transmission":
          transmissionMap[vehicle.transmission.toUpperCase()],

      "fuel_type":
          fuelTypeMap[vehicle.fuelType.toUpperCase()],

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
