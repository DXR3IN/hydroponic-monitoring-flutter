import 'package:hydroponic_mobile/domain/entities/user_entity.dart';
import 'package:hydroponic_mobile/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<UserEntity> call(String name, String email, String password) async {
    return await repository.register(name, email, password);
  }
}
