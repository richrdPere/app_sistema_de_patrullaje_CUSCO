import 'package:app_sistema_de_patrullaje/src/domain/entities/IncidentEntity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class IncidentModel extends IncidentEntity {
  IncidentModel({
    required super.description,
    super.imageUrl,
    super.videoUrl,
    super.audioUrl,
    super.latitude,
    super.longitude,
    super.address,
    required super.timestamp,
    required super.userId,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'audioUrl': audioUrl,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'timestamp': Timestamp.fromDate(timestamp),
      'userId': userId,
    };
  }
}
