import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/agify.dart';

const String _agifyBaseUrl = "https://api.agify.io/";

Future<User> getAge(String userName) async {

  Map<String, String> queryParams = {
    'name': userName
  };
  String queryString = Uri(queryParameters: queryParams).query;
  String mappedUrl = _agifyBaseUrl + '?' + queryString;

  final response = await http
      .get(Uri.parse(mappedUrl));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load an age');
  }
}
