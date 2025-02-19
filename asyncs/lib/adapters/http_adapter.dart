import 'package:http/http.dart' as http;

class HttpAdapter {

  Future<dynamic> getRequest() async {
    Uri url = Uri.https("official-joke-api.appspot.com", "/random_ten");

    http.Response response = await http.get(url);
    return response.body;
  }

}