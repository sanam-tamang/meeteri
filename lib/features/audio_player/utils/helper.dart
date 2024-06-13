import 'package:audio_wave/audio_wave.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../utils/colors.dart';

class Helper {
  static List<AudioWaveBar> generateAudioWaveBars() {
    final List<AudioWaveBar> bars = [];
    final List<Color?> colors = [
      AppColors.blackColor,
      AppColors.medGreyColor,
      AppColors.greyColor,
      AppColors.blackColor,
    ];
    // Using random for random height of waves
    final Random random = Random();

    // Running for loop to build 50 bars
    for (int i = 1; i <= 50; i++) {
      // Random Height of each bar
      final double heightFactor = random.nextDouble();
      // Picking Colors for each bar as we have 4 colors
      final Color? color = colors[i % 4];

      if (color != null) {
        bars.add(AudioWaveBar(
          heightFactor: heightFactor,
          color: color,
        ));
      }
    }

    return bars;
  }
}
