// import 'package:background_fetch/background_fetch.dart';
import 'package:code_builderz_assignment/AppLocalData/app_local_data.dart';
import 'package:code_builderz_assignment/Components/MemesComponent/memes_component.dart';
import 'package:code_builderz_assignment/Service/device_sound_status_manager.dart';
import 'package:code_builderz_assignment/Service/memes_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/memes_controller.dart';

class MemesScreenUI extends StatefulWidget {
  const MemesScreenUI({Key? key}) : super(key: key);

  @override
  State<MemesScreenUI> createState() => _MemesScreenUIState();
}

class _MemesScreenUIState extends State<MemesScreenUI> {
  late Future<bool> checkLocallyResponseExists;
  late Future getMemesData;

  late MemesController memesController;

  // Platform messages are asynchronous, so we initialize in an async method.
  /*Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    int status = await BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 15,
            stopOnTerminate: false,
            enableHeadless: true,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: NetworkType.NONE), (String taskId) async {
      // <-- Event handler
      // This is the fetch-event callback.
      print("[BackgroundFetch] Event received $taskId");
      // IMPORTANT:  You must signal completion of your task or the OS can punish your app
      // for taking too long in the background.
      BackgroundFetch.finish(taskId);
    }, (String taskId) async {
      // <-- Task timeout handler.
      // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
      print("[BackgroundFetch] TASK TIMEOUT taskId: $taskId");
      BackgroundFetch.finish(taskId);
    });
    print('[BackgroundFetch] configure success: $status');

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }*/

  @override
  void initState() {
    super.initState();
    // initPlatformState();
    memesController = Get.put(MemesController());
    checkLocallyResponseExists =
        AppLocalData().containsKey(key: SharedPrefConstants.memesResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memes List')),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        DeviceSoundStatusManager().toggleDeviceRingMode();
      }),
      body: FutureBuilder(
          future: checkLocallyResponseExists,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == false) {
              getMemesData = MemesService().getMemesData();
              return FutureBuilder(
                future: getMemesData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return const MemesComponent();
                  } else if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              );
            } else if (snapshot.data == true) {
              memesController.setMemesResponseLocally();
              return const MemesComponent();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
