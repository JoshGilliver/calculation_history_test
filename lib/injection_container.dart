import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'core/hive/constants.dart';
import 'features/calculator/data/datasources/calculator_local_data_source.dart';
import 'features/calculator/data/repositories/calculator_repository_impl.dart';
import 'features/calculator/domain/repositories/calculator_repository.dart';
import 'features/calculator/domain/usecases/get_calculation_form_state.dart';
import 'features/calculator/domain/usecases/save_calculation_form_state.dart';
import 'features/calculator/presentation/cubit/calculator_form_cubit.dart';
import 'features/calculator_history/data/datasources/calculation_local_date_source.dart';
import 'features/calculator_history/data/models/calculation_history_entry_model.dart';
import 'features/calculator_history/data/repositories/calculation_history_repository_impl.dart';
import 'features/calculator_history/domain/repositories/calculation_history_repository.dart';
import 'features/calculator_history/domain/usecases/add_calculation_history_entry.dart';
import 'features/calculator_history/domain/usecases/load_calculation_history.dart';
import 'features/calculator_history/presentation/cubit/calculation_history_cubit.dart';
import 'features/theme/presentation/cubit/theme_cubit/theme_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await initExternal();
  final themeBox = await Hive.openBox<int>(kThemeBoxKey);
  sl.registerLazySingleton<Box<int>>(() => themeBox);
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit(sl<Box<int>>()));
  await Future.wait([initCalculator(), initCalculatorHistory()]);
}

Future<void> initCalculator() async {
  // Bloc
  sl.registerFactory<CalculatorFormCubit>(() => CalculatorFormCubit(
      getCalculationFormState: sl(), saveCalculationFormState: sl()));

  // Use case
  sl.registerLazySingleton<GetCalculationFormState>(
      () => GetCalculationFormState(sl<CalculatorRepository>()));

  sl.registerLazySingleton<SaveCalculationFormState>(
      () => SaveCalculationFormState(sl<CalculatorRepository>()));

  // Hive box
  final box = await Hive.openBox<String>(kCalculationFormStateBoxKey);
  sl.registerLazySingleton<Box<String>>(() => box);

  //Repository
  sl.registerLazySingleton<CalculatorRepository>(
      () => CalculatorRepositoryImpl(sl<CalculatorLocalDataSource>()));

  // Data source
  sl.registerLazySingleton<CalculatorLocalDataSource>(
      () => CalculatorLocalDataSourceImpl(sl<Box<String>>()));
}

Future<void> initCalculatorHistory() async {
  // Bloc
  sl.registerFactory<CalculationHistoryCubit>(() => CalculationHistoryCubit(
      loadCalculationHistory: sl(), addCalculationHistoryEntry: sl()));

  // Use case
  sl.registerLazySingleton<AddCalculationHistoryEntry>(
      () => AddCalculationHistoryEntry(sl<CalculationHistoryRepository>()));

  sl.registerLazySingleton<LoadCalculationHistory>(
      () => LoadCalculationHistory(sl<CalculationHistoryRepository>()));

  // Hive box
  final box = await Hive.openBox<CalculationHistoryEntryModel>(
      kCalulcationHistoryBoxKey);
  sl.registerLazySingleton<Box<CalculationHistoryEntryModel>>(() => box);

  // Repository
  sl.registerLazySingleton<CalculationHistoryRepository>(() =>
      CalculationHistoryRepositoryImpl(
          sl<CalculationHistoryLocalDataSource>()));

  // Data source

  sl.registerLazySingleton<CalculationHistoryLocalDataSource>(() =>
      CalculationHistoryLocalDataSourceImpl(
          sl<Box<CalculationHistoryEntryModel>>()));
}

Future<void> initExternal() async {
  final applicationDirectory = await getApplicationDocumentsDirectory();
  Hive.init(applicationDirectory.path);
}
