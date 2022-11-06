import 'package:flutter/material.dart';

import 'package:list/core/models/post.model.dart';
import 'package:list/core/services/user.service.dart';
import 'package:list/core/widgets/post-card-item.dart';
import 'package:list/core/widgets/card-list.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  Future<List<Post>> get() async {
    return await FetchUsers().fetchUserPosts(userServices.getUser.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: get(),
      builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: Text(userServices.getUser.name),
              ),
              body: SafeArea(
                bottom: false,
                child: ListView.builder(
                  cacheExtent: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) => AnimatedScrollViewItem(
                    child: PostsCardItem(post: snapshot.data![index]),
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox(
              height: 400.0,
              child: Center(
                child: Text('Post is empty'),
              ),
            );
          }
        }
      },
    );
  }
}
