import 'package:hydroponic_mobile/domain/entities/telemetry_entity.dart';

abstract class TelemetryRepository {
  Future<List<TelemetryEntity>> GetTelemetryByID(String deviceID);
  Future<TelemetryEntity> GetLatestTelemetry(String deviceID);
  Stream<TelemetryEntity> GetLatestStreamTelemetry(String deviceID);
}