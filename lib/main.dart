import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'bloc/videos_bloc.dart';
import 'screens/home/home.dart';

void main() {
  runApp(const MyApp());
  // Api api = Api();
  // api.search("flutter");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [Bloc((i) => VideoBloc())],
      dependencies: [],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
