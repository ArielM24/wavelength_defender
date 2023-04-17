import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/data/game/lasser_color.dart';
import 'package:wavelength_defender/gui/game/components/enemy/enemy_component.dart';
import 'package:wavelength_defender/gui/game/components/road/road_cell.dart';
import 'package:wavelength_defender/gui/game/wavelength_game.dart';

class EnemySpawner extends RoadCell with HasGameRef<WavelengthGame> {
  late TimerComponent timer;
  double spawnDelay;
  bool repeat;
  bool autoStart;
  int? spawnLimit;
  int _spawned = 0;
  EnemySpawner(
      {super.color,
      this.spawnLimit,
      required super.position,
      required super.size,
      this.spawnDelay = 5,
      this.repeat = true,
      this.autoStart = true,
      required super.direction,
      super.roadSpeed});

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

  int get spawned => _spawned;

  spawnEnemy() {
    if (spawnLimit != null) {
      if (_spawned >= spawnLimit!) {
        return;
      }
    }
    _spawned++;
    EnemyComponent enemy =
        EnemyComponent(xp: position.x, yp: position.y, color: LasserColor.red);
    gameRef.add(enemy);
    gameRef.enemies.add(enemy);
    gameRef.totalEnemies++;
  }

  resume() {
    timer.timer.resume();
  }

  pause() {
    timer.timer.pause();
  }
}
