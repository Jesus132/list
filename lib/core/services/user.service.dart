import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:list/core/models/post.model.dart';
import 'package:list/core/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchUsers {
  Future<List<User>> fetchUsers() async {
    late List<User> listUsers = [];
    SharedPreferences storage = await SharedPreferences.getInstance();
    listUsers = await getUsers(storage);

    if (listUsers.isEmpty) {
      try {
        final res = await http
            .get(
              Uri.parse('https://jsonplaceholder.typicode.com/users'),
            )
            .timeout(const Duration(seconds: 20));

        if (res.statusCode == 200) {
          listUsers = userFromJson(res.body);
          await storage.setString('users', userToJson(listUsers));
          return listUsers;
        } else {
          return [];
        }
      } catch (e) {
        return [];
      }
    } else {
      return listUsers;
    }
  }

  fetchUserPosts(int id) async {
    late List<Post> listUserPosts = [];
    SharedPreferences storage = await SharedPreferences.getInstance();

    try {
      final res = await http
          .get(
            Uri.parse('https://jsonplaceholder.typicode.com/posts?userId=$id'),
          )
          .timeout(const Duration(seconds: 20));

      if (res.statusCode == 200) {
        final post = postFromJson(res.body);
        return post;
      } else {
        return [];
      }
    } catch (e) {
      return [];
      // response = await rootBundle.loadString('assets/Users.json');
    }
  }

  static Future<List<User>> getUsers(SharedPreferences storage) async {
    final users = await storage.getString('users') ?? '[]';
    return userFromJson(users);
  }
}
