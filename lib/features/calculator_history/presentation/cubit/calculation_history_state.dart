part of 'calculation_history_cubit.dart';

abstract class CalculationHistoryState extends Equatable {
  final List<CalculationHistoryEntry> entries;
  const CalculationHistoryState([this.entries = const []]);

  @override
  List<Object> get props => [];
}

class CalculationHistoryInitial extends CalculationHistoryState {}

class CalculationHistoryLoading extends CalculationHistoryState {}

class CalculationHistoryLoaded extends CalculationHistoryState {
  final List<CalculationHistoryEntry> entries;
  CalculationHistoryLoaded(this.entries) : super(entries);
}

class CalculationHistoryLoadError extends CalculationHistoryState {
  final String errorMessage;
  CalculationHistoryLoadError(
      this.errorMessage, List<CalculationHistoryEntry> entries)
      : super(entries);
}
