import 'package:get/get.dart';
import 'package:hydroponic_mobile/data/datasources/remote/telemetry_remote_data_source.dart';
import 'package:hydroponic_mobile/data/datasources/remote/telemetry_stream_data_source.dart';
import 'package:hydroponic_mobile/data/repositories/telemetry_repository_impl.dart';
import 'package:hydroponic_mobile/domain/usecases/telemetry/get_latest_stream_telemetry_usecase.dart';
import 'package:hydroponic_mobile/domain/usecases/telemetry/get_latest_telemetry_usecase.dart';
import 'package:hydroponic_mobile/domain/usecases/telemetry/get_telemetry_by_id_usecase.dart';

void initTelemetryDepedencies(){
  Get.lazyPut<TelemetryRepositoryImpl>(
    () => TelemetryRepositoryImpl(
        remoteDataSource: Get.find<TelemetryRemoteDataSource>(),
        streamDataSource: Get.find<TelemetryStreamDataSource>()),
    fenix: true,
  );

  Get.lazyPut<GetLatestStreamTelemetryUsecase>(
    () => GetLatestStreamTelemetryUsecase(
        repository: Get.find<TelemetryRepositoryImpl>()),
    fenix: true,
  );
  Get.lazyPut<GetLatestTelemetryUsecase>(
    () => GetLatestTelemetryUsecase(
        repository: Get.find<TelemetryRepositoryImpl>()),
    fenix: true,
  );
  Get.lazyPut<GetTelemetryByIdUsecase>(
    () => GetTelemetryByIdUsecase(
        repository: Get.find<TelemetryRepositoryImpl>()),
    fenix: true,
  );
}