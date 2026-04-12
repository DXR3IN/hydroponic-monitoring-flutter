import 'package:flutter/material.dart';

class AppStyle {
  static const Color mainColor = Color(0xFF0B2E33);
  static const Color secondColor = Color(0xFF4F7C82);
  static const Color thirdColor = Color(0xFF93B1B5);
  static const Color fourtColor = Color(0xFFB8E3E9);

  static const Color textOnMain = Colors.white;
  static const Color textOnSecond = Color(0xFF063636);

  static Widget buildInputField(
    BuildContext context, {
    required double screenWidth,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    final fontSize = (screenWidth * 0.04).clamp(13.0, 16.0);
    final iconSize = (screenWidth * 0.055).clamp(18.0, 24.0);
    final vPadding = (screenWidth * 0.045).clamp(14.0, 18.0);
    final radius = (screenWidth * 0.04).clamp(12.0, 15.0);

    final customBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: const BorderSide(color: AppStyle.secondColor, width: 1.0),
    );

    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: TextStyle(color: AppStyle.textOnMain, fontSize: fontSize),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(
          color: AppStyle.textOnMain.withOpacity(0.5),
          fontSize: fontSize,
        ),
        prefixIcon: Icon(icon, color: AppStyle.secondColor, size: iconSize),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white.withOpacity(0.08),
        contentPadding: EdgeInsets.symmetric(
            vertical: vPadding, horizontal: screenWidth * 0.04),
        border: customBorder,
        enabledBorder: customBorder,
        focusedBorder: customBorder.copyWith(
          borderSide: const BorderSide(color: AppStyle.secondColor, width: 2.0),
        ),
        errorBorder: customBorder.copyWith(
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.0),
        ),
        focusedErrorBorder: customBorder.copyWith(
          borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
        ),
        errorStyle: const TextStyle(color: Colors.redAccent, height: 1.2),
      ),
    );
  }
}
