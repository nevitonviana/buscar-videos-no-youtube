import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';

import '/api.dart';
import '/models/video.dart';

class VideoBloc extends BlocBase {
  late final Api _api;
  late List<Video> videos;
  final StreamController<List<Video>> _videosController =
      StreamController<List<Video>>();

  VideoBloc() {
    _api = Api();
    _searchController.stream.listen((e) => _search(e));
  }

  Future<void> _search(String search) async {
    videos = await _api.search(search);
    _videosController.sink.add(videos);
  }

  Stream get outVideos => _videosController.stream;
  final StreamController<String> _searchController = StreamController<String>();

  Sink get isSearch => _searchController.sink;

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }
}
