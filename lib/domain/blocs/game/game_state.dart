part of 'game_bloc.dart';

enum GameStatus { inital, started, over, running, paused, loading, loaded }

class GameState extends Equatable {
  final GameStatus status;
  final LevelData? level;
  final bool hasError;
  const GameState({required this.status, this.level, this.hasError = false});
  @override
  List<Object?> get props => [status, level, hasError];

  GameState copyWith({GameStatus? status, LevelData? level}) {
    return GameState(status: status ?? this.status, level: level ?? this.level);
  }
}
