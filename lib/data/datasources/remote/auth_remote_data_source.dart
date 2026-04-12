import 'package:hydroponic_mobile/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String name, String email, String password);
  Future<UserModel> me();
  Future<void> changeName(String newName);
  Future<void> changePassword(String newPassword);
  Future<void> logout();
}
