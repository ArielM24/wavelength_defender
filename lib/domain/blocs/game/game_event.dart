part of 'game_bloc.dart';

abstract class GameEvent {}

class LoadAssetLevels extends GameEvent {}

class LoadDebugLevel extends GameEvent {}

class PauseButtonPressed extends GameEvent {}

class ResumeButtonPressed extends GameEvent {}

class ContinueLevel extends GameEvent {}
