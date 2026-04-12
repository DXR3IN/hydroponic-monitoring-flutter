import 'package:dio/dio.dart';
import 'package:hydroponic_mobile/core/error/exceptions.dart';
import 'package:hydroponic_mobile/data/datasources/remote/device_remote_data_source.dart';
import 'package:hydroponic_mobile/data/models/device_model.dart';

class DeviceRemoteDataSourceImpl implements DeviceRemoteDataSource {
  final Dio dio;
  final String path = 'device-service-v2';

  DeviceRemoteDataSourceImpl({required this.dio});

  @override
  Future<DeviceModel> createDevice(String deviceID, String deviceName) async {
    try {
      final response = await dio.post('$path/api/devices/',
          data: {'device_id': deviceID, 'device_name': deviceName});
      if (response.statusCode == 201) {
        final Map<String, dynamic> data = response.data;
        return DeviceModel.fromJson(data['data']);
      }
      throw ServerException(
          'Create device failed with status code: ${response.statusCode}');
    } on DioException catch (e) {
      throw ServerException('Dio failed on: ${e.error}');
    } catch (e) {
      throw ServerException('Server error');
    }
  }

  @override
  Future<List<DeviceModel>> listDevice() async {
    try {
      final response = await dio.get('$path/api/devices/');

      if (response.statusCode == 201) {
        final List<dynamic> jsonData = response.data['data'];
        final List<DeviceModel> data = jsonData
            .map((e) => DeviceModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return data;
      }
      throw ServerException(
          'Failed to get device data with status code: ${response.statusCode}');
    } on DioException catch (e) {
      throw ServerException('Dio failed on: ${e.error}');
    } catch (e) {
      throw ServerException('Server error');
    }
  }

  @override
  Future<DeviceModel> updateDeviceNameWithID(
      String deviceID, String deviceName) async {
    try {
      final response = await dio.put('$path/api/devices/$deviceID');

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = response.data;
        return DeviceModel.fromJson(data['data']);
      }
      throw ServerException(
          'Failed to update device data with status code: ${response.statusCode}');
    } on DioException catch (e) {
      throw ServerException('Dio failed on: ${e.error}');
    } catch (e) {
      throw ServerException('Server error');
    }
  }

  @override
  Future<DeviceModel> getDeviceWithID(String deviceID) async {
    try {
      final response = await dio.get('$path/api/devices/$deviceID');

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = response.data;
        return DeviceModel.fromJson(data['data']);
      }
      throw ServerException(
          'Failed to get device data with status code: ${response.statusCode}');
    } on DioException catch (e) {
      throw ServerException('Dio failed on: ${e.error}');
    } catch (e) {
      throw ServerException('Server error');
    }
  }

  @override
  Future<void> deleteDeviceWithID(String deviceID) async {
    try {
      final response = await dio.delete('$path/api/devices/$deviceID');

      if (response.statusCode == 201) {
        return;
      }
      throw ServerException(
          'Failed to delete device with status code: ${response.statusCode}');
    } on DioException catch (e) {
      throw ServerException('Dio failed on: ${e.error}');
    } catch (e) {
      throw ServerException('Server error');
    }
  }
}
