import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hydroponic_mobile/core/config/app_route.dart';
import 'package:hydroponic_mobile/core/utils/storage_service.dart';

class WelcomeController extends GetxController {
  var currentPage = 0.obs;
  // This double will track how close we are to the middle page (index 1).
  // 0.0 = not on middle page. 1.0 = exactly on middle page.
  RxDouble middlePageEffectIntensity = 0.0.obs;
  final StorageService storage = Get.find<StorageService>();

  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.addListener(_scrollListener);
    });
  }

  void _scrollListener() {
    double? currentPosition = pageController.page;
    if (currentPosition == null) return;

    double intensity = 1.0 - (currentPosition - 1.0).abs();

    // Clamp between 0.0 and 1.0 to avoid weird overscroll effects
    middlePageEffectIntensity.value = intensity.clamp(0.0, 1.0);
  }

  void nextPage() {
    if (currentPage.value < 2) {
      pageController.animateToPage(
        currentPage.value + 1,
        duration: const Duration(milliseconds: 500),
        // Using a slightly softer curve for a more elegant feel
        curve: Curves.easeInOutCubic,
      );
    } else {
      storage.setWelcomeSeen();
      Get.offAllNamed(AppRoute.loginScreen);
    }
  }

  void skip() {
    SystemNavigator.pop();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  @override
  void onClose() {
    pageController.removeListener(_scrollListener);
    pageController.dispose();
    storage.onClose();
    super.onClose();
  }
}
