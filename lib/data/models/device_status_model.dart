import 'package:hydroponic_mobile/domain/entities/device_status_entity.dart';

class DeviceStatusModel {
  final String id;
  final String status;
  final DateTime updatedAt;

  DeviceStatusModel({
    required this.id,
    required this.status,
    required this.updatedAt,
  });

  factory DeviceStatusModel.fromJson(Map<String, dynamic> json) {
    return DeviceStatusModel(
      id: json['id'] as String,
      status: json['status'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  DeviceStatusEntity toEntity() {
    return DeviceStatusEntity(id: id, status: status, updatedAt: updatedAt);
  }
}
