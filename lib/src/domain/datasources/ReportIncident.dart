import '../entities/IncidentEntity.dart';
import '../repositories/IncidentRepository.dart';

class ReportIncidentUseCase {
  final IncidentRepository repository;

  ReportIncidentUseCase(this.repository);

  Future<void> call(IncidentEntity incident) async {
    await repository.reportIncident(incident);
  }
}
