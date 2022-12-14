import 'package:flutter/material.dart';

import 'package:list/core/models/post.model.dart';

class PostsCardItem extends StatelessWidget {
  final Post post;

  const PostsCardItem({Key? key, required this.post}) : super(key: key);

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
              0,
              10.0,
            ),
            blurRadius: 2.0,
            spreadRadius: 1.0,
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
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              post.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(post.body),
            ),
          ),
        ],
      ),
    );
  }
}
