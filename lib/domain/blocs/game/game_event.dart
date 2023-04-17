part of 'game_bloc.dart';

abstract class GameEvent {}

class LoadDebugLevel extends GameEvent {}

class PauseButtonPressed extends GameEvent {}

class ResumeButtonPressed extends GameEvent {}
