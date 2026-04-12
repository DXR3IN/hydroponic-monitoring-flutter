import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService extends GetxService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  static const String _kWelcomeSeenKey = 'welcome_seen';

  static const String _kAuthTokenKey = 'auth_token';

  Future<StorageService> init() async {
    return this;
  }

  Future<bool> get hasSeenWelcome async {
    final value = await _secureStorage.read(key: _kWelcomeSeenKey);
    return value == 'true';
  }

  Future<void> setWelcomeSeen() async {
    await _secureStorage.write(key: _kWelcomeSeenKey, value: 'true');
  }

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _kAuthTokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: _kAuthTokenKey);
  }

  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _kAuthTokenKey);
  }
}
