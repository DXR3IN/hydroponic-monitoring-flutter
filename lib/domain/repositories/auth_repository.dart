import 'package:hydroponic_mobile/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(String name, String email, String password);
  Future<UserEntity> me();
  Future<void> changePassword(String newPassword);
  Future<void> changeName(String newName);
  Future<void> logout();
}
