import 'package:app_sistema_de_patrullaje/src/domain/entities/SerenoEntity.dart';

abstract class SerenoRepository {
  Future<SerenoEntity> login(String username, String password);
  Future<SerenoEntity> getSerenoById(String id);
  Future<void> logout();
}
