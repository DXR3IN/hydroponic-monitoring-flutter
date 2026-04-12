import 'package:dio/dio.dart';
import 'package:hydroponic_mobile/core/error/exceptions.dart';
import 'package:hydroponic_mobile/data/datasources/remote/telemetry_remote_data_source.dart';
import 'package:hydroponic_mobile/data/models/telemetry_model.dart';

class TelemetryRemoteDataSourceImpl implements TelemetryRemoteDataSource {
  final Dio dio;
  final String path = 'telemetry-service-v2';

  TelemetryRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<TelemetryModel>> GetTelemetryByID(String deviceID) async {
    try {
      final response = await dio.get('$path/api/telemetry/$deviceID');

      if (response.statusCode == 201) {
        final List<Map<String, dynamic>> data = response.data;

        return data
            .map(
              (e) => TelemetryModel.fromJson(e),
            )
            .toList();
      }
      throw ServerException(
          'Get telemetry failed with status code: ${response.statusCode}');
    } on DioException catch (e) {
      throw ServerException("Dio failed to connect: ${e.message}");
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<TelemetryModel> GetLatestTelemetry(String deviceID) async {
    try {
      final response = await dio.get('$path/api/telemetry/$deviceID/latest');
      if (response.statusCode == 201) {
        final Map<String, dynamic> data = response.data;

        return TelemetryModel.fromJson(data);
      }
      throw ServerException(
          'Get latest data failed with status code: ${response.statusCode}');
    } on DioException catch (e) {
      throw ServerException('Dio failed to connect: ${e.message}');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
