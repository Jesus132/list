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
    return Scaffold(
        appBar: AppBar(
          title: Text(userServices.getUser.name),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.mail,
                      color: Colors.green[900],
                      size: 24.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    Text(userServices.getUser.email),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                      color: Colors.green[900],
                      size: 24.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    Text(userServices.getUser.phone),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: get(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
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
                              horizontal: 4, vertical: 20),
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) =>
                              AnimatedScrollViewItem(
                            child: PostsCardItem(post: snapshot.data![index]),
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
              ),
            ],
          ),
        ));
  }
}
