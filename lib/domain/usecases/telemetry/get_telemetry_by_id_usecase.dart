import 'package:hydroponic_mobile/domain/entities/telemetry_entity.dart';
import 'package:hydroponic_mobile/domain/repositories/telemetry_repository.dart';

class GetTelemetryByIdUsecase {
  final TelemetryRepository repository;

  GetTelemetryByIdUsecase({required this.repository});

  Future<List<TelemetryEntity>> call(String deviceID) async {
    return await repository.GetTelemetryByID(deviceID);
  }
}
