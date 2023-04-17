import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wavelength_defender/data/game/level_data.dart';
import 'package:wavelength_defender/data/repositories/game_repository.dart';
part 'game_state.dart';
part 'game_event.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository gameRepository;

  GameBloc({required this.gameRepository})
      : super(const GameState(status: GameStatus.inital)) {
    on<LoadDebugLevel>(_loadDebugLevel);
    on<ContinueLevel>(_continueLevel);
    on<PauseButtonPressed>(_pauseButtonPressed);
    on<ResumeButtonPressed>(_resumeButtonPressed);
    on<LoadAssetLevels>(_loadAssetLevels);
  }

  _loadAssetLevels(LoadAssetLevels event, Emitter<GameState> emitter) async {
    emitter.call(state.copyWith(status: GameStatus.loading));
    bool loaded = await gameRepository.loadLevels();
    if (loaded) {
      emitter.call(state.copyWith(status: GameStatus.loaded));
    } else {
      emitter.call(state.copyWith(status: GameStatus.loaded, hasError: true));
    }
  }

  _loadDebugLevel(LoadDebugLevel event, Emitter<GameState> emitter) {
    emitter.call(state.copyWith(status: GameStatus.loading));
    final debugLevelState = state.copyWith(
        level: gameRepository.debugLevel, status: GameStatus.loaded);
    emitter.call(debugLevelState);
  }

  _pauseButtonPressed(PauseButtonPressed event, Emitter<GameState> emitter) {
    emitter.call(state.copyWith(status: GameStatus.paused));
  }

  _resumeButtonPressed(ResumeButtonPressed event, Emitter<GameState> emitter) {
    emitter.call(state.copyWith(status: GameStatus.running));
  }

  FutureOr<void> _continueLevel(ContinueLevel event, Emitter<GameState> emit) {
    emit.call(state.copyWith(status: GameStatus.loading));
    if (gameRepository.hasLevel) {
      emit.call(state.copyWith(
          status: GameStatus.loaded,
          level: gameRepository.currentLevelData,
          hasError: false));
    } else {
      emit.call(state.copyWith(status: GameStatus.loaded, hasError: true));
    }
  }
}
