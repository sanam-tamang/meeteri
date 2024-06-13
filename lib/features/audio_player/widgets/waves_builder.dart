import 'package:flutter/material.dart';
import 'package:audio_wave/audio_wave.dart';

import '../utils/helper.dart';

class WavesBuilder extends StatelessWidget {
  const WavesBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AudioWave(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.8,
        spacing: 2.5,
        bars: Helper.generateAudioWaveBars(),
      ),
    );
  }
}
