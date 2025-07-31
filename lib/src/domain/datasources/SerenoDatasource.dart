import 'package:app_sistema_de_patrullaje/src/domain/entities/SerenoEntity.dart';

abstract class SerenoDatasource {
  Future<SerenoEntity> login(String username, String password);
  Future<SerenoEntity> fetchSereno(String id);
}
