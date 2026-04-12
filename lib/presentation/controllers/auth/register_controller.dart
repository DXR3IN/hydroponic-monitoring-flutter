import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hydroponic_mobile/core/config/app_route.dart';
import 'package:hydroponic_mobile/core/error/failure.dart';
import 'package:hydroponic_mobile/domain/entities/user_entity.dart';
import 'package:hydroponic_mobile/domain/usecases/auth/register_usecase.dart';
import 'package:hydroponic_mobile/presentation/widgets/snackbar_helper.dart';

class RegisterController extends GetxController {
  final RegisterUsecase registerUsecase;

  // State Input
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  var isLoading = false.obs;
  var isAuthenticated = false.obs;
  var userEntity = Rxn<UserEntity>();

  var isPasswordVisible = false.obs;

  RegisterController({required this.registerUsecase});

  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;

    try {
      // final user = await registerUsecase.call(
      //   emailController.text,
      //   passwordController.text,
      //   usernameController.text,
      // );

      // userEntity.value = user;
      // isAuthenticated.value = true;
      Get.offAllNamed(AppRoute.defaultRoute);
    } on ServerFailure catch (f) {
      SnackbarHelper.showError(title: 'Registrasi Gagal', message: f.message);
    } catch (e) {
      SnackbarHelper.showError(
          title: 'Error',
          message: 'Terjadi kesalahan tak terduga: ${e.runtimeType}');
    } finally {
      isLoading.value = false;
    }
  }

  void goToLogin() {
    Get.offNamed(AppRoute.loginScreen);
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.onClose();
  }
}
