import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class CalculatorRepository {
  Future<Either<Failure, void>> saveCalculationFormState(
      Map<String, double> formFields);
  Future<Either<Failure, Map<String, double>>> getCalculationFormState();
}
