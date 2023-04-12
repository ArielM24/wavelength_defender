import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/components/enemy/enemy_component.dart';
import 'package:wavelength_defender/components/road/road_cell.dart';
import 'package:wavelength_defender/data/lasser_color.dart';
import 'package:wavelength_defender/wavelength_game.dart';

class EnemySpawner extends RoadCell with HasGameRef<WavelengthGame> {
  late TimerComponent timer;
  double spawnDelay;
  bool repeat;
  bool autoStart;
  EnemySpawner(
      {required super.position,
      required super.size,
      this.spawnDelay = 5,
      this.repeat = true,
      this.autoStart = true,
      required super.direction,
      super.roadSpeed})
      : super(color: Colors.red);

  @override
  FutureOr<void> onLoad() {
    timer = TimerComponent(
        period: spawnDelay,
        repeat: repeat,
        autoStart: autoStart,
        onTick: spawnEnemy);
    add(timer);
    super.onLoad();
  }

  spawnEnemy() {
    EnemyComponent enemy =
        EnemyComponent(xp: position.x, yp: position.y, color: LasserColor.red);
    gameRef.add(enemy);
    gameRef.enemies.add(enemy);
  }

  resume() {
    timer.timer.resume();
  }

  pause() {
    timer.timer.pause();
  }
}
