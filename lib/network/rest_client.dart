import 'package:http/http.dart';

class RestClient {

  static const String _agifyBaseUrl = "https://api.agify.io/";

  final Client _client;
  RestClient(this._client);

  Future<Response> getUserAge({required String userName}) async {
    Map<String, String> queryParams = {
      'name': userName
    };
    String queryString = Uri(queryParameters: queryParams).query;
    String mappedUrl = _agifyBaseUrl + '?' + queryString;
    return _client.get(Uri.parse(mappedUrl));
  }

}