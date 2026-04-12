import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hydroponic_mobile/core/config/app_route.dart';
import 'package:hydroponic_mobile/core/error/failure.dart';
import 'package:hydroponic_mobile/domain/usecases/auth/login_usecase.dart';
import 'package:hydroponic_mobile/presentation/widgets/snackbar_helper.dart';
import '../../../../domain/entities/user_entity.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  // State Input
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  var isLoading = false.obs;
  var isAuthenticated = false.obs;
  var userEntity = Rxn<UserEntity>();

  var isPasswordVisible = false.obs;

  LoginController({required this.loginUseCase});

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    try {
      // final user = await loginUseCase.call(
      //   emailController.text,
      //   passwordController.text,
      // );

      // userEntity.value = user;
      // isAuthenticated.value = true;
      Get.offAllNamed(AppRoute.defaultRoute);
    } on ServerFailure catch (f) {
      SnackbarHelper.showError(title: 'Login Gagal', message: f.message);
    } catch (e) {
      SnackbarHelper.showError(
          title: 'Error',
          message: 'Terjadi kesalahan tak terduga: ${e.runtimeType}');
    } finally {
      isLoading.value = false;
    }
  }

  void goToRegister() {
    Get.offNamed(AppRoute.registerScreen);
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
