import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wavelength_defender/domain/blocs/game/game_bloc.dart';

class PauseButtonOverlay extends StatelessWidget {
  const PauseButtonOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: BlocBuilder<GameBloc, GameState>(builder: (context, state) {
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
    );
  }
}
