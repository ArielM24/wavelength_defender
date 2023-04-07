import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/components/lasser/circular_lasser.dart';
import 'package:wavelength_defender/components/lasser/ray/lasser_ray.dart';
import 'package:wavelength_defender/components/lights/radious_light.dart';

import 'components/enemy/enemy_component.dart';
import 'components/lasser/single_channel_lasser.dart';

class WavelengthGame extends FlameGame with HasCollisionDetection {
  late final SingleChannelLasser lasser1;
  late final TextComponent scoreText, crashesText;
  late final TimerComponent enemyCreator;
  final Random random = Random();
  List<EnemyComponent> enemies = [];

  int score = 0;
  int crashes = 0;

  @override
  FutureOr<void> onLoad() {
    add(CircularLasser());
    add(lasser1 = SingleChannelLasser());
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
    if (enemies.isNotEmpty) {
      //debugPrint("not empty");
      lasser1.lookAt(enemies.first.position);
      // lasser1.add(RotateEffect.to(
      //     lasser1.angleTo(enemies.first.absolutePosition),
      //     LinearEffectController(1)));
      //deleteUnmountedEnemies();
    }

    if (enemies.isEmpty && lasser1.isShooting) {
      //debugPrint("stop");

      lasser1.stopShootingLasser();
    } else if (enemies.isNotEmpty && !lasser1.isShooting) {
      //debugPrint("start");
      lasser1.startShootingLasser();
      lasser1.add(RotateEffect.to(
        lasser1.angleTo(enemies.first.absolutePosition),
        LinearEffectController(1),
      ));
    }
    if (score > 20) {
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
