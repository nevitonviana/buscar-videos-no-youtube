import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:buscavidedoyoutubecombloc/models/video.dart';

class FavoriteBloc extends BlocBase {
  Map<String, Video> _favorites = {};

  final StreamController<Map<String, Video>> _favcontroller =
      StreamController.broadcast();

  //
  Stream<Map<String, Video>> get outFav => _favcontroller.stream;

  void toggleFavorite(Video video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id] = video;
    }

    _favcontroller.sink.add(_favorites);
  }

  @override
  void dispose() {
    _favcontroller.close();
  }
}
