import 'package:hydroponic_mobile/domain/entities/device_status_entity.dart';
import 'package:hydroponic_mobile/domain/repositories/device_repository.dart';

class GetDeviceStatusStreamUsecase {
  final DeviceRepository repository;
  GetDeviceStatusStreamUsecase(this.repository);

  Stream<DeviceStatusEntity> call() {
    return repository.streamDeviceStatusUpdates();
  }
}