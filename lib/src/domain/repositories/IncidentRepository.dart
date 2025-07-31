import 'dart:io';

// Entidades
import 'package:app_sistema_de_patrullaje/src/domain/entities/IncidentEntity.dart';

abstract class IncidentRepository {
  Future<void> saveIncident(IncidentEntity incident);
  Future<String> uploadFile(File file, String path);

  Future<void> reportIncident(IncidentEntity incident);
}
