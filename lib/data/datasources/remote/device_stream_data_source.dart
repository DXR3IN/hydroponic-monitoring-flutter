import 'package:hydroponic_mobile/data/models/device_status_model.dart';

abstract class DeviceStreamDataSource {
  Stream<DeviceStatusModel> streamDeviceStatus();
  void dispose();
}
