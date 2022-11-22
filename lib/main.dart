import 'package:code_builderz_assignment/Screens/memes_screen_u_i.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // GetMaterialApp is being added to show snackbar
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Code Builderz Assignment',
      home: MemesScreenUI(),
    );
  }
}
