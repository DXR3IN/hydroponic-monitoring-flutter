import 'package:hydroponic_mobile/domain/entities/device_entity.dart';
import 'package:hydroponic_mobile/domain/entities/device_status_entity.dart';

abstract class DeviceRepository {
  Future<DeviceEntity> createDevice(String deviceID, String deviceName);
  Future<List<DeviceEntity>> listDevice();
  Future<DeviceEntity> getDeviceWithID(String deviceID);
  Future<DeviceEntity> updateDeviceNameWithID(
      String deviceID, String deviceName);
  Future<void> deleteDeviceWithID(String deviceID);
  Stream<DeviceStatusEntity> streamDeviceStatusUpdates();
}
