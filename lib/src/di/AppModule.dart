import 'package:app_sistema_de_patrullaje/src/domain/usesCases/auth/AuthUseCases.dart';
import 'package:app_sistema_de_patrullaje/src/domain/usesCases/auth/LoginUseCase.dart';
import 'package:app_sistema_de_patrullaje/src/domain/usesCases/auth/RegisterUseCase.dart';
import 'package:injectable/injectable.dart';

import 'package:app_sistema_de_patrullaje/src/data/dataSource/local/SharedPref.dart';

// Data y Domain
import 'package:app_sistema_de_patrullaje/src/data/repositories/AuthRepositoryImpl.dart';
import 'package:app_sistema_de_patrullaje/src/domain/repositories/AuthRepository.dart';

// Services
import 'package:app_sistema_de_patrullaje/src/data/dataSource/remote/services/AuthService.dart';

@module
abstract class AppModule {
  @injectable
  // SharedPref get SharedPref => SharedPref();

  @injectable
  AuthService get authService => AuthService();

  @injectable
  AuthRepository get authRepository => AuthRepositoryImpl(authService);

  @injectable
  AuthUsesCases get authUseCases => AuthUsesCases(
    login: LoginUseCase(authRepository),
    register: RegisterUseCase(authRepository),
  );
}
