import 'package:get/get.dart';
import 'package:hydroponic_mobile/domain/usecases/auth/register_usecase.dart';
import 'package:hydroponic_mobile/presentation/controllers/auth/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(
        registerUsecase: Get.find<RegisterUsecase>(),
      ),
    );
  }
}
