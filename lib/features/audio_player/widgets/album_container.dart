import 'package:flutter/material.dart';

import '../models/songs_model.dart';
import '../utils/colors.dart';

class AlbumContainer extends StatelessWidget {
  const AlbumContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: SizedBox(
              height: 150,
              width: 150,
              child: Image.asset(
                'assets/images/albumbg.jpg',
                fit: BoxFit.cover,
              )),
        ),
        Container(
          height: 150,
          width: 150,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Album . ${songs.length} songs . 2012',
                style:
                    const TextStyle(color: AppColors.greyColor, fontSize: 11),
              ),
              const Text(
                'Charcoal',
                style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'Brambles',
                style: TextStyle(color: AppColors.greyColor, fontSize: 16),
              ),
              const SizedBox(
                height: 35,
              ),
              const SizedBox(
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.library_music),
                    Icon(Icons.downloading),
                    Icon(Icons.pending),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
