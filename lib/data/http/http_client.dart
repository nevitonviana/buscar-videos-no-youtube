import 'package:http/http.dart';

import 'http_server_interface.dart';

class HttpClient implements IHttpServer {
  final Client client;

  HttpClient(this.client);

  @override
  Future<dynamic> get(String url) async {
    return await client.get(Uri.parse(url));
  }
}
