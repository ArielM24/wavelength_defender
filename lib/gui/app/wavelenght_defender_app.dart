import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wavelength_defender/data/repositories/game_repository.dart';
import 'package:wavelength_defender/domain/blocs/game/game_bloc.dart';
import 'package:wavelength_defender/gui/pages/main_menu/main_menu_page.dart';

class WaveLenghtDefenderApp extends StatelessWidget {
  const WaveLenghtDefenderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) => GameBloc(gameRepository: GameRepository()))
      ], child: const MainMenuPage()),
    );
  }
}