part of 'theme_cubit.dart';

abstract class ThemeState extends Equatable {
  final ColorSwatch swatch;
  const ThemeState(this.swatch);

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {
  final ColorSwatch swatch;
  ThemeInitial(this.swatch) : super(swatch);
  @override
  List<Object> get props => [swatch];
}
