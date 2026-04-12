import 'package:hydroponic_mobile/domain/entities/telemetry_entity.dart';
import 'package:hydroponic_mobile/domain/repositories/telemetry_repository.dart';

class GetLatestTelemetryUsecase {
  final TelemetryRepository repository;

  GetLatestTelemetryUsecase({required this.repository});

  Future<TelemetryEntity> call(String deviceID) async {
    return await repository.GetLatestTelemetry(deviceID);
  }
}
