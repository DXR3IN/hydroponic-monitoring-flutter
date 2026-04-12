//////////////////////////////////////////////////
//  wl is the same as Water Level///////////////////////////
////////////////////////////////////////////
library;

class TelemetryEntity {
  final String id;
  final String deviceId;
  final double ppm;
  final double wlOnPlant;
  final double wlOnCondenser;
  final double wlOnNutrientTank;
  final double humidity;
  final DateTime createdAt;

  const TelemetryEntity({
    required this.id,
    required this.deviceId,
    required this.ppm,
    required this.wlOnPlant,
    required this.wlOnCondenser,
    required this.wlOnNutrientTank,
    required this.humidity,
    required this.createdAt,
  });
}
