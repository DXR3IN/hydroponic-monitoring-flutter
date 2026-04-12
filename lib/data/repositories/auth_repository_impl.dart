// data/repositories/auth_repository_impl.dart
import 'package:hydroponic_mobile/core/error/exceptions.dart';
import 'package:hydroponic_mobile/core/error/failure.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../datasources/remote/auth_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final UserModel userModel = await remoteDataSource.login(email, password);
      return userModel.toEntity();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw const ServerFailure('An unexpected error occurred during login.');
    }
  }

  @override
  Future<UserEntity> register(
      String name, String email, String password) async {
    try {
      final UserModel userModel =
          await remoteDataSource.register(name, email, password);
      return userModel.toEntity();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw const ServerFailure('An unexpected error occurred during registration.');
    }
  }

  @override
  Future<UserEntity> me() async {
    try {
      final UserModel userModel = await remoteDataSource.me();
      return userModel.toEntity();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw const ServerFailure(
          'An unexpected error occurred while fetching user data.');
    }
  }

  @override
  Future<void> changeName(String newName) async {
    try {
      await remoteDataSource.changeName(newName);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw const ServerFailure(
          'An unexpected error occurred while changing the name.');
    }
  }

  @override
  Future<void> changePassword(String newPassword) async {
    try {
      await remoteDataSource.changePassword(newPassword);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw const ServerFailure(
          'An unexpected error occurred while changing the password.');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logout();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw const ServerFailure('An unexpected error occurred while logout.');
    }
  }
}
