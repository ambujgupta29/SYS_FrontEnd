import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sys_mobile/common/screen_state.dart';

abstract class BaseBlocEmit<E, S extends ScreenState> extends Bloc<E, S> {
  BaseBlocEmit(S initialState) : super(initialState) {
    on<E>(eventHandler);
  }

  Future<void> eventHandler(E event, Emitter<S> emit) async {
    try {
      await handleEvents(event, emit);
    } on Exception catch (_) {
      emit(getErrorState());
    }
  }

  Future<void> handleEvents(E event, Emitter<S> emit);

  S getErrorState();
}
