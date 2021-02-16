import '../../../../core/utilities/with_cache_failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/repositories/calculator_repository.dart';
import '../datasources/calculator_local_data_source.dart';

class CalculatorRepositoryImpl
    with CacheFailureRequestMixin
    implements CalculatorRepository {
  final CalculatorLocalDataSource localDataSource;

  CalculatorRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, void>> saveCalculationFormState(
      Map<String, double> formFields) async {
    return withCacheFailureRequest<void>(() async {
      return await localDataSource.saveCalculationFormState(formFields);
    });
  }

  @override
  Future<Either<Failure, Map<String, double>>> getCalculationFormState() async {
    return withCacheFailureRequest<Map<String, double>>(() async {
      return await localDataSource.getCalculationFormState();
    });
  }
}
