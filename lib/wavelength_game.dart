import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/components/lassers/guns/double_channel_lasser.dart';
import 'package:wavelength_defender/components/lassers/pointers/double_lasser_pointer.dart';

import 'components/enemy/enemy_component.dart';
import 'components/lassers/guns/single_channel_lasser.dart';
import 'components/lassers/guns/triple_shoot_lasser.dart';

class WavelengthGame extends FlameGame with HasCollisionDetection {
  late final TextComponent scoreText, crashesText;
  late final TimerComponent enemyCreator;
  final Random random = Random();
  List<EnemyComponent> enemies = [];

  int score = 0;
  int crashes = 0;

  @override
  FutureOr<void> onLoad() {
    add(DoublePointerLasser(
        size: Vector2.all(50), position: Vector2(800, 150)));
    //add(ContinuousLasser(position: Vector2(800, 150)));
    // add(ContinuousLasser(position: Vector2(900, 450)));
    // add(CircularLasser(position: Vector2(300, 200)));
    // add(CircularLasser(position: Vector2(1000, 200)));
    add(SingleChannelLasser(
        position: Vector2(400, 500),
        size: Vector2.all(50),
        color: Colors.cyan));
    add(DoubleChannelLasser(
        position: Vector2(600, 500),
        size: Vector2.all(50),
        color: Colors.yellow));
    add(TripleShootLasser(
        position: Vector2(800, 500), size: Vector2.all(50), color: Colors.red));
    // add(SingleChannelLasser(position: Vector2(1100, 500)));
    //add(DubleChannelLasser(position: Vector2(1000, 50)));
    // add(TripleShootLasser(position: Vector2(800, 50)));

    addAll([
      FpsTextComponent(
        position: size - Vector2(0, 75),
        anchor: Anchor.bottomRight,
      ),
      scoreText = TextComponent(
          position: size - Vector2(0, 50),
          anchor: Anchor.bottomRight,
          priority: 1),
      crashesText = TextComponent(
          position: size - Vector2(0, 25),
          anchor: Anchor.bottomRight,
          priority: 1),
    ]);
    add(enemyCreator = TimerComponent(
        period: 5,
        autoStart: true,
        repeat: true,
        onTick: () => generateEnemies(random.nextInt(6) + 6)));
    generateEnemies(random.nextInt(6) + 6);

    super.onLoad();
  }

  @override
  void update(double dt) {
    scoreText.text = "score $score";
    crashesText.text = "crashes $crashes";

    if (score > 50 || crashes > 10) {
      enemyCreator.timer.stop();
    }
    super.update(dt);
  }

  increaseScore() {
    score++;
  }

  generateEnemies(int n) {
    debugPrint("generating $n enemies");
    List<EnemyComponent> newEnemies = [];
    for (int i = 0; i < n; i++) {
      newEnemies.add(EnemyComponent(
          dx: (random.nextDouble() + 0.5) * 200,
          dy: (random.nextDouble() + 0.5) * 100));
    }
    enemies.addAll(newEnemies);
    addAll(newEnemies);
  }
}
