import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:wavelength_defender/components/lassers/guns/double_channel_lasser.dart';
import 'package:wavelength_defender/components/lassers/lights/circular_lasser.dart';
import 'package:wavelength_defender/components/lassers/pointers/double_lasser_pointer.dart';
import 'package:wavelength_defender/components/lassers/pointers/single_lasser_point.dart';
import 'package:wavelength_defender/components/lassers/pointers/triple_lasser_point.dart';
import 'package:wavelength_defender/components/util/enemy_chooser.dart';
import 'package:wavelength_defender/data/lasser_classes.dart';
import 'package:wavelength_defender/data/lasser_color.dart';
import 'package:wavelength_defender/data/lasser_data.dart';
import 'package:wavelength_defender/data/lasser_lens_data.dart';

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
    // add(SingleLasserPoint(
    //     size: Vector2.all(50),
    //     position: Vector2(500, 150),
    //     chooserType: EnemyChooserType.farest));
    // add(TriplePointerLasser(
    //   size: Vector2.all(50),
    //   position: Vector2(800, 150),
    // ));
    // add(SingleChannelLasser(
    //     position: Vector2(400, 500),
    //     size: Vector2.all(50),
    //     color: Colors.cyan,
    //     chooserType: EnemyChooserType.first));
    // add(DoubleChannelLasser(
    //     position: Vector2(600, 500),
    //     size: Vector2.all(50),
    //     color: Colors.orange,
    //     chooserType: EnemyChooserType.nearest));
    // add(TripleShootLasser(
    //     position: Vector2(800, 500),
    //     size: Vector2.all(50),
    //     color: Colors.red,
    //     chooserType: EnemyChooserType.lowest));
    add(CircularLasser(
        position: Vector2(1100, 250),
        size: Vector2.all(100),
        data: LasserData(
          lasserClass: LasserClass.s,
          lensDataB: LasserLensData1(
              lensClass: LasserClass.s, channel: LasserLensChannel.B),
        )));

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
    // add(enemyCreator = TimerComponent(
    //     period: 5,
    //     autoStart: true,
    //     repeat: true,
    //     onTick: () => generateEnemies(random.nextInt(6) + 6)));
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
          color: LasserColor.red,
          dx: (random.nextDouble() + 0.5) * 200,
          dy: (random.nextDouble() + 0.5) * 100));
    }
    enemies.addAll(newEnemies);
    addAll(newEnemies);
  }
}
