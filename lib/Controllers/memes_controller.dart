import 'dart:convert';

import 'package:code_builderz_assignment/AppLocalData/app_local_data.dart';
import 'package:code_builderz_assignment/Models/memes_response.dart';
import 'package:code_builderz_assignment/Service/memes_service.dart';
import 'package:get/state_manager.dart';

class MemesController extends GetxController {
  var memesList = <MemeData>[].obs;

  setMemesResponse(MemesResponse response) {
    // list is being cleared because if api is called silently, new coming data will append with old
    // data, so prevent this issue, list is being cleared
    memesList.clear();
    memesList.addAll(response.data!.memes!);
  }

  setMemesResponseLocally() async {
    final String? data = await AppLocalData()
        .getStringPrefValue(key: SharedPrefConstants.memesResponse);
    var jsonResponse = json.decode(data!);
    var response = MemesResponse.fromJson(jsonResponse);
    memesList.clear();
    memesList.addAll(response.data!.memes!);
    silentlyCallApi();
  }

  silentlyCallApi() {
    Future.delayed(const Duration(seconds: 10), () {
      MemesService().getMemesData();
    });
  }
}
