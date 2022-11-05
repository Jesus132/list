import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:list/core/models/post.model.dart';
import 'package:list/core/models/user.model.dart';

class FetchUsers {
  Future<List<User>> fetchUsers() async {
    late List<User> listUsers = [];

    try {
      final res = await http
          .get(
            Uri.parse('https://jsonplaceholder.typicode.com/users'),
          )
          .timeout(const Duration(seconds: 20));

      if (res.statusCode == 200) {
        listUsers = userFromJson(res.body);
        return listUsers;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
