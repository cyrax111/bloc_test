import 'dart:async';
import 'package:bloc/bloc.dart';

import '../state.dart';
import 'events.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState.init()) {
    on<FetchDataCounterEvent>(_onFetchData);
    on<ButtonPushedCounterEvent>(_onButtonPushed);
  }

  Future<void> _onFetchData(
      FetchDataCounterEvent event, Emitter<CounterState> emit) async {
    emit(state.copyWith(isFetchingData: true));
    await Future.delayed(const Duration(seconds: 5));
    emit(state.copyWith(data: 'some important data', isFetchingData: false));
  }

  void _onButtonPushed(
      ButtonPushedCounterEvent event, Emitter<CounterState> emit) {
    emit(state.copyWith(buttonCount: state.buttonCount + 1));
  }
}
