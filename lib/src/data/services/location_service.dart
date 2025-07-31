// lib/data/services/location_service.dart

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  /// Solicita permisos y obtiene la ubicación actual
  Future<Position?> getCurrentPosition() async {
    final permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  /// Obtiene dirección a partir de coordenadas
  Future<String> getAddressFromCoordinates(double lat, double lon) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lon);
      final place = placemarks.first;

      final address = [
        place.street,
        place.subLocality,
        place.locality,
        place.administrativeArea,
        place.country
      ].where((part) => part != null && part.isNotEmpty).join(', ');

      return address;
    } catch (e) {
      return 'Dirección no disponible';
    }
  }
}
