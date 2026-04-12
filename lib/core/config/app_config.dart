// core/config/app_config.dart

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static const String environment =
      String.fromEnvironment('FLAVOR', defaultValue: '.env-dev');

  static late final String baseUrl;
  static late final String portAuth;
  static late final String portDevice;
  static late final String portTelemetry;
  static late final String appName;

  static Future<void> load(String envFileName) async {
    // Memuat file .env yang sesuai (misalnya .env_dev)
    await dotenv.load(fileName: envFileName);

    // Mengambil nilai
    baseUrl = dotenv.env['BASE_URL'] ?? 'http://default.com';
    portAuth = dotenv.env['PORT_AUTH'] ?? 'default_api_key';
    portDevice = dotenv.env['PORT_DEVICE'] ?? 'default';
    portTelemetry = dotenv.env['PORT_TELEMETRY'] ?? 'default';
    appName = dotenv.env['APP_NAME'] ?? 'Hydroponic App';

    // Validasi dasar jika diperlukan
    if (baseUrl.isEmpty) {
      throw Exception('BASE_URL is not configured.');
    }
  }
}
