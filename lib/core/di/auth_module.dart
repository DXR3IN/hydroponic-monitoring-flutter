import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hydroponic_mobile/data/datasources/remote/auth_remote_data_source.dart';
import 'package:hydroponic_mobile/data/datasources/remote/auth_remote_data_source_impl.dart';
import 'package:hydroponic_mobile/data/repositories/auth_repository_impl.dart';
import 'package:hydroponic_mobile/domain/usecases/auth/change_name_usecase.dart';
import 'package:hydroponic_mobile/domain/usecases/auth/change_password_usecase.dart';
import 'package:hydroponic_mobile/domain/usecases/auth/login_usecase.dart';
import 'package:hydroponic_mobile/domain/usecases/auth/me_usecase.dart';
import 'package:hydroponic_mobile/domain/usecases/auth/register_usecase.dart';

void initAuthDepedencies() {
  Get.put<AuthRemoteDataSource>(
    AuthRemoteDataSourceImpl(dio: Get.find<Dio>()),
    permanent: true,
  );

  Get.put<AuthRepositoryImpl>(
    AuthRepositoryImpl(
      Get.find<AuthRemoteDataSource>(),
    ),
    permanent: true,
  );

  Get.lazyPut<LoginUseCase>(
    () => LoginUseCase(Get.find<AuthRepositoryImpl>()),
    fenix: true,
  );

  Get.lazyPut<RegisterUsecase>(
    () => RegisterUsecase(Get.find<AuthRepositoryImpl>()),
    fenix: true,
  );

  Get.lazyPut<ChangeNameUsecase>(
    () => ChangeNameUsecase(repository: Get.find<AuthRepositoryImpl>()),
    fenix: true,
  );

  Get.lazyPut<ChangePasswordUsecase>(
    () => ChangePasswordUsecase(repository: Get.find<AuthRepositoryImpl>()),
    fenix: true,
  );

  Get.lazyPut<MeUsecase>(
    () => MeUsecase(Get.find<AuthRepositoryImpl>()),
    fenix: true,
  );
}
