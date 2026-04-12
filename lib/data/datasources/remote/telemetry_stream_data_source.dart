import 'package:hydroponic_mobile/data/models/telemetry_model.dart';

abstract class TelemetryStreamDataSource {
  Stream<TelemetryModel> getStreamLatestTelemetry(String deviceID);
  void dispose();
}
