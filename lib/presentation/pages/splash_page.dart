import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hydroponic_mobile/core/config/app_style.dart';
import 'package:hydroponic_mobile/presentation/controllers/splash_controller.dart'; // Import your controller

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppStyle.mainColor,
        child: const Center(
          child: SizedBox(
            width: 160,
            height: 160,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Icon(
                    Icons.eco_outlined,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
