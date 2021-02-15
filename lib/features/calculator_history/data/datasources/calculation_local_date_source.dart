import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../../../core/utilities/with_cache_exception.dart';
import '../models/calculation_history_entry_model.dart';

abstract class CalculationHistoryLocalDataSource {
  Future<List<CalculationHistoryEntryModel>> loadCalculationHistory();
  Future<void> addCalculationHistory(CalculationHistoryEntryModel entry);
}

class CalculationHistoryLocalDataSourceImpl
    with CacheExceptionRequestMixin
    implements CalculationHistoryLocalDataSource {
  final Box<CalculationHistoryEntryModel> calculationHistoryBox;

  CalculationHistoryLocalDataSourceImpl(this.calculationHistoryBox);

  @override
  Future<void> addCalculationHistory(CalculationHistoryEntryModel entry) async {
    return await withCacheExceptionRequest(() async {
      if (calculationHistoryBox.isNotEmpty &&
          calculationHistoryBox.values.length >= 10) {
        _takeTenHistoryEntries();
      }
      return this.calculationHistoryBox.add(entry);
    });
  }

  @override
  Future<List<CalculationHistoryEntryModel>> loadCalculationHistory() async {
    return await withCacheExceptionRequest(() async {
      return this.calculationHistoryBox.values.toList();
    });
  }

  _takeTenHistoryEntries() {
    final descendingDates = calculationHistoryBox.values.toList()
      ..sort(((a, b) => b.calculationDate.compareTo(a.calculationDate)));
    final endList = descendingDates.take(9).toList();
    calculationHistoryBox.deleteAll(calculationHistoryBox.keys);
    calculationHistoryBox.addAll(endList);
  }
}
