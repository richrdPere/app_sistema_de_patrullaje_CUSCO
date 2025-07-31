import 'package:cloud_firestore/cloud_firestore.dart';

class IncidentEntity {
  final String description;
  final String? imageUrl;
  final String? videoUrl;
  final String? audioUrl;
  final double? latitude;
  final double? longitude;
  final String? address;
  final DateTime timestamp;
  final String userId;

  IncidentEntity({
    required this.description,
    this.imageUrl,
    this.videoUrl,
    this.audioUrl,
    this.latitude,
    this.longitude,
    this.address,
    required this.timestamp,
    required this.userId,
  });

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
