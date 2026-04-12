import 'package:get/get.dart';
import 'package:hydroponic_mobile/presentation/controllers/welcome_controller.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeController());
  }
}
