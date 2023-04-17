import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/data/game/level_data.dart';
import 'package:wavelength_defender/gui/game/wavelength_game.dart';

class WavelengthGamePage extends StatelessWidget {
  final LevelData levelData;
  const WavelengthGamePage({super.key, required this.levelData});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: WavelengthGame(levelData: levelData),
      loadingBuilder: (_) => Center(
        child: Column(
          children: const [
            LinearProgressIndicator(),
            Text(
              "Loading",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
