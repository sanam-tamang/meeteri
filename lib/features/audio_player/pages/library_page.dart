import 'package:flutter/material.dart';

import '../models/songs_model.dart';
import '../utils/colors.dart';
import '../widgets/album_container.dart';
import '../widgets/buttons_row.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  Song selectedSong = songs[1];
  bool isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: const Icon(
          Icons.chevron_left,
          color: AppColors.blackColor,
          size: 32,
        ),
        actions: const [
          Icon(
            Icons.search,
            color: AppColors.blackColor,
            size: 32,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            child: Column(
              children: [
                const AlbumContainer(),
                const ButtonsRow(),
                Expanded(
                  child: ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      Song song = songs[index];
                      bool isSelected = song == selectedSong;
                      return ListTile(
                        onTap: () {
                          setState(() {
                            selectedSong = song;
                          });
                        },
                        leading: isSelected
                            ? const Icon(
                                Icons.bar_chart,
                                color: AppColors.blackColor,
                              )
                            : Text(
                                song.audioNum,
                                style: const TextStyle(fontSize: 14),
                              ),
                        title: Text(
                          song.name,
                          style: TextStyle(
                              color: AppColors.blackColor.withOpacity(0.7),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        subtitle: Text(
                          '${song.producer} . ${song.time}',
                          style: const TextStyle(color: AppColors.greyColor),
                        ),
                        trailing: const Icon(
                          Icons.more_horiz,
                          color: AppColors.greyColor,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 70,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.blackColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(20)),
                    child: Image.asset('assets/images/albumbg.jpg'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedSong.name,
                        style: const TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        selectedSong.producer,
                        style: const TextStyle(
                          color: AppColors.lightGreyColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    selectedSong.isFav ? Icons.favorite : Icons.favorite_border,
                    color: AppColors.whiteColor,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isPlaying = !isPlaying;
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: AppColors.whiteColor,
                      ),
                      child: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                          color: AppColors.blackColor),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
