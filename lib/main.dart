// import 'package:background_fetch/background_fetch.dart';
import 'package:code_builderz_assignment/Screens/memes_screen_u_i.dart';
import 'package:code_builderz_assignment/Service/device_sound_status_manager.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    DeviceSoundStatusManager().toggleDeviceRingMode();
    return Future.value(true);
  });
}

main() async {
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  Workmanager().registerOneOffTask("task-identifier", "simpleTask",
      initialDelay: Duration(minutes: 1));
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
