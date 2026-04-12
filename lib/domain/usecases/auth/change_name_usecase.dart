import 'package:hydroponic_mobile/domain/repositories/auth_repository.dart';

class ChangeNameUsecase {
  final AuthRepository repository;

  ChangeNameUsecase({required this.repository});

  Future<void> call(String newName) async {
    return await repository.changeName(newName);
  }
}
