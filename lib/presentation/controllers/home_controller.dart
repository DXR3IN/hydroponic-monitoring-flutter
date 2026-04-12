import 'package:get/get.dart';
import 'package:hydroponic_mobile/domain/entities/device_entity.dart';
import 'package:hydroponic_mobile/domain/usecases/device/list_device_usecase.dart';

class HomeController extends GetxController {
  final ListDeviceUsecase listDeviceUsecase;

  HomeController({required this.listDeviceUsecase});

  Future<DeviceEntity?> getDeviceList() async {
    return null;
  }
}
