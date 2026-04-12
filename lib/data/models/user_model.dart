import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String token;

  const UserModel(
      {required super.name,
      required super.email,
      required super.createdAt,
      required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final userData = json['user'] ?? json;
    return UserModel(
        name: userData['name'] as String,
        email: userData['email'] as String,
        createdAt: userData['created_at'] as DateTime,
        token: json['token'] as String);
  }

  UserEntity toEntity() {
    return UserEntity(name: name, email: email, createdAt: createdAt);
  }
}
