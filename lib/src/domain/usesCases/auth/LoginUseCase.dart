import 'package:injectable/injectable.dart';

// data
import 'package:app_sistema_de_patrullaje/src/data/repositories/AuthRepositoryImpl.dart';

// domain
import 'package:app_sistema_de_patrullaje/src/domain/repositories/AuthRepository.dart';


// @Injectable()
class LoginUseCase {

  // AuthRepository authRepository = AuthRepositoryImpl();

  AuthRepository reporitory;

  LoginUseCase(this.reporitory);

  run(String username, String password) => reporitory.login(username, password);
}