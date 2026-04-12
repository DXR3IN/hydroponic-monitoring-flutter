import 'package:hydroponic_mobile/core/error/exceptions.dart';
import 'package:hydroponic_mobile/core/error/failure.dart';
import 'package:hydroponic_mobile/data/datasources/remote/device_remote_data_source.dart';
import 'package:hydroponic_mobile/data/datasources/remote/device_stream_data_source.dart';
import 'package:hydroponic_mobile/data/models/device_model.dart';
import 'package:hydroponic_mobile/domain/entities/device_entity.dart';
import 'package:hydroponic_mobile/domain/entities/device_status_entity.dart';
import 'package:hydroponic_mobile/domain/repositories/device_repository.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  final DeviceRemoteDataSource remoteDataSource;
  final DeviceStreamDataSource streamDataSource;

  DeviceRepositoryImpl(
      {required this.remoteDataSource, required this.streamDataSource});

  @override
  Future<DeviceEntity> createDevice(String deviceID, String deviceName) async {
    try {
      final DeviceModel deviceModel =
          await remoteDataSource.createDevice(deviceID, deviceName);
      return deviceModel.toEntity();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(
          'An unexpected error occurred during device operation: ${e.runtimeType}');
    }
  }

  @override
  Future<DeviceEntity> getDeviceWithID(String deviceID) async {
    try {
      final DeviceModel deviceModel =
          await remoteDataSource.getDeviceWithID(deviceID);
      return deviceModel.toEntity();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(
          'An unexpected error occurred during device operation: ${e.runtimeType}');
    }
  }

  @override
  Future<List<DeviceEntity>> listDevice() async {
    try {
      final List<DeviceModel> deviceModel = await remoteDataSource.listDevice();
      return deviceModel
          .map(
            (e) => e.toEntity(),
          )
          .toList();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(
          'An unexpected error occurred during device operation: ${e.runtimeType}');
    }
  }

  @override
  Future<void> deleteDeviceWithID(String deviceID) async {
    try {
      await remoteDataSource.deleteDeviceWithID(deviceID);
      return;
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(
          'An unexpected error occurred during device operation: ${e.runtimeType}');
    }
  }

  @override
  Future<DeviceEntity> updateDeviceNameWithID(
      String deviceID, String deviceName) async {
    try {
      final DeviceModel data =
          await remoteDataSource.updateDeviceNameWithID(deviceID, deviceName);
      return data.toEntity();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(
          'An unexpected error occurred during device operation: ${e.runtimeType}');
    }
  }

  @override
  Stream<DeviceStatusEntity> streamDeviceStatusUpdates() {
    return streamDataSource
        .streamDeviceStatus()
        .map((model) => model.toEntity());
  }
}
