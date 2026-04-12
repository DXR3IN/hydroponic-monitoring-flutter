class UserEntity {
  final String email;
  final String name;
  final DateTime createdAt;

  const UserEntity({
    required this.email,
    required this.name,
    required this.createdAt,
  });
}
