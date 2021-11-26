import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '/models/video.dart';
import 'save_favorite_interface.dart';

class SharedPreferencesSaveData implements ISaveFavorite {
  @override
  Future<List?> get() async {
    late var _favorites = {};

    SharedPreferences.getInstance().then((value) {
      if (value.getKeys().contains('favorites')) {
        _favorites = jsonDecode(value.getString("favorites")!).map((k, v) {
          return MapEntry(k, Video.fromJson(v));
        }).cast<String, Video>();
        return _favorites;
      }
    });
  }

  @override
  Future<void> save(Map data) async {
    await SharedPreferences.getInstance().then(
        (value) async => await value.setString("favorites", jsonEncode(data)));
  }
}
