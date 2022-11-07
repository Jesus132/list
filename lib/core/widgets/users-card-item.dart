import 'package:flutter/material.dart';

import 'package:list/core/models/user.model.dart';

class UsersCardItem extends StatelessWidget {
  final User users;
  final ValueChanged<User> onPost;

  const UsersCardItem({Key? key, required this.users, required this.onPost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(
              5.0,
              5.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
          const BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                users.name,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.phone,
                color: Colors.green[900],
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Text(users.phone),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.mail,
                color: Colors.green[900],
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Text(users.email),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              InkWell(
                onTap: () => {onPost(users)},
                child: Text(
                  'VER PUBLICACIONES',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.green[900],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
