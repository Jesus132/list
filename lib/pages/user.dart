import 'package:flutter/material.dart';

import 'package:list/core/models/post.model.dart';
import 'package:list/core/models/user.model.dart';
import 'package:list/core/services/user.service.dart';
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
  late Future<List<User>> _future;
  late List<User> listUsers = [];
  late List<User> _listUsers = [];

  _UserPage();

  @override
  void initState() {
    super.initState();
    _future = get();
  }

  Future<List<User>> get() async {
    listUsers = await FetchUsers().fetchUsers();
    _listUsers = listUsers;
    return listUsers;
  }

  void getPost(User user) async {
    userServices.setUser(user);
    Navigator.pushNamed(context, '/post');
    setState(() {});
  }

  void filter(String text) {
    List<User> result = [];
    if (text.isEmpty) {
      result = _listUsers;
    } else {
      result = _listUsers
          .where((item) => item.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
    setState(() {
      listUsers = result;
    });
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
                  onChanged: ((text) => filter(text)),
                ),
              ),
              FutureBuilder(
                future: _future,
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
                          itemCount: listUsers.length,
                          itemBuilder: (context, index) =>
                              AnimatedScrollViewItem(
                            child: UsersCardItem(
                                users: listUsers[index], onPost: getPost),
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
