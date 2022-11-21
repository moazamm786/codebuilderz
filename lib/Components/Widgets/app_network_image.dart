import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final double? height, width;
  final bool isRounded;

  const AppNetworkImage({
    Key? key,
    required this.url,
    this.height,
    this.width,
    this.isRounded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: isRounded ? BoxShape.circle : BoxShape.rectangle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => SizedBox(
          width: width,
          height: height,
          child: const Center(child: CircularProgressIndicator())),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
