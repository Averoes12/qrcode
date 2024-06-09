part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}

final class ThemeStateDark extends ThemeState {}
final class ThemeStateLight extends ThemeState {}
final class ThemeStateLoading extends ThemeState {}
