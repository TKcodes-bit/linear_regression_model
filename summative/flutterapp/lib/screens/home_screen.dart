import 'package:flutter/material.dart';

import '../models/vehicle.dart';
import '../services/api_service.dart';
import '../widgets/custom_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  final yearController = TextEditingController();
  final makeController = TextEditingController();
  final modelController = TextEditingController();
  final vehicleClassController = TextEditingController();
  final engineSizeController = TextEditingController();
  final cylindersController = TextEditingController();
  final transmissionController = TextEditingController();
  final fuelTypeController = TextEditingController();
  final fuelCityController = TextEditingController();
  final fuelHwyController = TextEditingController();
  final fuelCombController = TextEditingController();
  final fuelMpgController = TextEditingController();

  bool isLoading = false;
  double? prediction;

  Future<void> predict() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      prediction = null;
    });

    try {
      // Debug input values
      print({
        "year": yearController.text,
        "engine_size": engineSizeController.text,
        "cylinders": cylindersController.text,
        "fuel_city": fuelCityController.text,
        "fuel_hwy": fuelHwyController.text,
        "fuel_comb": fuelCombController.text,
        "fuel_mpg": fuelMpgController.text,
      });

      final vehicle = Vehicle(
        year: int.tryParse(yearController.text.trim()) ?? 0,
        make: makeController.text.trim(),
        model: modelController.text.trim(),
        vehicleClass: vehicleClassController.text.trim(),

        engineSize:
            double.tryParse(engineSizeController.text.trim()) ?? 0.0,

        cylinders:
            int.tryParse(cylindersController.text.trim()) ?? 0,

        transmission: transmissionController.text.trim(),
        fuelType: fuelTypeController.text.trim(),

        fuelCity:
            double.tryParse(fuelCityController.text.trim()) ?? 0.0,

        fuelHwy:
            double.tryParse(fuelHwyController.text.trim()) ?? 0.0,

        fuelComb:
            double.tryParse(fuelCombController.text.trim()) ?? 0.0,

        fuelMpg:
            double.tryParse(fuelMpgController.text.trim()) ?? 0.0,
      );

      print("Sending JSON:");
      print(vehicle.toJson());

      final result = await ApiService.predictEmission(vehicle);

      setState(() {
        prediction = result;
      });

    } catch (e, stackTrace) {
      print("ERROR: $e");
      print(stackTrace);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Prediction failed.\n$e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    yearController.dispose();
    makeController.dispose();
    modelController.dispose();
    vehicleClassController.dispose();
    engineSizeController.dispose();
    cylindersController.dispose();
    transmissionController.dispose();
    fuelTypeController.dispose();
    fuelCityController.dispose();
    fuelHwyController.dispose();
    fuelCombController.dispose();
    fuelMpgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehicle CO₂ Predictor"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            children: [

              CustomTextField(
                label: "Year",
                controller: yearController,
                keyboardType: TextInputType.number,
              ),

              CustomTextField(
                label: "Make",
                controller: makeController,
              ),

              CustomTextField(
                label: "Model",
                controller: modelController,
              ),

              CustomTextField(
                label: "Vehicle Class",
                controller: vehicleClassController,
              ),

              CustomTextField(
                label: "Engine Size (L)",
                controller: engineSizeController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),

              CustomTextField(
                label: "Cylinders",
                controller: cylindersController,
                keyboardType: TextInputType.number,
              ),

              CustomTextField(
                label: "Transmission",
                controller: transmissionController,
              ),

              CustomTextField(
                label: "Fuel Type",
                controller: fuelTypeController,
              ),

              CustomTextField(
                label: "Fuel City",
                controller: fuelCityController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),

              CustomTextField(
                label: "Fuel Highway",
                controller: fuelHwyController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),

              CustomTextField(
                label: "Fuel Combined",
                controller: fuelCombController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),

              CustomTextField(
                label: "Fuel MPG",
                controller: fuelMpgController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: isLoading ? null : predict,

                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Predict CO₂ Emission",
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ),

              const SizedBox(height: 30),

              if (prediction != null)

                Card(
                  elevation: 5,
                  color: Colors.green.shade50,

                  child: Padding(
                    padding: const EdgeInsets.all(20),

                    child: Column(
                      children: [

                        const Text(
                          "Predicted CO₂ Emission",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "${prediction!.toStringAsFixed(2)} g/km",

                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
