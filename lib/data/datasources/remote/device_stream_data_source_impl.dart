import 'dart:async';
import 'dart:convert';

import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:hydroponic_mobile/core/config/app_config.dart';
import 'package:hydroponic_mobile/core/network/api_client.dart';
import 'package:hydroponic_mobile/core/utils/logger_debug.dart';
import 'package:hydroponic_mobile/data/datasources/remote/device_stream_data_source.dart';
import 'package:hydroponic_mobile/data/models/device_status_model.dart';
import 'package:rxdart/rxdart.dart';

class DeviceStreamDataSourceImpl implements DeviceStreamDataSource {
  final BehaviorSubject<DeviceStatusModel> _deviceStatusSubject =
      BehaviorSubject<DeviceStatusModel>();

  Stream<DeviceStatusModel> get deviceStatusStream =>
      _deviceStatusSubject.stream;

  StreamSubscription<SSEModel>? _sseSubscription;

  final String path = 'device-service-v2';

  static const String EVENT_NAME = 'device_status_update';

  @override
  Stream<DeviceStatusModel> streamDeviceStatus() async* {
    final Map<String, String> headers = await getAuthHeaders();
    final String url = '${AppConfig.baseUrl}$path/device/stream';

    if (_sseSubscription != null) {
      yield* deviceStatusStream;
    }

    _sseSubscription = SSEClient.subscribeToSSE(
      method: SSERequestType.GET,
      url: url,
      header: headers,
    ).listen((SSEModel event) {
      if (event.event == EVENT_NAME && event.data != null) {
        try {
          final Map<String, dynamic> jsonMap = jsonDecode(event.data!);
          final statusModel = DeviceStatusModel.fromJson(jsonMap);
          _deviceStatusSubject.add(statusModel);
        } catch (e) {
          LoggerDebug.instance.e('SSE Parsing Error: $e');
        }
      }
    }, onError: (e) {
      LoggerDebug.instance.e('SSE Connection Error: $e');
    }, onDone: () {
      LoggerDebug.instance.i('SSE Connection closed.');
    });

    yield* deviceStatusStream;
  }

  @override
  void dispose() {
    _sseSubscription?.cancel();
    _deviceStatusSubject.close();
  }
}
