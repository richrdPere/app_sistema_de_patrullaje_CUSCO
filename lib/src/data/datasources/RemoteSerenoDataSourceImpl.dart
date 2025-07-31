// import 'dart:convert';
// import 'package:app_sistema_de_patrullaje/src/domain/datasources/SerenoDatasource.dart';
// import 'package:app_sistema_de_patrullaje/src/domain/entities/SerenoEntity.dart';
// import 'package:http/http.dart' as http;

// // Models
// import 'package:app_sistema_de_patrullaje/src/domain/models/SerenoModel.dart';


// // Environment
// import 'package:app_sistema_de_patrullaje/src/config/constants/environment.dart';

// class RemoteSerenoDataSourceImpl implements SerenoDatasource {
//   final String baseUrl = Environment.mainUrl;

//   @override
//   Future<SerenoEntity> login(String username, String password) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/sereno/login_sereno'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'username': username, 'password': password}),
//     );


//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);

//       return SerenoModel.fromJson(data);
//     } else {
//       final error = jsonDecode(response.body);
//       throw Exception(error['error'] ?? 'Error en el login');
//     }
//   }

//   @override
//   Future<SerenoEntity> fetchSereno(String id) async {
//     final response = await http.get(Uri.parse('$baseUrl/$id'));

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return SerenoModel.fromJson(data);
//     } else {
//       throw Exception('No se pudo obtener el sereno');
//     }
//   }

//   Future<SerenoEntity> register(Map<String, dynamic> data) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/registro_sereno'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(data),
//     );

//     if (response.statusCode == 201 || response.statusCode == 200) {
//       final resData = jsonDecode(response.body);
//       return SerenoModel.fromJson(resData['user']);
//     } else {
//       throw Exception('Error al registrar');
//     }
//   }
// }
