// import 'package:app_sistema_de_patrullaje/src/domain/entities/SerenoEntity.dart';
// import 'package:app_sistema_de_patrullaje/src/domain/repositories/SerenoRepository.dart';
// import '../datasources/RemoteSerenoDataSourceImpl.dart';

// class SerenoRepositoryImpl implements SerenoRepository {
//   final RemoteSerenoDataSourceImpl remoteDataSource;

//   SerenoRepositoryImpl(this.remoteDataSource);

//   @override
//   Future<SerenoEntity> login(String username, String password) {
    
//     return remoteDataSource.login(username, password);
//   }

//   @override
//   Future<SerenoEntity> getSerenoById(String id) {
//     return remoteDataSource.fetchSereno(id);
//   }

//   Future<SerenoEntity> register(Map<String, dynamic> data) {
//     return remoteDataSource.register(data);
//   }

//   @override
//   Future<void> logout() async {
//     // Solo eliminar token local si lo usas.
//     return;
//   }
// }
