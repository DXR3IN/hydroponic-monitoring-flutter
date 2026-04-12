import 'package:hydroponic_mobile/domain/entities/device_entity.dart';
import 'package:hydroponic_mobile/domain/repositories/device_repository.dart';

class ListDeviceUsecase {
  final DeviceRepository repository;

  ListDeviceUsecase({required this.repository});

  Future<List<DeviceEntity>> call() async {
    return await repository.listDevice();
  }
}
