import 'dart:io';
import 'package:app_sistema_de_patrullaje/src/presentation/pages/perfil/PerfilScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import '../../../presentation/controllers/IncidentController.dart';
import '../../../data/services/location_service.dart';

class ReporteIncidenteScreen extends StatefulWidget {
  const ReporteIncidenteScreen({super.key});

  @override
  State<ReporteIncidenteScreen> createState() => _ReporteIncidenteScreenState();
}

class _ReporteIncidenteScreenState extends State<ReporteIncidenteScreen> {
  final _storage =
      const FlutterSecureStorage(); // instancia segura para token/userId

  final TextEditingController _descriptionController = TextEditingController();
  final LocationService _locationService = LocationService();

  File? _imageFile;
  File? _videoFile;
  File? _audioFile;

  DateTime _currentTime = DateTime.now();
  Position? _position;
  String? _address;

  @override
  void initState() {
    super.initState();
    _initLocation();
    _startClock();
  }

  void _startClock() {
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (!mounted) return false;
      setState(() {
        _currentTime = DateTime.now();
      });
      return true;
    });
  }

  Future<void> _initLocation() async {
    final pos = await _locationService.getCurrentPosition();
    if (pos != null) {
      final dir = await _locationService.getAddressFromCoordinates(
        pos.latitude,
        pos.longitude,
      );
      setState(() {
        _position = pos;
        _address = dir;
      });
    }
  }

  Future<void> _pickMedia(ImageSource source, String type) async {
    final picker = ImagePicker();
    XFile? file;

    if (type == 'image') {
      file = await picker.pickImage(source: source);
    } else if (type == 'video') {
      file = await picker.pickVideo(source: source);
    }

    if (file != null) {
      setState(() {
        if (type == 'image') _imageFile = File(file!.path);
        if (type == 'video') _videoFile = File(file!.path);
      });
    }
  }

  Future<void> _sendReport() async {
    // Obtener userId del almacenamiento seguro

    final userId = await _storage.read(key: 'id');

    print("====================================");
    
    print("====================================");

    if (userId == null || _position == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: no se pudo identificar al usuario')),
      );
      return;
    }

    final controller = context.read<IncidentController>();

    await controller.reportIncident(
      description: _descriptionController.text,
      image: _imageFile,
      video: _videoFile,
      audio: _audioFile,
      position: _position!,
      address: _address,
      userId: userId,
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Reporte enviado con éxito')));

    _descriptionController.clear();

    setState(() {
      _imageFile = null;
      _videoFile = null;
      _audioFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final gps = _position;
    final now = _currentTime;
    final controller = context.watch<IncidentController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reportar Incidente',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: isDark ? Colors.blueGrey : Colors.blue,
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=5"),
            ),
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PerfilScreen()),
                ),
          ),
        ],
      ),
      body:
          controller.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      " ${_formatDate(now)}",
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 4),
                    if (gps != null)
                      Text(
                        " Lat: ${gps.latitude.toStringAsFixed(6)} | Lon: ${gps.longitude.toStringAsFixed(6)}",
                        style: const TextStyle(color: Colors.black),
                      )
                    else
                      const Text(
                        " Obteniendo ubicación...",
                        style: TextStyle(color: Colors.black),
                      ),
                    const SizedBox(height: 4),
                    if (_address != null)
                      Text(
                        " Dirección: $_address",
                        style: const TextStyle(color: Colors.black),
                      )
                    else
                      const Text(
                        " Obteniendo dirección...",
                        style: TextStyle(color: Colors.black),
                      ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Descripción del incidente',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16.0),
                    _imageFile != null
                        ? Image.file(
                          _imageFile!,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                        : Placeholder(
                          fallbackHeight: 200,
                          color: Colors.grey.shade300,
                        ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed:
                              () => _pickMedia(ImageSource.camera, 'image'),
                        ),
                        IconButton(
                          icon: Icon(Icons.image),
                          onPressed:
                              () => _pickMedia(ImageSource.gallery, 'image'),
                        ),
                        IconButton(
                          icon: Icon(Icons.videocam),
                          onPressed:
                              () => _pickMedia(ImageSource.camera, 'video'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Center(
                      child: GestureDetector(
                        onTap: _sendReport,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'ALERTA',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  String _formatDate(DateTime dt) {
    return "${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year} — "
        "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}";
  }
}

// class ReporteIncidenteScreen extends StatelessWidget {
//   const ReporteIncidenteScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
