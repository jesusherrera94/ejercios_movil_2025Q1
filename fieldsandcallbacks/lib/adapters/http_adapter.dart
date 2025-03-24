import 'package:http/http.dart' as http;

class HttpAdapter {

  final http.Client client;

  HttpAdapter({required this.client});

  Future<dynamic> getRequest() async {
    Uri url = Uri.https("official-joke-api.appspot.com", "/random_ten");

    http.Response response = await client.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

}