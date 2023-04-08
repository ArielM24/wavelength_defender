import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/components/lasser/circular_lasser.dart';
import 'package:wavelength_defender/components/lasser/continuous_lasser.dart';
import 'package:wavelength_defender/components/lasser/ray/lasser_ray.dart';
import 'package:wavelength_defender/components/lights/radious_light.dart';

import 'components/enemy/enemy_component.dart';
import 'components/lasser/single_channel_lasser.dart';

class WavelengthGame extends FlameGame with HasCollisionDetection {
  late final TextComponent scoreText, crashesText;
  late final TimerComponent enemyCreator;
  final Random random = Random();
  List<EnemyComponent> enemies = [];

  int score = 0;
  int crashes = 0;

  @override
  FutureOr<void> onLoad() {
    add(ContinuousLasser(position: Vector2(800, 150)));
    add(ContinuousLasser(position: Vector2(900, 450)));
    add(CircularLasser(position: Vector2(300, 200)));
    add(CircularLasser(position: Vector2(1000, 200)));
    add(SingleChannelLasser(position: Vector2(400, 500)));
    add(SingleChannelLasser(position: Vector2(1100, 500)));
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
        onTick: () => generateEnemies(random.nextInt(4) + 3)));
    generateEnemies(random.nextInt(4) + 3);

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
