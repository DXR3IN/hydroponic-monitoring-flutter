import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarHelper {
  // Konfigurasi umum
  static const int durationSeconds = 3;
  static const SnackPosition position = SnackPosition.BOTTOM;
  static const double borderRadius = 8.0;
  static const double margin = 10.0;
  
  static void showSuccess({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      duration: const Duration(seconds: durationSeconds),
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      borderRadius: borderRadius,
      margin: const EdgeInsets.all(margin),
      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
    );
  }

  static void showError({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      duration: const Duration(seconds: durationSeconds),
      backgroundColor: Colors.red.shade700,
      colorText: Colors.white,
      borderRadius: borderRadius,
      margin: const EdgeInsets.all(margin),
      icon: const Icon(Icons.error_outline, color: Colors.white),
    );
  }

  static void showWarning({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      duration: const Duration(seconds: durationSeconds),
      backgroundColor: Colors.orange.shade800,
      colorText: Colors.white,
      borderRadius: borderRadius,
      margin: const EdgeInsets.all(margin),
      icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
    );
  }

  static void showInfo({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      duration: const Duration(seconds: durationSeconds),
      backgroundColor: Colors.blue.shade700,
      colorText: Colors.white,
      borderRadius: borderRadius,
      margin: const EdgeInsets.all(margin),
      icon: const Icon(Icons.info_outline, color: Colors.white),
    );
  }
}