import 'package:dio/dio.dart';
import 'package:hydroponic_mobile/core/error/exceptions.dart';
import 'package:hydroponic_mobile/core/network/api_client.dart';
import 'package:hydroponic_mobile/data/datasources/remote/auth_remote_data_source.dart';
import 'package:hydroponic_mobile/data/models/user_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  final String path = 'auth-service-v2';

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        '$path/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = response.data;

        final String? token = data['token'];
        if (token != null) {
          await secureStorage.saveToken(token);
        }
        return UserModel.fromJson(data['user']);
      }
      throw ServerException(
          'Login failed with status code: ${response.statusCode}');
    } on DioException catch (e) {
      // Convert Dio error ke custom Exception
      throw ServerException(e.response?.data['message'] ?? 'Login failed');
    } catch (e) {
      throw ServerException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    try {
      final response = await dio.post(
        '$path/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = response.data;

        final String? token = data['token'];
        if (token != null) {
          await secureStorage.saveToken(token);
        }
        return UserModel.fromJson(data['user']);
      }
      throw ServerException(
          'Registration failed with status code: ${response.statusCode}');
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'];

      throw ServerException(
          errorMessage ?? 'Internal Server Error or Network Issue');
    } catch (e) {
      throw ServerException(
          'An unexpected error occurred during registration.');
    }
  }

  @override
  Future<UserModel> me() async {
    try {
      final response = await dio.get('$path/auth/me');
      if (response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      }
      throw ServerException(
          'Failed to fetch user data: ${response.statusCode}');
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'];

      throw ServerException(
          errorMessage ?? 'Internal Server Error or Network Issue');
    } catch (e) {
      throw ServerException(
          'An unexpected error occurred during taking user info.');
    }
  }

  @override
  Future<void> changeName(String newName) async {
    try {
      final response =
          await dio.put('$path/api/me/name', data: {'new_name': newName});
      if (response.statusCode == 201) {
        return;
      }
      throw ServerException(
          'Failed to change name user data: ${response.statusCode}');
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'];

      throw ServerException(
          errorMessage ?? 'Internal Server Error or Network Issue');
    } catch (e) {
      throw ServerException('An unexpected error occurred during change name.');
    }
  }

  @override
  Future<void> changePassword(String newPassword) async {
    try {
      final response = await dio
          .put('$path/api/me/password', data: {'new_password': newPassword});

      if (response.statusCode == 201) {
        return;
      }

      throw ServerException(
          'Failed to change password user data: ${response.statusCode}');
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'];
      throw ServerException(
          errorMessage ?? 'Internal Server Error or Network Issue');
    } catch (e) {
      throw ServerException('An error occured when trying to change password');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dio.post('$path/auth/logout');
    } on DioException catch (_) {
    } finally {
      await secureStorage.deleteToken();
    }
  }
}
