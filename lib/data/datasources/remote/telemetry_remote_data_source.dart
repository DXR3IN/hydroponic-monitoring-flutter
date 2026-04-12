import 'package:hydroponic_mobile/data/models/telemetry_model.dart';

abstract class TelemetryRemoteDataSource {
  Future<List<TelemetryModel>> GetTelemetryByID(String deviceID);
  Future<TelemetryModel> GetLatestTelemetry(String deviceID);
}