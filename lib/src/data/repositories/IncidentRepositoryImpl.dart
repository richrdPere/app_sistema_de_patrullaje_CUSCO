import 'dart:io';

import 'package:app_sistema_de_patrullaje/src/data/datasources/IncidentDatasourceImpl.dart';
import 'package:app_sistema_de_patrullaje/src/domain/models/IncidentModel.dart';
import 'package:app_sistema_de_patrullaje/src/domain/entities/IncidentEntity.dart';
import 'package:app_sistema_de_patrullaje/src/domain/repositories/IncidentRepository.dart';


class IncidentRepositoryImpl implements IncidentRepository {
  final IncidentDataSourceImpl dataSource;

  IncidentRepositoryImpl(this.dataSource);

  @override
  Future<void> reportIncident(IncidentEntity entity) async {
    final model = IncidentModel(
      description: entity.description,
      imageUrl: entity.imageUrl,
      videoUrl: entity.videoUrl,
      audioUrl: entity.audioUrl,
      latitude: entity.latitude,
      longitude: entity.longitude,
      address: entity.address,
      timestamp: entity.timestamp,
      userId: entity.userId,
    );

    await dataSource.reportIncident(model);
  }

  @override
  Future<void> saveIncident(IncidentEntity incident) {
    // TODO: implement saveIncident
    throw UnimplementedError();
  }

  @override
  Future<String> uploadFile(File file, String path) {
    // TODO: implement uploadFile
    throw UnimplementedError();
  }
}
