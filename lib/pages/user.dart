import 'package:flutter/material.dart';

import 'package:list/core/models/post.model.dart';
import 'package:list/core/models/user.model.dart';
import 'package:list/core/services/user.service.dart';
import 'package:list/core/services/post.services.dart';
import 'package:list/core/widgets/card-list.dart';
import 'package:list/core/widgets/users-card-item.dart';

class UserPage extends StatefulWidget {
  const UserPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UserPage();
  }
}

class _UserPage extends State<UserPage> {
  _UserPage();

  late List<User> listUsers = [];
  late List<Post> listUsersPost = [];

  @override
  void initState() {
    get();
  }

  void get() async {
    listUsers = await FetchUsers().fetchUsers();
    setState(() {});
  }

  void getPost(User user) async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prueba de Ingreso'),
      ),
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Buscar usuario',
                  ),
                  onChanged: (text) {
                    listUsers = listUsers
                        .where((item) => item.name
                            .toLowerCase()
                            .contains(text.toLowerCase()))
                        .toList();
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  cacheExtent: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
                  itemCount: listUsers.length,
                  itemBuilder: (context, index) => AnimatedScrollViewItem(
                    child:
                        UsersCardItem(users: listUsers[index], onPost: getPost),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
