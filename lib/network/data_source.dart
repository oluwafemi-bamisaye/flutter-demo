import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:pokemon/model/agify.dart';
import 'package:pokemon/network/rest_client.dart';

class RemoteDataSource {
  RestClient client = RestClient(Client());

  Future<User> userAge(String userName) async {
    final response = await client.getUserAge(userName: userName);
    if (response.statusCode == 200) {
      final user = User.fromJson(jsonDecode(response.body));
      if (kDebugMode) {
        print("userName == $userName : ${user.age}");
      }
      return user;
    } else {
      throw Exception('Unable to get user age');
    }
  }

}