import '../entities/LocationEntity.dart';
import '../repositories/LocationRepository.dart';

class GetCurrentLocation {
  final LocationRepository repository;

  GetCurrentLocation(this.repository);

  Future<LocationEntity> call() => repository.getCurrentLocation();
}
