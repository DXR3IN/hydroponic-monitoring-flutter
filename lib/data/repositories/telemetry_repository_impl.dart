import 'package:hydroponic_mobile/core/error/exceptions.dart';
import 'package:hydroponic_mobile/core/error/failure.dart';
import 'package:hydroponic_mobile/data/datasources/remote/telemetry_remote_data_source.dart';
import 'package:hydroponic_mobile/data/datasources/remote/telemetry_stream_data_source.dart';
import 'package:hydroponic_mobile/data/models/telemetry_model.dart';
import 'package:hydroponic_mobile/domain/entities/telemetry_entity.dart';
import 'package:hydroponic_mobile/domain/repositories/telemetry_repository.dart';

class TelemetryRepositoryImpl implements TelemetryRepository {
  final TelemetryRemoteDataSource remoteDataSource;
  final TelemetryStreamDataSource streamDataSource;

  TelemetryRepositoryImpl(
      {required this.remoteDataSource, required this.streamDataSource});

  @override
  Future<List<TelemetryEntity>> GetTelemetryByID(String deviceID) async {
    try {
      final List<TelemetryModel> data =
          await remoteDataSource.GetTelemetryByID(deviceID);
      return data
          .map(
            (e) => e.toEntity(),
          )
          .toList();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure('Un expected error caught: ${e.toString()}');
    }
  }

  @override
  Future<TelemetryEntity> GetLatestTelemetry(String deviceID) async {
    try {
      final TelemetryModel data =
          await remoteDataSource.GetLatestTelemetry(deviceID);
      return data.toEntity();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure('Un expected error caught: ${e.toString()}');
    }
  }

  @override
  Stream<TelemetryEntity> GetLatestStreamTelemetry(String deviceID) {
    return streamDataSource.getStreamLatestTelemetry(deviceID).map((model) => model.toEntity());
  }
}
