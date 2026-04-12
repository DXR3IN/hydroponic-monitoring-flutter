import 'package:hydroponic_mobile/data/models/device_model.dart';

abstract class DeviceRemoteDataSource {
  Future<DeviceModel> createDevice(String deviceID, String deviceName);
  Future<List<DeviceModel>> listDevice();
  Future<DeviceModel> getDeviceWithID(String deviceID);
  Future<DeviceModel> updateDeviceNameWithID(
      String deviceID, String deviceName);
  Future<void> deleteDeviceWithID(String deviceID);
}
