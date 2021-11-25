import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'bloc/favorite_bloc.dart';
import 'bloc/videos_bloc.dart';
import 'data/http/http_client.dart';
import 'data/videos/videos_get.dart';
import 'screens/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideoBloc(i.get<HttpClient>())),
        Bloc((i) => FavoriteBloc()),
      ],
      dependencies: [
        Dependency((i) => Client()),
        Dependency((i) => HttpClient(i.getDependency<Client>())),
        Dependency((i) => ApiYouTube(i.get<HttpClient>())),
      ],
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
