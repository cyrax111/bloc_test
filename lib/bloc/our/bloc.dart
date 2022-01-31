import 'package:bloc/bloc.dart';

import '../state.dart';
import 'events.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState.init()) {
    on<CounterEvent>((event, emit) {
      return emit.forEach<CounterState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          // ignore: avoid_print
          print(error);
          return const CounterState.init();
        },
      );
    });
  }
}
