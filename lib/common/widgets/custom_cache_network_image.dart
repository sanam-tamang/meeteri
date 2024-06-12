// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class CustomCacheNetworkImage extends StatelessWidget {
  const CustomCacheNetworkImage({
    super.key,
    this.imageUrl,
    this.fit = BoxFit.contain, this.borderRadius,
  });
  final String? imageUrl;
  final BoxFit fit;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius??0),
            child: CachedNetworkImage(
              fit: fit,
              imageUrl: imageUrl!,
              placeholder: (context, url) => Container(
                color: const Color.fromRGBO(238, 238, 238, 1),
              ),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
          )
        : Container(
            color: Colors.grey.shade200,
          );
  }
}
