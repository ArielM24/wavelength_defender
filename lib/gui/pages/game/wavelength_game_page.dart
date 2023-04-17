import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wavelength_defender/data/game/level_data.dart';
import 'package:wavelength_defender/data/repositories/game_repository.dart';
import 'package:wavelength_defender/domain/blocs/game/game_bloc.dart';
import 'package:wavelength_defender/gui/game/overlays/pause_button_overlay.dart';
import 'package:wavelength_defender/gui/game/overlays/pause_overlay.dart';
import 'package:wavelength_defender/gui/game/wavelength_game.dart';

class WavelengthGamePage extends StatelessWidget {
  final LevelData levelData;
  const WavelengthGamePage({super.key, required this.levelData});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: WavelengthGame(
          levelData: levelData, gameBloc: context.read<GameBloc>()),
      overlayBuilderMap: {
        "paused": (context, game) => const PauseOverlay(),
        "pause": (context, game) => const PauseButtonOverlay()
      },
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
