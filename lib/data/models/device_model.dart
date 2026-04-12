import 'package:hydroponic_mobile/domain/entities/device_entity.dart';

class DeviceModel extends DeviceEntity {
  const DeviceModel({
    required super.id,
    required super.deviceName,
    required super.ownerID,
    required super.status,
    required super.createdAt,
    // required super.updatedAt,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: json['id'] as String,
      deviceName: json['device_name'] as String,
      ownerID: json['owner_id'] as String,
      status: json['status'] as String,
      createdAt: json['created_at'] as DateTime,
      // updatedAt: json['updated_at'] as DateTime,
    );
  }

  DeviceEntity toEntity() {
    return DeviceEntity(
      id: id,
      deviceName: deviceName,
      ownerID: ownerID,
      status: status,
      createdAt: createdAt,
      // updatedAt: updatedAt,
    );
  }
}
