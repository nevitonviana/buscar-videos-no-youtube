import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:buscavidedoyoutubecombloc/components/save/save_favorite/shared_preferences_save_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        Bloc((i) => VideoBloc(i.get<ApiYouTube>())),
        Bloc((i) => FavoriteBloc(i.get<SharedPreferencesSaveData>())),
      ],
      dependencies: [
        Dependency((i) => Client()),
        Dependency((i) => HttpClient(i.getDependency<Client>())),
        Dependency((i) => ApiYouTube(i.getDependency<HttpClient>())),
        Dependency((i) => SharedPreferences.getInstance()),
        Dependency((i) => SharedPreferencesSaveData()),
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
