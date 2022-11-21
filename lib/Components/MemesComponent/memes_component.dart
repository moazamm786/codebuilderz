import 'package:code_builderz_assignment/Components/MemesComponent/meme_item_card_u_i.dart';
import 'package:code_builderz_assignment/Controllers/memes_controller.dart';
import 'package:code_builderz_assignment/Models/memes_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemesComponent extends StatelessWidget {
  const MemesComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MemesController controller = Get.find();
    return Obx(
      () {
        var list = controller.memesList;
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            MemeData memeData = list[index];
            return MemeItemCardUI(memeData: memeData);
          },
        );
      },
    );
  }
}
