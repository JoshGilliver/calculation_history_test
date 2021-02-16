part of 'calculator_form_cubit.dart';

final Map<String, TextEditingController> defaultFormFields = {
  'field_one': TextEditingController(text: ''),
  'field_two': TextEditingController(text: '')
};

abstract class CalculatorFormState extends Equatable {
  final Map<String, TextEditingController> formFields;
  const CalculatorFormState([this.formFields]);

  @override
  List<Object> get props => [formFields];
}

class CalculatorFormIdle extends CalculatorFormState {
  CalculatorFormIdle([Map<String, TextEditingController> formFields])
      : super(formFields ?? defaultFormFields);
  @override
  List<Object> get props => [formFields];
}

class CalculatorError extends CalculatorFormState {
  final String errorMessage;
  CalculatorError(
      this.errorMessage, Map<String, TextEditingController> formFields)
      : super(formFields);
  @override
  List<Object> get props => [errorMessage, formFields];
}

class CalculatorHasValue extends CalculatorFormState {
  final String calculation;
  final double result;

  CalculatorHasValue(this.calculation, this.result,
      Map<String, TextEditingController> formFields)
      : super(formFields);

  @override
  List<Object> get props => [result, formFields];
}
