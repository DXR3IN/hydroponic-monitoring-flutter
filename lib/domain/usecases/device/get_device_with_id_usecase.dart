import 'package:hydroponic_mobile/domain/entities/device_entity.dart';
import 'package:hydroponic_mobile/domain/repositories/device_repository.dart';

class GetDeviceWithIdUsecase {
  final DeviceRepository repository;

  GetDeviceWithIdUsecase({required this.repository});

  Future<DeviceEntity> call(String deviceID) async {
    return await repository.getDeviceWithID(deviceID);
  }
}
