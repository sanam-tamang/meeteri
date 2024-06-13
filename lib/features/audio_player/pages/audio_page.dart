import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'library_page.dart';
import 'song_page.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SongPage(),
    );
  }
}
