import 'dart:io';

import 'package:flutter/services.dart';

import 'core/pages/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'core/pages/home.dart';
import 'features/calculator_history/data/models/calculation_history_entry_model.dart';
import 'features/calculator_history/presentation/cubit/calculation_history_cubit.dart';
import 'features/calculator_history/presentation/pages/calculation_history_page.dart';
import 'features/theme/presentation/cubit/theme_cubit/theme_cubit.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  Hive.registerAdapter<CalculationHistoryEntryModel>(
      CalculationHistoryEntryModelAdapter());

  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        cubit: sl<ThemeCubit>(),
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(primarySwatch: state.swatch),
            onGenerateRoute: (routeSettings) {
              switch (routeSettings.name) {
                case '/':
                  return _buildPageTransition(
                      _buildWithCalculationHistoryCubit(HomePage()));
                case '/history':
                  return _buildPageTransition(_buildWithCalculationHistoryCubit(
                      CalculationHistoryPage()));
                case '/settings':
                  return _buildPageTransition(SettingsPage());
                default:
                  return _buildPageTransition(
                      _buildWithCalculationHistoryCubit(HomePage()));
              }
            },
          );
        },
      ),
    );
  }
}

PageRoute _buildPageTransition(Widget route) {
  return Platform.isIOS
      ? CupertinoPageRoute(builder: (context) => route)
      : MaterialPageRoute(builder: (context) => route);
}

Widget _buildWithCalculationHistoryCubit(Widget child) {
  return BlocProvider<CalculationHistoryCubit>(
    create: (_) => sl<CalculationHistoryCubit>(),
    child: BlocListener<CalculationHistoryCubit, CalculationHistoryState>(
      listener: (context, state) {
        if (state is CalculationHistoryLoadError) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
          ));
        }
      },
      child: child,
    ),
  );
}
