import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wavelength_defender/data/repositories/game_repository.dart';
import 'package:wavelength_defender/domain/blocs/game/game_bloc.dart';
import 'package:wavelength_defender/gui/pages/main_menu/main_menu_page.dart';

class WaveLenghtDefenderApp extends StatelessWidget {
  const WaveLenghtDefenderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => GameBloc(gameRepository: GameRepository())
              ..add(LoadAssetLevels()))
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: MainMenuPage()),
    );
  }
}
