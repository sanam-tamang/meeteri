import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/songs_model.dart';
import '../utils/colors.dart';
import '../widgets/album_image_container.dart';
import '../widgets/waves_builder.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  Song selectedSong = songs[1];
  bool isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: const Icon(
          Icons.expand_more,
          color: AppColors.blackColor,
        ),
        title: const Text(
          'Now Playing',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Icon(
            Icons.library_music_rounded,
            color: AppColors.blackColor,
            size: 26,
          ),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Column(
            children: [
              const AlbumImageContainer(),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    selectedSong.isFav ? Icons.favorite : Icons.favorite_border,
                    color: AppColors.greyColor,
                    size: 30,
                  ),
                  Text(
                    selectedSong.name,
                    style: const TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    Icons.more_horiz,
                    color: AppColors.greyColor,
                    size: 30,
                  ),
                ],
              ),
              Text(
                selectedSong.producer,
                style: const TextStyle(
                    color: AppColors.greyColor,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 24,
              ),
              const WavesBuilder(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('1:03'),
                    Text(selectedSong.time),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.shuffle),
                    const Icon(Icons.skip_previous),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isPlaying = !isPlaying;
                        });
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                            color: AppColors.blackColor,
                            shape: BoxShape.circle),
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Icon(Icons.skip_next),
                    const Icon(CupertinoIcons.repeat),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
