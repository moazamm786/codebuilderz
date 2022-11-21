import 'package:code_builderz_assignment/Screens/memes_screen_u_i.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Code Builderz Assignment',
      home: MemesScreenUI(),
    );
  }
}
