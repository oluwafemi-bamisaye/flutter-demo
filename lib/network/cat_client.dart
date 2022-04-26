import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/cat.dart';

const catApiBaseUrl = "https://cataas.com/";

Future<Cat> getRandomCat() async {

  final response = await http
      .get(Uri.parse(catApiBaseUrl + '/cat?json=true'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Cat.fromJson(catApiBaseUrl, jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load a picture');
  }
}
