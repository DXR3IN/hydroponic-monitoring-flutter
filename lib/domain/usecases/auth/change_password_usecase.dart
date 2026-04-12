import 'package:hydroponic_mobile/domain/repositories/auth_repository.dart';

class ChangePasswordUsecase {
  final AuthRepository repository;

  ChangePasswordUsecase({required this.repository});

  Future<void> call(String newPassword) async {
    return await repository.changePassword(newPassword);
  }
}
