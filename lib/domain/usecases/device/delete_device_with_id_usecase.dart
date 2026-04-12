import 'package:hydroponic_mobile/domain/repositories/device_repository.dart';

class DeleteDeviceWithIdUsecase {
  final DeviceRepository repository;

  DeleteDeviceWithIdUsecase({required this.repository});

  Future<void> call(String deviceID) async {
    return await repository.deleteDeviceWithID(deviceID);
  }
}
