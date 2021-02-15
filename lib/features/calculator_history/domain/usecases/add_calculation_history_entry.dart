import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/calculation_history_entry.dart';
import '../repositories/calculation_history_repository.dart';
import 'package:dartz/dartz.dart';

class AddCalculationHistoryEntry
    implements UseCase<void, CalculationHistoryEntry> {
  final CalculationHistoryRepository repository;
  AddCalculationHistoryEntry(this.repository);

  @override
  Future<Either<Failure, void>> call(CalculationHistoryEntry entry) {
    return repository.addCalculationHistory(entry);
  }
}
