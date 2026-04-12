import 'package:get/get.dart';
import 'package:hydroponic_mobile/domain/usecases/device/list_device_usecase.dart';
import 'package:hydroponic_mobile/presentation/controllers/home_controller.dart';
import 'package:hydroponic_mobile/presentation/controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController());
    Get.lazyPut<HomeController>(
        () => HomeController(listDeviceUsecase: Get.find<ListDeviceUsecase>()));
  }
}
