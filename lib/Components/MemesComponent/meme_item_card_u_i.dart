import 'package:code_builderz_assignment/Components/Widgets/app_network_image.dart';
import 'package:code_builderz_assignment/Models/memes_response.dart';
import 'package:flutter/material.dart';

class MemeItemCardUI extends StatelessWidget {
  final MemeData memeData;

  const MemeItemCardUI({Key? key, required this.memeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double imageSize = size.width * 0.15;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.005,
        horizontal: size.width * 0.02,
      ),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.015,
            horizontal: size.width * 0.03,
          ),
          child: Row(
            children: [
              AppNetworkImage(
                height: imageSize,
                width: imageSize,
                url: memeData.url!,
              ),
              SizedBox(width: size.width * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // We can wrap Text with FittedBox to reduce text size if there is no enough space
                    // to display text
                    Text(
                      '${memeData.name}',
                      style: const TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                    Text('${memeData.width} x ${memeData.height}'),
                    Text('${memeData.boxCount}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
