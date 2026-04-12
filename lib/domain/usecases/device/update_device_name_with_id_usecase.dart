import 'package:hydroponic_mobile/domain/entities/device_entity.dart';
import 'package:hydroponic_mobile/domain/repositories/device_repository.dart';

class UpdateDeviceNameWithIdUsecase {
  final DeviceRepository repository;

  UpdateDeviceNameWithIdUsecase({required this.repository});

  Future<DeviceEntity> call(String deviceID, String deviceName) async {
    return await repository.updateDeviceNameWithID(deviceID, deviceName);
  }
}
