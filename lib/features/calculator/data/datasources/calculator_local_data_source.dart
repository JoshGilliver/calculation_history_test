import 'dart:convert';

import '../../../../core/utilities/with_cache_exception.dart';
import 'package:hive/hive.dart';

import '../../../../core/hive/constants.dart';

abstract class CalculatorLocalDataSource {
  Future<void> saveCalculationFormState(Map<String, double> formFields);
  Future<Map<String, double>> getCalculationFormState();
}

class CalculatorLocalDataSourceImpl extends CacheExceptionRequestMixin
    implements CalculatorLocalDataSource {
  final Box<String> formStateBox;

  CalculatorLocalDataSourceImpl(this.formStateBox);

  @override
  Future<void> saveCalculationFormState(Map<String, double> formFields) async {
    withCacheExceptionRequest(() {
      final encodedMap = json.encode(formFields);
      formStateBox.put(kCalculationFormStateBoxKey, encodedMap);
    });
  }

  @override
  Future<Map<String, double>> getCalculationFormState() async {
    return await withCacheExceptionRequest(() {
      Map decodedMap =
          json.decode(formStateBox.get(kCalculationFormStateBoxKey));
      if (decodedMap != null) {
        decodedMap = Map<String, double>.from(decodedMap);
      }
      return decodedMap;
    });
  }
}
