import 'dart:async';
import 'dart:convert';

import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:hydroponic_mobile/core/config/app_config.dart';
import 'package:hydroponic_mobile/core/network/api_client.dart';
import 'package:hydroponic_mobile/core/utils/logger_debug.dart';
import 'package:hydroponic_mobile/data/datasources/remote/telemetry_stream_data_source.dart';
import 'package:hydroponic_mobile/data/models/telemetry_model.dart';
import 'package:rxdart/rxdart.dart';

class TelemetryStreamDataSourceImpl implements TelemetryStreamDataSource {
  final BehaviorSubject<TelemetryModel> _telemetryDataSubject =
      BehaviorSubject<TelemetryModel>();

  Stream<TelemetryModel> get telemetryDataStream =>
      _telemetryDataSubject.stream;

  StreamSubscription<SSEModel>? _sseSubscription;

  final String path = 'telemetry-service-v2';

  static const String EVENT_NAME = 'telemetry_new_data';

  @override
  Stream<TelemetryModel> getStreamLatestTelemetry(String deviceID) async* {
    final Map<String, String> headers = await getAuthHeaders();
    final String url =
        '${AppConfig.baseUrl}$path/api/telemetry/$deviceID/stream';

    if (_sseSubscription != null) {
      yield* telemetryDataStream;
    }

    _sseSubscription = SSEClient.subscribeToSSE(
            method: SSERequestType.GET, url: url, header: headers)
        .listen((SSEModel event) {
      if (event.event == EVENT_NAME && event.data != null) {
        try {
          final Map<String, dynamic> jsonMap = jsonDecode(event.data!);
          final latestTelemetryModel = TelemetryModel.fromJson(jsonMap);
          _telemetryDataSubject.add(latestTelemetryModel);
        } catch (e) {
          LoggerDebug.instance.e('SSE Parsing Error: $e');
        }
      }
    },
            onError: (e) => LoggerDebug.instance.e('SSE Connection Error: $e'),
            onDone: () => LoggerDebug.instance.i('SSE Connection closed.'));
  }

  @override
  void dispose() {
    _sseSubscription?.cancel();
    _telemetryDataSubject.close();
  }
}
