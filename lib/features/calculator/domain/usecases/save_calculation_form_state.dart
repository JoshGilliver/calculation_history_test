import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/calculator_repository.dart';
import 'package:dartz/dartz.dart';

class SaveCalculationFormState extends UseCase<void, Map<String, double>> {
  final CalculatorRepository repository;
  SaveCalculationFormState(this.repository);
  @override
  Future<Either<Failure, void>> call(Map<String, double> formFields) {
    return repository.saveCalculationFormState(formFields);
  }
}
