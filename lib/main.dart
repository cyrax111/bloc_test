import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_test/bloc/native/events.dart' as native;
import 'package:bloc_test/bloc/native/bloc.dart' as native;
import 'package:bloc_test/bloc/our/events.dart' as our;
import 'package:bloc_test/bloc/our/bloc.dart' as our;
import 'package:bloc_test/bloc/state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<native.CounterBloc>(
            create: (BuildContext context) => native.CounterBloc(),
          ),
          BlocProvider<our.CounterBloc>(
            create: (BuildContext context) => our.CounterBloc(),
          ),
        ],
        child: const MyHomePage(title: 'Push the button while fetching data'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Native approach:',
            ),
            BlocBuilder<native.CounterBloc, CounterState>(
              builder: (context, state) {
                return Info(
                  count: state.buttonCount,
                  countButton: () =>
                      BlocProvider.of<native.CounterBloc>(context).add(
                    native.ButtonPushedCounterEvent(),
                  ),
                  isFetching: state.isFetchingData,
                  fetchButton: () =>
                      BlocProvider.of<native.CounterBloc>(context).add(
                    native.FetchDataCounterEvent(),
                  ),
                );
              },
            ),
            const Padding(padding: EdgeInsets.only(top: 100)),
            const Text(
              'Our approach:',
            ),
            BlocBuilder<our.CounterBloc, CounterState>(
              builder: (context, state) {
                return Info(
                  count: state.buttonCount,
                  countButton: () =>
                      BlocProvider.of<our.CounterBloc>(context).add(
                    our.ButtonPushedCounterEvent(),
                  ),
                  isFetching: state.isFetchingData,
                  fetchButton: () =>
                      BlocProvider.of<our.CounterBloc>(context).add(
                    our.FetchDataCounterEvent(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    Key? key,
    required this.count,
    required this.isFetching,
    required this.countButton,
    required this.fetchButton,
  }) : super(key: key);

  final int count;
  final bool isFetching;
  final VoidCallback countButton;
  final VoidCallback fetchButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text('$count'),
              ElevatedButton(
                onPressed: countButton,
                child: const Text('Increment count'),
              )
            ],
          ),
          isFetching
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: fetchButton,
                  child: const Text('Fetch data'),
                ),
        ],
      ),
    );
  }
}
