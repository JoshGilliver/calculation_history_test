import 'package:flutter/material.dart';

class CalculationHistoryEntry {
  final String calculation;
  final double result;
  final DateTime calculationDate;

  CalculationHistoryEntry(
      {@required this.calculation,
      @required this.result,
      @required this.calculationDate});
}
