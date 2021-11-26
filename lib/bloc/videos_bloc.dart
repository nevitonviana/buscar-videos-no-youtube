import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

import '/data/videos/videos_get.dart';
import '/models/video.dart';

class VideoBloc extends BlocBase {
  final ApiYouTube _api;

  VideoBloc(this._api) {
    _searchController.stream.listen((e) => _search(e));
  }

  late List<Video> videos;

  final StreamController<List<Video>> _videosController =
      StreamController<List<Video>>();

  Future<void> _search(String search) async {
    if (!search.contains("+=")) {
      _videosController.sink.add([]);
      videos = await _api.search(search);
    } else {
      videos += await _api.nextPage();
    }
    _videosController.sink.add(videos);
  }

  Stream get outVideos => _videosController.stream;
  final StreamController<String> _searchController = StreamController<String>();

  Sink get isSearch => _searchController.sink;
}
