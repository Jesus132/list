import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:list/core/models/post.model.dart';
import 'package:list/core/models/user.model.dart';

class FetchUsers {
  static List<User> getUsers(SharedPreferences storage) {
    final users = storage.getString('users') ?? '[]';
    return userFromJson(users);
  }

  Future<List<User>> fetchUsers() async {
    late List<User> listUsers = [];
    SharedPreferences storage = await SharedPreferences.getInstance();
    listUsers = getUsers(storage);

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
}

class _UserServices {
  late User user;

  User get getUser => user;

  void setUser(User user) {
    this.user = user;
  }
}

final userServices = _UserServices();
