import '../models/calculation_history_entry_model.dart';

import '../../../../core/utilities/with_cache_failure.dart';
import '../datasources/calculation_local_date_source.dart';
import '../../domain/entities/calculation_history_entry.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repositories/calculation_history_repository.dart';
import 'package:dartz/dartz.dart';

class CalculationHistoryRepositoryImpl
    with CacheFailureRequestMixin
    implements CalculationHistoryRepository {
  final CalculationHistoryLocalDataSource localDataSource;

  CalculationHistoryRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, void>> addCalculationHistory(
      CalculationHistoryEntry entry) async {
    return await withCacheFailureRequest(() async {
      return await localDataSource.addCalculationHistory(
          CalculationHistoryEntryModel.fromEntity(entry));
    });
  }

  @override
  Future<Either<Failure, List<CalculationHistoryEntry>>>
      loadCalculationHistory() async {
    return await withCacheFailureRequest(() async {
      final calculationHistory = await localDataSource.loadCalculationHistory();
      return calculationHistory;
    });
  }
}
