import 'dart:convert';

import 'package:app_sistema_de_patrullaje/src/domain/utils/ListToString.dart';
import 'package:http/http.dart' as http;

// Environment
import 'package:app_sistema_de_patrullaje/src/config/constants/environment.dart'
    as url_backend;

// Models
import 'package:app_sistema_de_patrullaje/src/domain/models/SerenoModel.dart';

// Domain
import 'package:app_sistema_de_patrullaje/src/domain/models/AuthResponse.dart';
import 'package:app_sistema_de_patrullaje/src/domain/utils/Resource.dart';
// import 'package:injectable/injectable.dart';

// @Injectable()
class AuthService {
  final String baseUrl = url_backend.Environment.mainUrl;

  // *********************************************************
  // 1.- Login
  // *********************************************************
  Future<Resource<AuthResponse>> login(String username, String password) async {
    try {
      // 1.- URL Base
      Uri url = Uri.parse('$baseUrl/sereno/login_sereno');

      // 2.- Headers
      Map<String, String> headers = {'Content-Type': 'application/json'};

      // 3.- Body
      String body = json.encode({'username': username, 'password': password});

      // 4.- Response
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(data);

        return Success(authResponse);
      } else {
        return Error(data['error']);
      }
    } catch (error) {
      return Error(error.toString());
    }
  }

  // *********************************************************
  // 2.- Register
  // *********************************************************
  Future<Resource<AuthResponse>> register(SerenoModel newSereno) async {
    try {
      // 1.- URL Base
      Uri url = Uri.parse('$baseUrl/sereno/registro_sereno');

      // 2.- Headers
      Map<String, String> headers = {'Content-Type': 'application/json'};

      // 3.- Body
      String body = json.encode(newSereno.toJson());
      print('NUEVO URL: $url');

      // 4.- Response
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(data);

        // print('SUCCESS: ${authResponse.}');

        return Success(authResponse);
      } else {

        print('CUARTO PASO: $data');

        return Error(listToString(data['error']));
        // return Error(data['message']);
        // return Error(data['error']);
      }
    } catch (error) {
      // print('ERROR: $error');
      return Error(error.toString());
    }
  }
}
