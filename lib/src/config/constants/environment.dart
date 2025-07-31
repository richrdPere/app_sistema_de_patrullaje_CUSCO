import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String movieDBkey = dotenv.env['THE_MOVIEDB_KEY'] ?? 'No hay api key';

  static String mainUrl =
      'https://ba-sistemapatrullaje-backend.onrender.com/api';

  static String companyName2 = 'Patrullaje';
  static String companySlogan = 'Administra el Cuerpo de Serenazgo';
}
