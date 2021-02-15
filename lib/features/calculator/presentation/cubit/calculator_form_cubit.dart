import 'package:bloc/bloc.dart';
import '../../../calculator_history/domain/entities/calculation_history_entry.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_calculation_form_state.dart';
import '../../domain/usecases/save_calculation_form_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'calculator_form_state.dart';

class CalculatorFormCubit extends Cubit<CalculatorFormState> {
  SaveCalculationFormState _saveCalculationFormState;
  CalculatorFormCubit({
    @required SaveCalculationFormState saveCalculationFormState,
    @required GetCalculationFormState getCalculationFormState,
  }) : super(CalculatorHasValue('', 0.0, defaultFormFields)) {
    _saveCalculationFormState = saveCalculationFormState;

    getCalculationFormState(NoParams()).then((formState) => formState.fold(
            (failure) => emit(CalculatorError(
                'Failed to load previous form state', state.formFields)),
            (formState) {
          Map<String, TextEditingController> formMap;
          if (formState != null && formState.entries.isNotEmpty) {
            formMap = formState.map((key, value) =>
                MapEntry<String, TextEditingController>(
                    key, TextEditingController(text: value.toString())));
          }
          emit(CalculatorFormIdle(formMap));
          sum();
        }));
  }

  CalculationHistoryEntry sum() {
    final formFieldValues = this.state.formFields.values.toList();
    String calculation = '';

    for (var i = 0; i < formFieldValues.length; i++) {
      final value = formFieldValues[i];
      if (i == 0) {
        calculation += '${value.text} + ';
      } else {
        calculation +=
            "${value.text + (i == formFieldValues.length - 1 ? '' : '+')}";
      }
    }

    final calculationResult = this
        .state
        .formFields
        .values
        .fold<double>(0, (s, t) => s + double.tryParse(t.text));
    emit(CalculatorHasValue(calculation, calculationResult, state.formFields));
    return CalculationHistoryEntry(
        calculation: calculation,
        result: calculationResult,
        calculationDate: DateTime.now());
  }

  void saveFormState() {
    final formFields = this.state.formFields.map((key, value) =>
        MapEntry<String, double>(key, double.tryParse(value.text) ?? 0.0));

    _saveCalculationFormState(formFields);
  }

  void clearCalculatedValue() {
    emit(CalculatorFormIdle(state.formFields));
  }
}
