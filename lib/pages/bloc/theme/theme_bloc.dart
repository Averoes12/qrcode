import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeStateLight()) {
    on<ThemeEventDark>((event, emit) async {
      emit(ThemeStateLoading());
      emit(ThemeStateDark());
    });
    on<ThemeEventLight>((event, emit) async {
      emit(ThemeStateLoading());
      emit(ThemeStateLight());
    });
  }
}
