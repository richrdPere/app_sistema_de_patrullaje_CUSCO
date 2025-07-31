import 'package:app_sistema_de_patrullaje/src/domain/entities/LocationEntity.dart';


abstract class LocationRepository {
  Future<LocationEntity> getCurrentLocation();
  Stream<LocationEntity> getLocationUpdates();
}
