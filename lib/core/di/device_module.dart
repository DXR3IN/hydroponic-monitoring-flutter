import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hydroponic_mobile/data/datasources/remote/device_remote_data_source.dart';
import 'package:hydroponic_mobile/data/datasources/remote/device_remote_data_source_impl.dart';
import 'package:hydroponic_mobile/data/datasources/remote/device_stream_data_source.dart';
import 'package:hydroponic_mobile/data/datasources/remote/device_stream_data_source_impl.dart';
import 'package:hydroponic_mobile/data/repositories/device_repository_impl.dart';
import 'package:hydroponic_mobile/domain/usecases/device/create_device_usecase.dart';
import 'package:hydroponic_mobile/domain/usecases/device/delete_device_with_id_usecase.dart';
import 'package:hydroponic_mobile/domain/usecases/device/get_device_status_stream_usecase.dart';
import 'package:hydroponic_mobile/domain/usecases/device/get_device_with_id_usecase.dart';
import 'package:hydroponic_mobile/domain/usecases/device/list_device_usecase.dart';
import 'package:hydroponic_mobile/domain/usecases/device/update_device_name_with_id_usecase.dart';

void initDeviceDepedencies() {
  Get.lazyPut<DeviceRemoteDataSource>(
    () => DeviceRemoteDataSourceImpl(dio: Get.find<Dio>()),
  );
  Get.lazyPut<DeviceStreamDataSource>(
    () => DeviceStreamDataSourceImpl(),
  );
  Get.lazyPut<DeviceRepositoryImpl>(
    () => DeviceRepositoryImpl(
        remoteDataSource: Get.find<DeviceRemoteDataSource>(),
        streamDataSource: Get.find<DeviceStreamDataSource>()),
    fenix: true,
  );

  Get.lazyPut<CreateDeviceUsecase>(
    () => CreateDeviceUsecase(repository: Get.find<DeviceRepositoryImpl>()),
    fenix: true,
  );
  Get.lazyPut<DeleteDeviceWithIdUsecase>(
    () =>
        DeleteDeviceWithIdUsecase(repository: Get.find<DeviceRepositoryImpl>()),
    fenix: true,
  );
  Get.lazyPut<GetDeviceStatusStreamUsecase>(
    () => GetDeviceStatusStreamUsecase(Get.find<DeviceRepositoryImpl>()),
    fenix: true,
  );
  Get.lazyPut<GetDeviceWithIdUsecase>(
    () => GetDeviceWithIdUsecase(repository: Get.find<DeviceRepositoryImpl>()),
    fenix: true,
  );
  Get.lazyPut<ListDeviceUsecase>(
    () => ListDeviceUsecase(repository: Get.find<DeviceRepositoryImpl>()),
    fenix: true,
  );
  Get.lazyPut<UpdateDeviceNameWithIdUsecase>(
    () => UpdateDeviceNameWithIdUsecase(
        repository: Get.find<DeviceRepositoryImpl>()),
    fenix: true,
  );
}
