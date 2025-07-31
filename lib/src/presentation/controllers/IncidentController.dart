import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:app_sistema_de_patrullaje/src/data/datasources/IncidentDatasourceImpl.dart';
import 'package:app_sistema_de_patrullaje/src/domain/datasources/ReportIncident.dart';
import 'package:app_sistema_de_patrullaje/src/domain/entities/IncidentEntity.dart';

class IncidentController extends ChangeNotifier {
  final ReportIncidentUseCase useCase;
  final IncidentDataSourceImpl dataSource;

  IncidentController(this.useCase, this.dataSource);

  bool isLoading = false;

  Future<void> reportIncident({
    required String description,
    File? image,
    File? video,
    File? audio,
    required Position position,
    required String userId,
    String? address,
  }) async {
    isLoading = true;
    notifyListeners();

    String? imageUrl, videoUrl, audioUrl;

    if (image != null) {
      imageUrl = await dataSource.uploadFile(
        image,
        'incident_reports/$userId/images/${DateTime.now().toIso8601String()}.jpg',
      );
    }

    if (video != null) {
      videoUrl = await dataSource.uploadFile(
        video,
        'incident_reports/$userId/videos/${DateTime.now().toIso8601String()}.mp4',
      );
    }

    if (audio != null) {
      audioUrl = await dataSource.uploadFile(
        audio,
        'incident_reports/$userId/audios/${DateTime.now().toIso8601String()}.mp3',
      );
    }

    final incident = IncidentEntity(
      description: description,
      imageUrl: imageUrl,
      videoUrl: videoUrl,
      audioUrl: audioUrl,
      latitude: position.latitude,
      longitude: position.longitude,
      address: address,
      timestamp: DateTime.now(),
      userId: userId,
    );

    await useCase.call(incident);

    isLoading = false;
    notifyListeners();
  }
}
