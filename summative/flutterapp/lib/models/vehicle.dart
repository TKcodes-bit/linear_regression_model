class Vehicle {
  final int year;
  final String make;
  final String model;
  final String vehicleClass;
  final double engineSize;
  final int cylinders;
  final String transmission;
  final String fuelType;
  final double fuelCity;
  final double fuelHwy;
  final double fuelComb;
  final double fuelMpg;

  Vehicle({
    required this.year,
    required this.make,
    required this.model,
    required this.vehicleClass,
    required this.engineSize,
    required this.cylinders,
    required this.transmission,
    required this.fuelType,
    required this.fuelCity,
    required this.fuelHwy,
    required this.fuelComb,
    required this.fuelMpg,
  });

  Map<String, dynamic> toJson() {
    return {
      "year": year,
      "make": make,
      "model": model,
      "vehicle_class": vehicleClass,
      "engine_size": engineSize,
      "cylinders": cylinders,
      "transmission": transmission,
      "fuel_type": fuelType,
      "fuel_city": fuelCity,
      "fuel_hwy": fuelHwy,
      "fuel_comb": fuelComb,
      "fuel_mpg": fuelMpg,
    };
  }
}
