import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  const CounterState({
    required this.data,
    required this.isFetchingData,
    required this.buttonCount,
  });
  const CounterState.init()
      : data = '',
        buttonCount = 0,
        isFetchingData = false;

  final String data;
  final bool isFetchingData;
  final int buttonCount;

  @override
  List<Object?> get props => [data, buttonCount, isFetchingData];

  CounterState copyWith({
    String? data,
    bool? isFetchingData,
    int? buttonCount,
  }) {
    return CounterState(
      data: data ?? this.data,
      isFetchingData: isFetchingData ?? this.isFetchingData,
      buttonCount: buttonCount ?? this.buttonCount,
    );
  }
}
