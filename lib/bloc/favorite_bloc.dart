import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

import '/components/save/save_favorite/save_favorite_interface.dart';
import '/models/video.dart';

class FavoriteBloc extends BlocBase {
  final ISaveFavorite _saveFavorite;

  FavoriteBloc(this._saveFavorite) {
    _getFavorite();
  }

  Future<void> _getFavorite() async {
    _favorites = await _saveFavorite.get();
    _favoriteController.add(_favorites);
  }

  Map<String, Video> _favorites = {};

  final _favoriteController = BehaviorSubject<Map<String, Video>>();

  Stream<Map<String, Video>> get outFav => _favoriteController.stream;

  void toggleFavorite(Video video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }

    _favoriteController.sink.add(_favorites);

    _saveFav();
  }

  void _saveFav() {
    _saveFavorite.save(_favorites);
  }
}
