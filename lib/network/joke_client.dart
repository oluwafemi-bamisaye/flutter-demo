import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/Joke.dart';

Future<Joke> getJoke() async {
  final response = await http
      .get(Uri.parse('https://geek-jokes.sameerkumar.website/api?format=json'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Joke.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load a joke');
  }
}
