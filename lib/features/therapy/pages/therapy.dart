import 'package:flutter/material.dart';
import 'package:meeteri/features/audio_player/pages/audio_page.dart';
import 'package:meeteri/features/therapy/pages/quote.dart';

class TherapyPage extends StatefulWidget {
  const TherapyPage({super.key});

  @override
  State<TherapyPage> createState() => _TherapyPageState();
}

class _TherapyPageState extends State<TherapyPage> {
  @override
  Widget build(BuildContext context) {
    return const AudioPage();
  }
}
