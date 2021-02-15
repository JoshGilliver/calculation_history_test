import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/calculation_history_entry.dart';
import '../repositories/calculation_history_repository.dart';
import 'package:dartz/dartz.dart';

class LoadCalculationHistory
    implements UseCase<List<CalculationHistoryEntry>, NoParams> {
  final CalculationHistoryRepository repository;

  LoadCalculationHistory(this.repository);
  @override
  Future<Either<Failure, List<CalculationHistoryEntry>>> call(NoParams params) {
    return repository.loadCalculationHistory();
  }
}
