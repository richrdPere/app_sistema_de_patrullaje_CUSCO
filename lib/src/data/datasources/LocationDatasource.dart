import 'package:geolocator/geolocator.dart';

class LocationDataSource {
  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition();
  }

  Stream<Position> getPositionStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
  }
}
