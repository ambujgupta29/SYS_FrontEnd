import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sys_mobile/common/screen_state.dart';

abstract class BaseBloc<E, S extends ScreenState> extends Bloc<E, S> {
  BaseBloc(S initialState) : super(initialState) {
    on((E event, Emitter<S> emit) => mapEventToState(event).forEach((element) {
          emit(element);
        }));
  }

  Stream<S> mapEventToState(E event) async* {
    try {
      final Stream<S> _stream = handleEvents(event);

      await for (final S screenState in _stream) {
        yield screenState;
      }
    } on Exception catch (_) {
      yield getErrorState();
    }
  }

  Stream<S> handleEvents(E event);
  S getErrorState();
}
