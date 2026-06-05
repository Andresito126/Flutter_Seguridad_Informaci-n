import 'package:seguridad_flutter/features/auth/data/datasource/remote/api/auth_api.dart';
import 'package:seguridad_flutter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:seguridad_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:seguridad_flutter/features/auth/domain/usecases/login_usecase.dart';
import 'package:seguridad_flutter/features/auth/domain/usecases/register_usecase.dart';
import 'package:seguridad_flutter/features/auth/presentation/providers/login_provider.dart';
import 'package:seguridad_flutter/shared/di/app_container.dart';

class AuthModule {
  final AppContainer container;

  AuthModule(this.container);

  late final AuthApi authApi = AuthApi(apiClient: container.apiClient);
  late final AuthRepository authRepository = AuthRepositoryImpl(authApi: authApi);
  late final LoginUsecase loginUsecase = LoginUsecase(repository: authRepository);
  late final RegisterUsecase registerUsecase = RegisterUsecase(repository: authRepository);
  late final LoginProvider loginProvider = LoginProvider(loginUsecase, container.sessionProvider);
}