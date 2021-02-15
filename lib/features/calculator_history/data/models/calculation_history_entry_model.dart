import '../../domain/entities/calculation_history_entry.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'calculation_history_entry_model.g.dart';

@HiveType(typeId: 0)
class CalculationHistoryEntryModel extends CalculationHistoryEntry {
  @HiveField(0)
  final String calculation;
  @HiveField(1)
  final DateTime calculationDate;
  @HiveField(2)
  final double result;

  CalculationHistoryEntryModel(
      {@required this.calculation,
      @required this.result,
      @required this.calculationDate})
      : super(
            calculation: calculation,
            calculationDate: calculationDate,
            result: result);

  factory CalculationHistoryEntryModel.fromJson(Map<String, dynamic> json) {
    return CalculationHistoryEntryModel(
        calculation: json['calculation'],
        calculationDate: DateTime.tryParse(json['calculationDate']),
        result: json['result']);
  }

  toJson() {
    return {
      "calculation": this.calculation,
      "calculationDate": calculationDate
    };
  }

  static CalculationHistoryEntryModel fromEntity(
      CalculationHistoryEntry entryEntity) {
    return CalculationHistoryEntryModel(
        calculation: entryEntity.calculation,
        calculationDate: entryEntity.calculationDate,
        result: entryEntity.result);
  }
}
