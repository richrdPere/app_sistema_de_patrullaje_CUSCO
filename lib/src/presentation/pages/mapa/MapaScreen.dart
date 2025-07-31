import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:app_sistema_de_patrullaje/src/domain/entities/LocationEntity.dart';

class MapaScreen extends StatefulWidget {
  final LocationEntity initialLocation;

  const MapaScreen({super.key, this.initialLocation = const LocationEntity(latitude: -13.525, longitude: -71.972)});

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa en Tiempo Real')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        myLocationEnabled: true,
        onMapCreated: (controller) {
          mapController = controller;
        },
      ),
    );
  }
}

// class MapaScreen extends StatelessWidget {
//   const MapaScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
