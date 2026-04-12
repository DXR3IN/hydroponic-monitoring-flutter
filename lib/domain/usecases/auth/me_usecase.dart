import 'package:hydroponic_mobile/domain/entities/user_entity.dart';
import 'package:hydroponic_mobile/domain/repositories/auth_repository.dart';

class MeUsecase {
  final AuthRepository repository;

  MeUsecase(this.repository);

  Future<UserEntity> call() async {
    return await repository.me();
  }
}
