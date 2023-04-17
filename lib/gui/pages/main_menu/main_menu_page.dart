import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wavelength_defender/domain/blocs/game/game_bloc.dart';
import 'package:wavelength_defender/gui/pages/game/wavelength_game_page.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: BlocListener<GameBloc, GameState>(
          listener: (context, state) {
            if (state.status == GameStatus.loaded && state.level != null) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WavelengthGamePage(
                        levelData: state.level!,
                      )));
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Wavelenght Defender",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 34),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    context.read<GameBloc>().add(LoadDebugLevel());
                  },
                  child: const Text("Debug Level")),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    context.read<GameBloc>().add(ContinueLevel());
                  },
                  child: const Text("Continue")),
            ],
          ),
        ),
      ),
    );
  }
}
