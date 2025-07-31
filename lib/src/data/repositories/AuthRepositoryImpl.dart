// Service
import 'package:app_sistema_de_patrullaje/src/data/dataSource/remote/services/AuthService.dart';

// Dominio
import 'package:app_sistema_de_patrullaje/src/domain/models/AuthResponse.dart';
import 'package:app_sistema_de_patrullaje/src/domain/models/SerenoModel.dart';
import 'package:app_sistema_de_patrullaje/src/domain/repositories/AuthRepository.dart';
import 'package:app_sistema_de_patrullaje/src/domain/utils/Resource.dart';
// import 'package:injectable/injectable.dart';

// @Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<Resource<AuthResponse>> login(String username, String password) {
    return _authService.login(username, password);
  }

  @override
  Future<Resource<AuthResponse>> register(SerenoModel sereno) {
    return _authService.register(sereno);
  }
}
