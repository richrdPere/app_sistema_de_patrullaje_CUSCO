import 'package:app_sistema_de_patrullaje/src/domain/entities/LocationEntity.dart';
import 'package:app_sistema_de_patrullaje/src/domain/repositories/LocationRepository.dart';

import '../datasources/LocationDatasource.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource dataSource;

  LocationRepositoryImpl(this.dataSource);

  @override
  Future<LocationEntity> getCurrentLocation() async {
    final pos = await dataSource.getCurrentPosition();
    return LocationEntity(latitude: pos.latitude, longitude: pos.longitude);
  }

  @override
  Stream<LocationEntity> getLocationUpdates() {
    return dataSource.getPositionStream().map(
          (pos) => LocationEntity(latitude: pos.latitude, longitude: pos.longitude),
        );
  }
}
