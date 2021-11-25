import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/models/video.dart';

class FavoriteBloc extends BlocBase {
  FavoriteBloc() {
    SharedPreferences.getInstance().then((value) {
      if (value.getKeys().contains('favorites')) {
        _favorites = jsonDecode(value.getString("favorites")!).map((k, v) {
          return MapEntry(k, Video.fromJson(v));
        }).cast<String, Video>();
        _favcontroller.add(_favorites);
      }
    });
  }

  Map<String, Video> _favorites = {};

  final _favcontroller = BehaviorSubject<Map<String, Video>>();

  Stream<Map<String, Video>> get outFav => _favcontroller.stream;

  void toggleFavorite(Video video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }

    _favcontroller.sink.add(_favorites);

    _saveFav();
  }

  void _saveFav() {
    SharedPreferences.getInstance()
        .then((value) => value.setString("favorites", jsonEncode(_favorites)));
  }

  @override
  void dispose() {
    _favcontroller.close();
  }
}
