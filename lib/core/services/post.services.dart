import 'dart:async';

import 'package:list/core/models/post.model.dart';

class _PostServices {
  late List<Post> post;
  late String name;
  final StreamController<List<Post>> _postStreamsController =
      StreamController<List<Post>>.broadcast();

  Stream<List<Post>> get postStream => _postStreamsController.stream;
  String get getName => name;

  void setName(String name) {
    this.name = name;
  }

  void setPost(List<Post> post) {
    this.post = post;
    _postStreamsController.add(this.post);
  }

  dispose() {
    _postStreamsController.close();
  }
}

final postServices = _PostServices();
