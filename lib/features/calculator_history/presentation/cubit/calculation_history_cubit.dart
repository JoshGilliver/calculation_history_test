import 'package:bloc/bloc.dart';
import '../../domain/usecases/add_calculation_history_entry.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/calculation_history_entry.dart';
import '../../domain/usecases/load_calculation_history.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'calculation_history_state.dart';

class CalculationHistoryCubit extends Cubit<CalculationHistoryState> {
  LoadCalculationHistory _loadCalculationHistory;
  AddCalculationHistoryEntry _addCalculationHistoryEntry;
  CalculationHistoryCubit(
      {@required LoadCalculationHistory loadCalculationHistory,
      @required AddCalculationHistoryEntry addCalculationHistoryEntry})
      : super(CalculationHistoryInitial()) {
    _loadCalculationHistory = loadCalculationHistory;
    _addCalculationHistoryEntry = addCalculationHistoryEntry;
    refreshCalculationHistory();
  }

  refreshCalculationHistory() async {
    emit(CalculationHistoryLoading());
    emit((await this._loadCalculationHistory(NoParams())).fold(
        (failure) => CalculationHistoryLoadError(
            'Failed to load calculation history', state.entries),
        (historyEntries) => CalculationHistoryLoaded(historyEntries
          ..sort(((a, b) => b.calculationDate.compareTo(a.calculationDate))))));
  }

  addEntry(CalculationHistoryEntry entry) async {
    (await this._addCalculationHistoryEntry(entry)).fold(
        (failure) =>
            CalculationHistoryLoadError('Failed to add entry', state.entries),
        (_) {
      final updatedEntries = [...state.entries, entry];
      emit(CalculationHistoryLoaded(updatedEntries));
    });
  }
}
