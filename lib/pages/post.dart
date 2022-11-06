import 'package:flutter/material.dart';

import 'package:list/core/models/post.model.dart';
import 'package:list/core/services/post.services.dart';
import 'package:list/core/widgets/post-card-item.dart';
import 'package:list/core/widgets/card-list.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: postServices.postStream,
      builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
        return snapshot.hasData
            ? Scaffold(
                appBar: AppBar(
                  title: Text(postServices.getName),
                ),
                body: SafeArea(
                  bottom: false,
                  child: ListView.builder(
                    cacheExtent: 0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 17, vertical: 20),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) => AnimatedScrollViewItem(
                      child: PostsCardItem(post: snapshot.data![index]),
                    ),
                  ),
                ),
              )
            : const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
      },
    );
  }
}
