import 'package:flutter/material.dart';
import 'package:meeteri/common/image_resource.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(ImageResources.meeteriFullLogo),
            fit: BoxFit.contain),
      ),
    );
  }
}
