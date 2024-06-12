import 'dart:ui';

import 'package:flutter/material.dart';

class BlurImageBackgroundWidget extends StatelessWidget {
  const BlurImageBackgroundWidget.asset({
    super.key,
    required this.child,
    this.assetImageUrl,
    this.blur,
  }) : networkImage = null;

  const BlurImageBackgroundWidget.network({
    super.key,
    required this.child,
    this.networkImage,
    this.blur,
  }) : assetImageUrl = null;

  final Widget child;
  final String? assetImageUrl;
  final String? networkImage;
  final ({double x, double y})? blur;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade100,
          image: networkImage != null
              ? DecorationImage(
                  image: NetworkImage(networkImage!), fit: BoxFit.cover)
              : DecorationImage(
                  image: assetImageUrl != null
                      ? AssetImage(
                          assetImageUrl!,
                        )
                      : const AssetImage(
                          "assets/images/background3.jpg",
                        ),
                  fit: BoxFit.cover)),
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
                colors: [Colors.blueGrey, Colors.black45, Colors.indigo])),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur?.x ?? 5, sigmaY: blur?.y ?? 5),
          child: child,
        ),
      ),
    );
  }
}
