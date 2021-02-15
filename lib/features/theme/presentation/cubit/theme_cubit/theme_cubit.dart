import 'package:bloc/bloc.dart';
import '../../../../../core/hive/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  Box<int> _themeEntityBox;
  ThemeCubit(Box<int> themeEntityBox) : super(ThemeInitial(Colors.blue)) {
    this._themeEntityBox = themeEntityBox;
    _initTheme(_themeEntityBox).then((swatch) => emit(ThemeInitial(swatch)));
  }

  Future<MaterialColor> _initTheme(Box<int> themeEntityBox) async {
    int theme = themeEntityBox.get(kThemeBoxKey);
    if (theme == null) {
      await themeEntityBox.put(kThemeBoxKey, Colors.blue.value);
      theme = themeEntityBox.get(kThemeBoxKey);
    }
    return Colors.primaries.firstWhere((colour) => colour.value == theme);
  }

  void changeTheme(ColorSwatch swatch) {
    _themeEntityBox.put(kThemeBoxKey, swatch.value);
    emit(ThemeInitial(swatch));
  }
}
