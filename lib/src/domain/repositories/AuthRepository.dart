import 'package:app_sistema_de_patrullaje/src/domain/models/AuthResponse.dart';
import 'package:app_sistema_de_patrullaje/src/domain/utils/Resource.dart';

// Model
import 'package:app_sistema_de_patrullaje/src/domain/models/SerenoModel.dart';

abstract class AuthRepository {
  Future<Resource<AuthResponse>> login(String username, String password);
  Future<Resource<AuthResponse>> register(SerenoModel sereno);
}
