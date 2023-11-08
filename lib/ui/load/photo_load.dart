import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../load/load_screen.dart';


class PhotoLoad extends StatelessWidget {
  final String url;
  final double? height, width, circular;
  final BoxFit? fit;
  final EdgeInsetsGeometry? paddingHeader;

  const PhotoLoad({Key? key, required this.url, this.fit, this.paddingHeader, this.height, this.width, this.circular}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(circular ?? 10),
        child: CachedNetworkImage(
            fadeInDuration: const Duration(seconds: 1),
            fadeOutDuration: const Duration(seconds: 2),
            imageUrl: url,
            height: height,
            width: width,
            fit: fit,
            progressIndicatorBuilder: (context, url, downloadProgress) => Padding(padding: paddingHeader ?? EdgeInsets.zero, child: const AppCircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error)));
  }
}
