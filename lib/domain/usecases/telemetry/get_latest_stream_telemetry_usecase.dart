import 'package:hydroponic_mobile/domain/entities/telemetry_entity.dart';
import 'package:hydroponic_mobile/domain/repositories/telemetry_repository.dart';

class GetLatestStreamTelemetryUsecase {
  final TelemetryRepository repository;

  GetLatestStreamTelemetryUsecase({required this.repository});

  Stream<TelemetryEntity> call(String deviceID) {
    return repository.GetLatestStreamTelemetry(deviceID);
  }
}
