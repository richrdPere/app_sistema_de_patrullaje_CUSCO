import 'package:app_sistema_de_patrullaje/src/domain/repositories/IncidentRepository.dart';
import 'package:app_sistema_de_patrullaje/src/domain/entities/IncidentEntity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class IncidentDataSourceImpl implements IncidentRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<void> saveIncident(IncidentEntity incident) async {
    await firestore.collection('incident_reports').add(incident.toMap());
  }

  @override
  Future<String> uploadFile(File file, String path) async {
    final ref = storage.ref().child(path);
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
  
  @override
  Future<void> reportIncident(IncidentEntity incident) {
    // TODO: implement reportIncident
    throw UnimplementedError();
  }
}
