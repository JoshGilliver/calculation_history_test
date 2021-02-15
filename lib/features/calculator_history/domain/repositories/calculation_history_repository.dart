import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/calculation_history_entry.dart';

abstract class CalculationHistoryRepository {
  Future<Either<Failure, List<CalculationHistoryEntry>>>
      loadCalculationHistory();
  Future<Either<Failure, void>> addCalculationHistory(
      CalculationHistoryEntry entry);
}
