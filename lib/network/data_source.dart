import 'dart:convert';

import 'package:http/http.dart';
import 'package:pokemon/model/agify.dart';
import 'package:pokemon/network/rest_client.dart';

class RemoteDataSource {
  RestClient client = RestClient(Client());

  Future<User> userAge(String userName) async {
    final response = await client.getUserAge(userName: userName);
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Unable to get user age');
    }
  }

}