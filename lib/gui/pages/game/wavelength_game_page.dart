import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wavelength_defender/data/game/level_data.dart';
import 'package:wavelength_defender/data/repositories/game_repository.dart';
import 'package:wavelength_defender/domain/blocs/game/game_bloc.dart';
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
        "back": (context, game) => const Align(
              alignment: Alignment.topLeft,
              child: Material(
                  color: Colors.black, child: BackButton(color: Colors.white)),
            ),
        "pause": (context, game) => Align(
              alignment: Alignment.topRight,
              child:
                  BlocBuilder<GameBloc, GameState>(builder: (context, state) {
                bool isPaused = state.status == GameStatus.paused;
                return Material(
                  color: Colors.black,
                  child: IconButton(
                      onPressed: () {
                        if (isPaused) {
                          context.read<GameBloc>().add(ResumeButtonPressed());
                        } else {
                          context.read<GameBloc>().add(PauseButtonPressed());
                        }
                      },
                      icon: Icon(
                        isPaused ? Icons.play_arrow_rounded : Icons.pause,
                        color: Colors.white,
                      )),
                );
              }),
            )
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
