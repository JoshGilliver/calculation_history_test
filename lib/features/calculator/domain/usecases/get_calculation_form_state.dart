import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/calculator_repository.dart';
import 'package:dartz/dartz.dart';

class GetCalculationFormState extends UseCase<Map<String, double>, NoParams> {
  final CalculatorRepository repository;

  GetCalculationFormState(this.repository);

  @override
  Future<Either<Failure, Map<String, double>>> call(NoParams params) {
    return this.repository.getCalculationFormState();
  }
}
