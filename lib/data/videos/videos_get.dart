import '/core/keys/keys.dart';
import '/data/http/http_server_interface.dart';
import '/models/video.dart';

class ApiYouTube {
  String _search = '';
  String _nextToken = '';

  final IHttpServer _server;

  ApiYouTube(this._server);

  Future<List<Video>> search(String search) async {
    _search = search;
    final response = await _server.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$apiKey&maxResults=10");
    return decode(response);
  }

  Future<List<Video>> nextPage() async {
    final response = await _server.get(
      "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$apiKey&maxResults=10&pageToken=$_nextToken",
    );
    return decode(response);
  }

  List<Video> decode(var response) {
    _nextToken = response["nextPageToken"];
    List<Video> video =
        response['items'].map<Video>((map) => Video.fromJson(map)).toList();

    return video;
  }
}
