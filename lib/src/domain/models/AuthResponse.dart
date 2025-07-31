// To parse this JSON data, do
//
//     final authResponse = authResponseFromJson(jsonString);

import 'dart:convert';

import 'package:app_sistema_de_patrullaje/src/domain/models/SerenoModel.dart';

AuthResponse authResponseFromJson(String str) => AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
    final String token;
    final SerenoModel user;

    AuthResponse({
        required this.token,
        required this.user,
    });

    factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        token: json["token"],
        user: SerenoModel.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
    };
}