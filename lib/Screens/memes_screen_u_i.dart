// import 'package:background_fetch/background_fetch.dart';
import 'package:code_builderz_assignment/AppLocalData/app_local_data.dart';
import 'package:code_builderz_assignment/Components/MemesComponent/memes_component.dart';
import 'package:code_builderz_assignment/Service/device_ringer_status_manager.dart';
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

  @override
  void initState() {
    super.initState();
    DeviceRingerStatusManager().scheduleDeviceRinger();
    memesController = Get.put(MemesController());
    checkLocallyResponseExists =
        AppLocalData().containsKey(key: SharedPrefConstants.memesResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memes List')),
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
