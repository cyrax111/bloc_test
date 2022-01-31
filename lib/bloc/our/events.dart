import 'package:equatable/equatable.dart';

import '../state.dart';
import 'bloc.dart';

abstract class CounterEvent extends Equatable {
  Stream<CounterState> applyAsync(
      {required CounterState currentState, required CounterBloc bloc});

  @override
  List<Object?> get props => [];
}

class FetchDataCounterEvent extends CounterEvent {
  @override
  Stream<CounterState> applyAsync(
      {required CounterState currentState, required CounterBloc bloc}) async* {
    yield currentState.copyWith(isFetchingData: true);
    await Future.delayed(const Duration(seconds: 5));
    yield currentState.copyWith(
        data: 'some important data', isFetchingData: false);
  }
}

class ButtonPushedCounterEvent extends CounterEvent {
  @override
  Stream<CounterState> applyAsync(
      {required CounterState currentState, required CounterBloc bloc}) async* {
    yield currentState.copyWith(buttonCount: currentState.buttonCount + 1);
  }
}
