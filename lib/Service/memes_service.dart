import 'dart:convert';
import 'dart:io';

import 'package:code_builderz_assignment/AppLocalData/app_local_data.dart';
import 'package:code_builderz_assignment/Controllers/memes_controller.dart';
import 'package:code_builderz_assignment/Models/memes_response.dart';
import 'package:code_builderz_assignment/Utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MemesService {
  Future<MemesResponse?> getMemesData() async {
    MemesController memesController = Get.find();

    try {
      // normally we have a generic service class with get/post methods as we have multi services
      // in out project, and pass only body and endpoint, but as here in this project only 1 service
      // required, so i didn't create separate service generic class file
      var data = await http.get(Uri.parse('${AppConstants.baseUrl}get_memes'));
      if (data.statusCode == 200) {
        var jsonData = json.decode(data.body);
        MemesResponse response = MemesResponse.fromJson(jsonData);
        // store response locally, update if already locally response exists
        AppLocalData().setStringPrefValue(
          key: SharedPrefConstants.memesResponse,
          value: json.encode(response),
        );
        memesController.setMemesResponse(response);
        return response;
      }
      // we can have more checks based on status code like 404 if required
    } on SocketException catch (_) {
      throw AppConstants.noInternetExceptionMessage;
    } catch (e) {
      throw AppConstants.defaultExceptionMessage;
    }
  }
}
