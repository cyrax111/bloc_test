import 'package:equatable/equatable.dart';

abstract class CounterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchDataCounterEvent extends CounterEvent {}

class ButtonPushedCounterEvent extends CounterEvent {}
