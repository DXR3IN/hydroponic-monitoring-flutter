import 'package:get/get.dart';
import 'package:hydroponic_mobile/core/config/app_route.dart';
import 'package:hydroponic_mobile/core/utils/logger_debug.dart';
import 'package:hydroponic_mobile/core/utils/storage_service.dart';

class SplashController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();

  @override
  void onInit() {
    super.onInit();
    LoggerDebug.instance.i('onInit Splash');
  }

  @override
  void onReady() {
    super.onReady();
    LoggerDebug.instance.i('onReady Splash Success');
    _determineNextRoute();
  }

  Future<void> _determineNextRoute() async {
    await Future.delayed(const Duration(seconds: 2));

    final nextRoute = await _storageService.hasSeenWelcome
        ? AppRoute.loginScreen
        : AppRoute.welcomeScreen;

    Get.offAllNamed(nextRoute);
  }
}
