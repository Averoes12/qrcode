part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

final class ThemeEventDark extends ThemeEvent {}
final class ThemeEventLight extends ThemeEvent {}

