import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hydroponic_mobile/core/config/app_config.dart';
import 'package:hydroponic_mobile/core/config/app_route.dart';
import 'package:hydroponic_mobile/core/utils/logger_debug.dart';
import 'package:hydroponic_mobile/core/utils/storage_service.dart';

final String BASE_URL = AppConfig.baseUrl;
// const String TOKEN_KEY = 'auth_token';

final logger = LoggerDebug.instance;

StorageService secureStorage = Get.find<StorageService>();

Future<Map<String, String>> getAuthHeaders() async {
  final token = await secureStorage.getToken();

  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  if (token != null && token.isNotEmpty) {
    headers['Authorization'] = 'Bearer $token';
  }

  return headers;
}

Dio createDioClient() {
  final dio = Dio(BaseOptions(
    baseUrl: BASE_URL,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    contentType: 'application/json',
  ));
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final authHeaders = await getAuthHeaders();
      options.headers.addAll(authHeaders);
      if (options.path.contains('/auth/login') ||
          options.path.contains('/auth/register')) {
        options.headers.remove('Authorization');
      }
      return handler.next(options);
    },
    onError: (DioException e, handler) {
      if (e.response?.statusCode == 401) {
        secureStorage.deleteToken();
        Get.toNamed(AppRoute.loginScreen);
      }
      return handler.next(e);
    },
  ));

  return dio;
}
