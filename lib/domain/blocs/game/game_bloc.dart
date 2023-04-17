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
  }

  _loadDebugLevel(LoadDebugLevel event, Emitter<GameState> emitter) {
    emitter.call(state.copyWith(status: GameStatus.loading));
    final debugLevelState = state.copyWith(
        level: gameRepository.debugLevel, status: GameStatus.loaded);
    emitter.call(debugLevelState);
  }
}
