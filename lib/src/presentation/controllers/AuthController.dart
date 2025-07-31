// import 'dart:js_interop';
import 'dart:convert'; // para jsonEncode


import 'package:app_sistema_de_patrullaje/src/domain/usesCases/auth/AuthUseCases.dart';
import 'package:app_sistema_de_patrullaje/src/domain/utils/Resource.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:app_sistema_de_patrullaje/src/data/datasources/RemoteSerenoDataSourceImpl.dart';
import 'package:app_sistema_de_patrullaje/src/data/repositories/SerenoRepositoryImpl.dart';

// Service
import 'package:app_sistema_de_patrullaje/src/data/dataSource/remote/services/AuthService.dart';

// Models
import 'package:app_sistema_de_patrullaje/src/domain/models/AuthResponse.dart';
import 'package:app_sistema_de_patrullaje/src/domain/models/SerenoModel.dart';

// Use cases
import 'package:app_sistema_de_patrullaje/src/domain/usesCases/auth/LoginUseCase.dart';


class AuthController with ChangeNotifier {
  
  // final AuthService _authService = AuthService();
  // LoginUseCase _loginUseCase = LoginUseCase();

  AuthUsesCases _authUsesCases;

  AuthController(this._authUsesCases);

  // final repository = SerenoRepositoryImpl(RemoteSerenoDataSourceImpl());

  SerenoModel? _sereno;
  SerenoModel? get sereno => _sereno;

  String? error;
  bool isLoading = false;

  Future<bool> login(String username, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      // final user = await repository.login(username, password);
      // final result = await _authService.login(username, password);
      final result = await _authUsesCases.login.run(username, password);

      if (result is Success<AuthResponse>) {
        final authResponse = result.data;

        _sereno =
            authResponse.user; // ← Debe venir el SerenoModel o SerenoEntity
        final token = authResponse.token;

        // Guardar en localstorage
        final prefs = await SharedPreferences.getInstance();
        final userJson = jsonEncode(_sereno!.toJson()); // Usa el toJson() real

        print('=================================================');
        print('Sereno DATA: ${userJson}');
        print('=================================================');

        await prefs.setString('sereno_data', userJson);
        await prefs.setString('sereno_token', token);

        error = null;
        return true;
      } else if (result is Error) {
        error = result.toString();
        return false;
      }

      error = 'Error desconocido';
      return false;

      // _sereno = user;

      // print('=================================================');
      // print('Sereno recibido DESDE DATASOURCES: ${user}');
      // print('=================================================');

      // // Guardar en localstorage
      // final prefs = await SharedPreferences.getInstance();
      // final userJson = jsonEncode(
      //   _sereno.toString(),
      // ); // Asegúrate que tu modelo tenga un método toJson()

      // await prefs.setString('sereno_data', userJson);

      // error = null;

      // return true;
    } catch (e) {
      error = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
