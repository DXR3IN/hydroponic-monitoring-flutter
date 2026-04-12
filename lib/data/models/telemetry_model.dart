import 'package:hydroponic_mobile/domain/entities/telemetry_entity.dart';

class TelemetryModel extends TelemetryEntity {
  const TelemetryModel({
    required super.id,
    required super.deviceId,
    required super.ppm,
    required super.wlOnPlant,
    required super.wlOnCondenser,
    required super.wlOnNutrientTank,
    required super.humidity,
    required super.createdAt,
  });

  factory TelemetryModel.fromJson(Map<String, dynamic> json) {
    return TelemetryModel(
      id: json['id'] as String,
      deviceId: json['device_id'] as String,
      ppm: json['ppm'] as double,
      wlOnPlant: json['water_level_on_plant'] as double,
      wlOnCondenser: json['water_level_on_condenser'] as double,
      wlOnNutrientTank: json['water_level_on_nutrient_tank'] as double,
      humidity: json['humidity'] as double,
      createdAt: json['created_at'] as DateTime,
    );
  }

  TelemetryEntity toEntity() {
    return TelemetryEntity(
      id: id,
      deviceId: deviceId,
      ppm: ppm,
      wlOnPlant: wlOnPlant,
      wlOnCondenser: wlOnCondenser,
      wlOnNutrientTank: wlOnNutrientTank,
      humidity: humidity,
      createdAt: createdAt,
    );
  }
}
