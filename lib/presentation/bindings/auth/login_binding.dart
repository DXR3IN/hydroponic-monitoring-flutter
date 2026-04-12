// presentation/bindings/login_binding.dart

import 'package:get/get.dart';
import 'package:hydroponic_mobile/domain/usecases/auth/login_usecase.dart';
import '../../controllers/auth/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(
        loginUseCase: Get.find<LoginUseCase>(),
      ),
    );
  }
}
