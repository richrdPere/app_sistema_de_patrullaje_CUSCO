import 'package:app_sistema_de_patrullaje/src/domain/models/SerenoModel.dart';
import 'package:app_sistema_de_patrullaje/src/domain/repositories/AuthRepository.dart';

class RegisterUseCase {
  AuthRepository authRepository;

  RegisterUseCase(this.authRepository);

  run(SerenoModel sereno) => authRepository.register(sereno);
}
