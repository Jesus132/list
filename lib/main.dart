import 'package:flutter/material.dart';
import 'package:list/pages/post.dart';

import 'package:list/pages/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prueba de Ingreso',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/users',
      routes: {
        '/users': (_) => const UserPage(),
        '/post': (_) => const PostPage(),
      },
    );
  }
}
