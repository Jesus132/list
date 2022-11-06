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
    // // get();
  }

  Future<List<User>> get() async {
    return await FetchUsers().fetchUsers();
  }

  void getPost(User user) async {
    Navigator.pushNamed(context, '/post');
    listUsersPost = await FetchUsers().fetchUserPosts(user.id);
    postServices.setName(user.name);
    postServices.setPost(listUsersPost);
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
              FutureBuilder(
                future: get(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 400.0,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                          cacheExtent: 0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 17, vertical: 20),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) =>
                              AnimatedScrollViewItem(
                            child: UsersCardItem(
                                users: snapshot.data![index], onPost: getPost),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox(
                        height: 400.0,
                        child: Center(
                          child: Text('List is empty'),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
