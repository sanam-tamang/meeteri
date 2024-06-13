import 'package:flutter/material.dart';
import 'package:meeteri/common/image_resource.dart';

class AlbumImageContainer extends StatelessWidget {
  const AlbumImageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: 260,
      width: 260,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Image.asset(
        ImageResources.habitImagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
