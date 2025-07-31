import 'package:app_sistema_de_patrullaje/src/domain/usesCases/auth/LoginUseCase.dart';
import 'package:app_sistema_de_patrullaje/src/domain/usesCases/auth/RegisterUseCase.dart';
// import 'package:injectable/injectable.dart';

// @Injectable()
class AuthUsesCases {
  LoginUseCase login;
  RegisterUseCase register;

  AuthUsesCases({
    required this.login,
    required this.register
  });
}